import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String _selectedFilter = 'Overview';
  String _searchQuery = '';

  final List<_AdminUser> _users = [
    _AdminUser(
      name: 'Arjun Kumar',
      role: 'Resource Provider',
      location: 'Vellore',
      verified: true,
      status: 'Active',
      resources: 18,
    ),
    _AdminUser(
      name: 'Priya Sharma',
      role: 'Resource Seeker',
      location: 'Chennai',
      verified: true,
      status: 'Active',
      resources: 6,
    ),
    _AdminUser(
      name: 'Green Future Foundation',
      role: 'Organization',
      location: 'Bengaluru',
      verified: true,
      status: 'Active',
      resources: 42,
    ),
    _AdminUser(
      name: 'Rahul Menon',
      role: 'Resource Provider',
      location: 'Coimbatore',
      verified: false,
      status: 'Pending',
      resources: 11,
    ),
  ];

  final List<_AdminIssue> _issues = [
    _AdminIssue(
      title: 'Resource quality concern',
      reporter: 'Priya Sharma',
      type: 'Resource',
      priority: 'High',
      time: '18 min ago',
    ),
    _AdminIssue(
      title: 'Duplicate requirement',
      reporter: 'Green Future Foundation',
      type: 'Requirement',
      priority: 'Medium',
      time: '1 hour ago',
    ),
    _AdminIssue(
      title: 'Verification request',
      reporter: 'Rahul Menon',
      type: 'Account',
      priority: 'Low',
      time: '3 hours ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Admin Control Center',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: _showSearchDialog,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Admin notifications',
            onPressed: _showAdminNotifications,
            icon: Badge(
              label: const Text('4'),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDashboard,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            _buildAdminBanner(context),
            const SizedBox(height: 18),
            _buildFilterBar(context),
            const SizedBox(height: 18),
            _buildPlatformOverview(context),
            const SizedBox(height: 22),
            _buildSectionTitle(
              context,
              'Quick administration',
              'Frequently used controls',
            ),
            const SizedBox(height: 12),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildSectionTitle(
              context,
              'Platform health',
              'Live operational indicators',
            ),
            const SizedBox(height: 12),
            _buildHealthPanel(context),
            const SizedBox(height: 24),
            _buildSectionTitle(
              context,
              'Moderation queue',
              'Items that need administrator attention',
            ),
            const SizedBox(height: 12),
            _buildModerationQueue(context),
            const SizedBox(height: 24),
            _buildSectionTitle(
              context,
              'Member management',
              'Recent accounts and verification status',
            ),
            const SizedBox(height: 12),
            _buildUsersPanel(context),
            const SizedBox(height: 24),
            _buildSectionTitle(
              context,
              'Exchange monitoring',
              'Current resource exchange activity',
            ),
            const SizedBox(height: 12),
            _buildExchangeMonitoring(context),
            const SizedBox(height: 24),
            _buildSectionTitle(
              context,
              'Admin tools',
              'Platform-level configuration',
            ),
            const SizedBox(height: 12),
            _buildAdminTools(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminBanner(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.72),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ResourceX Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Monitor members, exchanges, resources and platform safety.',
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final filters = [
      'Overview',
      'Members',
      'Resources',
      'Requirements',
      'Exchanges',
      'Issues',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = _selectedFilter == filter;

          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });

              if (filter != 'Overview') {
                _showComingSoon(filter);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildPlatformOverview(BuildContext context) {
    final theme = Theme.of(context);

    final stats = [
      _AdminStat(
        '1,284',
        'Members',
        Icons.people_alt_rounded,
      ),
      _AdminStat(
        '3,842',
        'Resources',
        Icons.inventory_2_rounded,
      ),
      _AdminStat(
        '1,967',
        'Requirements',
        Icons.assignment_rounded,
      ),
      _AdminStat(
        '892',
        'Exchanges',
        Icons.swap_horizontal_circle_rounded,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Platform overview',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.55,
          ),
          itemBuilder: (context, index) {
            final stat = stats[index];

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    stat.icon,
                    color: theme.colorScheme.primary,
                    size: 25,
                  ),
                  const Spacer(),
                  Text(
                    stat.value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stat.label,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _AdminAction(
        'Manage members',
        'Users & roles',
        Icons.manage_accounts_rounded,
      ),
      _AdminAction(
        'Review resources',
        'Moderation',
        Icons.fact_check_rounded,
      ),
      _AdminAction(
        'Verify accounts',
        '12 pending',
        Icons.verified_user_rounded,
      ),
      _AdminAction(
        'View reports',
        '3 unresolved',
        Icons.report_problem_rounded,
      ),
      _AdminAction(
        'Requirements',
        'Needs monitoring',
        Icons.assignment_late_rounded,
      ),
      _AdminAction(
        'Exchange control',
        'Live activity',
        Icons.sync_alt_rounded,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];

        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _handleAdminAction(action.title),
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    action.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  action.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  action.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHealthPanel(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          _buildHealthRow(
            context,
            'Resource verification',
            '98.4%',
            0.984,
            Icons.verified_rounded,
          ),
          const SizedBox(height: 18),
          _buildHealthRow(
            context,
            'Successful matches',
            '91.7%',
            0.917,
            Icons.auto_awesome_rounded,
          ),
          const SizedBox(height: 18),
          _buildHealthRow(
            context,
            'Completed exchanges',
            '87.2%',
            0.872,
            Icons.check_circle_rounded,
          ),
          const SizedBox(height: 18),
          _buildHealthRow(
            context,
            'Member satisfaction',
            '94.6%',
            0.946,
            Icons.sentiment_satisfied_alt_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildHealthRow(
    BuildContext context,
    String title,
    String value,
    double progress,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModerationQueue(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: _issues.map((issue) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _priorityColor(
                    theme,
                    issue.priority,
                  ).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _issueIcon(issue.type),
                  color: _priorityColor(theme, issue.priority),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      issue.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${issue.reporter} • ${issue.type}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      issue.time,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _priorityBadge(context, issue.priority),
                  const SizedBox(height: 7),
                  TextButton(
                    onPressed: () => _showIssueDetails(issue),
                    child: const Text('Review'),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _priorityBadge(BuildContext context, String priority) {
    final theme = Theme.of(context);
    final color = _priorityColor(theme, priority);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildUsersPanel(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: _users.map((user) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text(
                  _initials(user.name),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (user.verified) ...[
                          const SizedBox(width: 5),
                          Icon(
                            Icons.verified_rounded,
                            size: 17,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.role,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${user.location} • ${user.resources} resources',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _statusBadge(context, user.status),
                  const SizedBox(height: 5),
                  IconButton(
                    tooltip: 'Manage member',
                    onPressed: () => _showUserDetails(user),
                    icon: const Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _statusBadge(BuildContext context, String status) {
    final theme = Theme.of(context);
    final active = status == 'Active';

    final color = active
        ? Colors.green
        : theme.colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildExchangeMonitoring(BuildContext context) {
    final theme = Theme.of(context);

    final exchanges = [
      ('Office chairs', 'Arjun Kumar → Green Future Foundation', 'In transit'),
      ('School books', 'Vellore Learning Hub → Hope Centre', 'Scheduled'),
      ('Food supplies', 'FreshMart → Community Kitchen', 'Completed'),
      ('Laptops', 'TechCircle → Digital Skills Lab', 'Pickup today'),
    ];

    return Column(
      children: exchanges.map((exchange) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exchange.$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exchange.$2,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  exchange.$3,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAdminTools(BuildContext context) {
    final tools = [
      _ToolItem(
        'Verification center',
        'Review identity and organization verification',
        Icons.verified_user_outlined,
      ),
      _ToolItem(
        'Platform analytics',
        'View usage, matching and impact metrics',
        Icons.analytics_outlined,
      ),
      _ToolItem(
        'Safety controls',
        'Moderation rules and community protection',
        Icons.shield_outlined,
      ),
      _ToolItem(
        'Matching configuration',
        'Configure intelligent matching preferences',
        Icons.auto_awesome_outlined,
      ),
      _ToolItem(
        'System activity',
        'Review important administrative events',
        Icons.history_rounded,
      ),
    ];

    return Column(
      children: tools.map((tool) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            leading: CircleAvatar(
              child: Icon(tool.icon),
            ),
            title: Text(
              tool.title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(tool.subtitle),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _handleAdminAction(tool.title),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _handleAdminAction(String action) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.admin_panel_settings_rounded,
                  size: 42,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  action,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This administration module is ready for backend integration. '
                  'The current version demonstrates the complete front-end workflow.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text('$action opened'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showIssueDetails(_AdminIssue issue) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Reported by: ${issue.reporter}'),
                Text('Category: ${issue.type}'),
                Text('Priority: ${issue.priority}'),
                Text('Reported: ${issue.time}'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Dismiss'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text('Issue marked for review'),
                            ),
                          );
                        },
                        child: const Text('Take action'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUserDetails(_AdminUser user) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 32,
                  child: Text(
                    _initials(user.name),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(user.role),
                const SizedBox(height: 14),
                _detailRow(
                  context,
                  Icons.location_on_outlined,
                  'Location',
                  user.location,
                ),
                _detailRow(
                  context,
                  Icons.inventory_2_outlined,
                  'Resources',
                  '${user.resources}',
                ),
                _detailRow(
                  context,
                  Icons.verified_outlined,
                  'Verification',
                  user.verified ? 'Verified' : 'Pending',
                ),
                _detailRow(
                  context,
                  Icons.circle_outlined,
                  'Account status',
                  user.status,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text('Managing ${user.name}'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.manage_accounts_rounded),
                    label: const Text('Manage member'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    final controller = TextEditingController(text: _searchQuery);

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search administration'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Members, resources, issues...',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onSubmitted: (_) {
              setState(() {
                _searchQuery = controller.text.trim();
              });
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  _searchQuery = controller.text.trim();
                });
                Navigator.pop(context);

                if (_searchQuery.isNotEmpty) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Searching for "$_searchQuery"',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _showAdminNotifications() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: const [
              Text(
                'Admin alerts',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.warning_amber_rounded),
                title: Text('3 reports need review'),
                subtitle: Text('Moderation queue'),
              ),
              ListTile(
                leading: Icon(Icons.verified_user_outlined),
                title: Text('12 verification requests'),
                subtitle: Text('Verification center'),
              ),
              ListTile(
                leading: Icon(Icons.inventory_2_outlined),
                title: Text('8 resources awaiting approval'),
                subtitle: Text('Resource moderation'),
              ),
              ListTile(
                leading: Icon(Icons.sync_alt_rounded),
                title: Text('5 exchanges require attention'),
                subtitle: Text('Exchange monitoring'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showComingSoon(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$section management selected — ready for backend integration.',
        ),
      ),
    );
  }

  Future<void> _refreshDashboard() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Admin dashboard refreshed'),
      ),
    );
  }

  Color _priorityColor(ThemeData theme, String priority) {
    switch (priority) {
      case 'High':
        return theme.colorScheme.error;
      case 'Medium':
        return Colors.orange;
      default:
        return theme.colorScheme.primary;
    }
  }

  IconData _issueIcon(String type) {
    switch (type) {
      case 'Resource':
        return Icons.inventory_2_outlined;
      case 'Requirement':
        return Icons.assignment_outlined;
      default:
        return Icons.person_outline_rounded;
    }
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}

class _AdminStat {
  final String value;
  final String label;
  final IconData icon;

  const _AdminStat(
    this.value,
    this.label,
    this.icon,
  );
}

class _AdminAction {
  final String title;
  final String subtitle;
  final IconData icon;

  const _AdminAction(
    this.title,
    this.subtitle,
    this.icon,
  );
}

class _ToolItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ToolItem(
    this.title,
    this.subtitle,
    this.icon,
  );
}

class _AdminUser {
  final String name;
  final String role;
  final String location;
  final bool verified;
  final String status;
  final int resources;

  const _AdminUser({
    required this.name,
    required this.role,
    required this.location,
    required this.verified,
    required this.status,
    required this.resources,
  });
}

class _AdminIssue {
  final String title;
  final String reporter;
  final String type;
  final String priority;
  final String time;

  const _AdminIssue({
    required this.title,
    required this.reporter,
    required this.type,
    required this.priority,
    required this.time,
  });
}