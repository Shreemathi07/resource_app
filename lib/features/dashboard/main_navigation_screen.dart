import 'package:flutter/material.dart';

import '../matching/matches_screen.dart';
import '../messages/messages_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../resources/provider_resources_screen.dart';
import '../resources/resources_screen.dart';
import '../requirements/requirements_screen.dart';
import '../exchange/exchange_center_screen.dart';
import '../impact/impact_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
    this.role = 'Resource Provider',
  });

  final String role;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  bool get _isProvider => widget.role == 'Resource Provider';
  bool get _isSeeker => widget.role == 'Resource Seeker';
  bool get _isOrganization => widget.role == 'Organization';

  @override
  Widget build(BuildContext context) {
    final screens = _buildScreens();
    final destinations = _buildDestinations();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: destinations,
      ),
    );
  }

  List<Widget> _buildScreens() {
    if (_isSeeker) {
      return [
        _RoleHome(
          role: widget.role,
          title: 'Find resources that move your work forward.',
          subtitle: 'Discover nearby resources, post requirements and connect with trusted providers.',
          stats: const [('Open needs', '4'), ('Matches', '12'), ('Received', '6')],
          primaryAction: 'Post a requirement',
          secondaryAction: 'Browse resources',
          primaryPage: const RequirementsScreen(),
          secondaryPage: const ResourcesScreen(role: 'Resource Seeker'),
        ),
        const ResourcesScreen(role: 'Resource Seeker'),
        const RequirementsScreen(),
        const MessagesScreen(),
        ProfileScreen(role: widget.role),
      ];
    }

    if (_isOrganization) {
      return [
        _RoleHome(
          role: widget.role,
          title: 'Coordinate resources at community scale.',
          subtitle: 'Manage inventory, coordinate requirements and build reliable resource partnerships.',
          stats: const [('Inventory', '42'), ('Needs', '9'), ('Partners', '18')],
          primaryAction: 'Manage inventory',
          secondaryAction: 'View requirements',
          primaryPage: const ProviderResourcesScreen(),
          secondaryPage: const RequirementsScreen(),
        ),
        const ProviderResourcesScreen(),
        const RequirementsScreen(),
        const ExchangeCenterScreen(),
        ProfileScreen(role: widget.role),
      ];
    }

    return [
      _RoleHome(
        role: widget.role,
        title: 'Turn your surplus into real impact.',
        subtitle: 'Share resources, respond to strong matches and keep every exchange organized.',
        stats: const [('Resources', '18'), ('Matches', '12'), ('Exchanges', '7')],
        primaryAction: 'Add a resource',
        secondaryAction: 'View my resources',
        primaryPage: const ResourcesScreen(role: 'Resource Provider'),
        secondaryPage: const ProviderResourcesScreen(),
      ),
      const ResourcesScreen(role: 'Resource Provider'),
      const MatchesScreen(role: 'Resource Provider'),
      const MessagesScreen(),
      ProfileScreen(role: widget.role),
    ];
  }

  List<NavigationDestination> _buildDestinations() {
    if (_isSeeker) {
      return const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search_rounded), label: 'Discover'),
        NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment_rounded), label: 'Needs'),
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), selectedIcon: Icon(Icons.chat_bubble_rounded), label: 'Messages'),
        NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ];
    }

    if (_isOrganization) {
      return const [
        NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: 'Overview'),
        NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2_rounded), label: 'Inventory'),
        NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment_rounded), label: 'Needs'),
        NavigationDestination(icon: Icon(Icons.swap_horizontal_circle_outlined), selectedIcon: Icon(Icons.swap_horizontal_circle_rounded), label: 'Exchanges'),
        NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ];
    }

    return const [
      NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2_rounded), label: 'Resources'),
      NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome_rounded), label: 'Matches'),
      NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), selectedIcon: Icon(Icons.chat_bubble_rounded), label: 'Messages'),
      NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
    ];
  }
}

class _RoleHome extends StatelessWidget {
  const _RoleHome({
    required this.role,
    required this.title,
    required this.subtitle,
    required this.stats,
    required this.primaryAction,
    required this.secondaryAction,
    required this.primaryPage,
    required this.secondaryPage,
  });

  final String role;
  final String title;
  final String subtitle;
  final List<(String, String)> stats;
  final String primaryAction;
  final String secondaryAction;
  final Widget primaryPage;
  final Widget secondaryPage;

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSeeker = role == 'Resource Seeker';
    final isOrg = role == 'Organization';

    return Scaffold(
      appBar: AppBar(
        title: const Text('ResourceX', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => _open(context, const NotificationsScreen()),
            icon: const Badge(label: Text('3'), child: Icon(Icons.notifications_none_rounded)),
          ),
          IconButton(
            tooltip: 'Profile',
            onPressed: () => _open(context, ProfileScreen(role: role)),
            icon: const Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(colors: [scheme.primary, scheme.secondary]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: scheme.onPrimary.withAlpha(35),
                        child: Icon(
                          isSeeker ? Icons.search_rounded : isOrg ? Icons.business_rounded : Icons.volunteer_activism_rounded,
                          color: scheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(role, style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.w800))),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text('Good evening 👋', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 6),
                  Text(title, style: TextStyle(color: scheme.onPrimary, fontSize: 27, height: 1.12, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  Text(subtitle, style: TextStyle(color: scheme.onPrimary.withAlpha(215), height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Today at a glance', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            Row(
              children: [
                for (var i = 0; i < stats.length; i++) ...[
                  if (i > 0) const SizedBox(width: 10),
                  Expanded(child: _Stat(value: stats[i].$2, label: stats[i].$1, icon: _statIcon(i, isSeeker, isOrg),)),
                ],
              ],
            ),
            const SizedBox(height: 24),
            const Text('Quick actions', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            _ActionCard(icon: isSeeker ?Icons.assignment_outlined: isOrg ? Icons.inventory_rounded : Icons.add_box_outlined, title: primaryAction, subtitle: isSeeker ? 'Tell providers exactly what you need.' : isOrg ? 'Review and organize shared inventory.' : 'List something useful for the community.', onTap: () => _open(context, primaryPage)),
            const SizedBox(height: 12),
            _ActionCard(icon: isSeeker ? Icons.search_rounded : isOrg ? Icons.assignment_rounded : Icons.inventory_2_outlined, title: secondaryAction, subtitle: isSeeker ? 'Search available resources and compare options.' : isOrg ? 'Track outstanding community requirements.' : 'Review availability, matches and activity.', onTap: () => _open(context, secondaryPage)),
            const SizedBox(height: 24),
            Text(isSeeker ? 'Recommended for you' : isOrg ? 'Partnership pulse' : 'Resource performance', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            _InfoCard(
              icon: isSeeker ? Icons.auto_awesome_rounded : isOrg ? Icons.hub_outlined : Icons.trending_up_rounded,
              title: isSeeker ? '3 strong matches found' : isOrg ? '5 partners are active this week' : 'Your resource views are up 18%',
              subtitle: isSeeker ? 'Two technology resources are within 5 km.' : isOrg ? '12 exchanges are currently being coordinated.' : 'Your laptop and furniture listings are getting attention.',
            ),
            const SizedBox(height: 12),
            _InfoCard(
              icon: Icons.schedule_rounded,
              title: isSeeker ? '2 requirements need an update' : isOrg ? '4 approvals need review' : '2 resources expire soon',
              subtitle: isSeeker ? 'Update quantities or deadlines to improve matching.' : isOrg ? 'Keep inventory and requirement records current.' : 'Extend availability or close completed listings.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _open(context, const NotificationsScreen()),
              icon: const Icon(Icons.notifications_active_outlined),
              label: const Text('Review latest updates'),
            ),
          ],
        ),
      ),
    );
  }

  static IconData _statIcon(int index, bool seeker, bool org) {
    if (seeker) {
      return [Icons.assignment_outlined, Icons.auto_awesome_outlined, Icons.call_received_outlined][index];
    }
    if (org) {
      return [Icons.inventory_2_outlined, Icons.assignment_outlined, Icons.groups_outlined][index];
    }
    return [Icons.inventory_2_outlined, Icons.auto_awesome_outlined, Icons.handshake_outlined][index];
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.icon});
  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: scheme.primary, size: 20),
        const SizedBox(height: 10),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        Text(label, style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant)),
      ]),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(15)), child: Icon(icon, color: scheme.primary)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12, height: 1.35)),
            ])),
            const Icon(Icons.chevron_right_rounded),
          ]),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(20), border: Border.all(color: scheme.outlineVariant)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: scheme.primary)),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12, height: 1.35)),
        ])),
      ]),
    );
  }
}
