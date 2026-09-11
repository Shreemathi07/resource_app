import 'package:flutter/material.dart';

class CommunityNetworkScreen extends StatefulWidget {
  const CommunityNetworkScreen({super.key});

  @override
  State<CommunityNetworkScreen> createState() =>
      _CommunityNetworkScreenState();
}

class _CommunityNetworkScreenState extends State<CommunityNetworkScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<String> _tabs = [
    'Overview',
    'Members',
    'Organizations',
    'Partners',
  ];

  final List<String> _filters = [
    'All',
    'Nearby',
    'Verified',
    'Active',
    'Top Rated',
  ];

  final List<_Member> _members = [
    _Member(
      name: 'Ananya Krishnan',
      role: 'Resource Provider',
      location: 'Vellore',
      initials: 'AK',
      rating: 4.9,
      contributions: 42,
      verified: true,
      online: true,
      category: 'Education',
    ),
    _Member(
      name: 'Rahul Mehta',
      role: 'Resource Seeker',
      location: 'Chennai',
      initials: 'RM',
      rating: 4.8,
      contributions: 31,
      verified: true,
      online: true,
      category: 'Technology',
    ),
    _Member(
      name: 'Priya Nair',
      role: 'Community Volunteer',
      location: 'Katpadi',
      initials: 'PN',
      rating: 4.7,
      contributions: 27,
      verified: true,
      online: false,
      category: 'Community',
    ),
    _Member(
      name: 'Arjun Kumar',
      role: 'Resource Provider',
      location: 'Vellore',
      initials: 'AK',
      rating: 4.6,
      contributions: 23,
      verified: false,
      online: true,
      category: 'Equipment',
    ),
  ];

  final List<_Organization> _organizations = [
    _Organization(
      name: 'VIT Community Hub',
      type: 'Educational Community',
      location: 'Vellore',
      initials: 'VH',
      members: 184,
      resources: 67,
      verified: true,
      impact: 92,
    ),
    _Organization(
      name: 'Green Future Foundation',
      type: 'Environmental Organization',
      location: 'Chennai',
      initials: 'GF',
      members: 126,
      resources: 43,
      verified: true,
      impact: 88,
    ),
    _Organization(
      name: 'Helping Hands Network',
      type: 'Community Organization',
      location: 'Katpadi',
      initials: 'HH',
      members: 96,
      resources: 28,
      verified: true,
      impact: 81,
    ),
  ];

  final List<_Partnership> _partnerships = [
    _Partnership(
      title: 'Campus Resource Drive',
      organization: 'VIT Community Hub',
      status: 'Active',
      progress: 0.78,
      people: '42 contributors',
    ),
    _Partnership(
      title: 'Green Equipment Exchange',
      organization: 'Green Future Foundation',
      status: 'Planning',
      progress: 0.42,
      people: '18 contributors',
    ),
    _Partnership(
      title: 'Community Learning Program',
      organization: 'Helping Hands Network',
      status: 'Active',
      progress: 0.64,
      people: '29 contributors',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Community Network',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: _showSearchDialog,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Notifications',
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNetwork,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildNetworkHero(context),
            ),
            SliverToBoxAdapter(
              child: _buildStats(context),
            ),
            SliverToBoxAdapter(
              child: _buildTabs(context),
            ),
            SliverToBoxAdapter(
              child: _buildFilterRow(context),
            ),
            SliverToBoxAdapter(
              child: _buildSelectedContent(context),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNetworkActions,
        icon: const Icon(Icons.hub_rounded),
        label: const Text('Connect'),
      ),
    );
  }

  Widget _buildNetworkHero(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.hub_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Network Live',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Community Network',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover people, organizations and partnerships that can turn unused resources into meaningful impact.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.88),
                height: 1.45,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _heroMetric(
                  context,
                  '2,480',
                  'Members',
                ),
                _heroMetric(
                  context,
                  '126',
                  'Organizations',
                ),
                _heroMetric(
                  context,
                  '684',
                  'Connections',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroMetric(
    BuildContext context,
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: _statCard(
              context,
              Icons.people_alt_outlined,
              '2,480',
              'Active members',
              '+12%',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              context,
              Icons.business_outlined,
              '126',
              'Organizations',
              '+8%',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              context,
              Icons.handshake_outlined,
              '684',
              'Connections',
              '+19%',
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    String growth,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            growth,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _tabs.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final selected = _selectedTab == index;

            return ChoiceChip(
              label: Text(_tabs[index]),
              selected: selected,
              onSelected: (_) {
                setState(() {
                  _selectedTab = index;
                });
              },
              selectedColor: colorScheme.primary,
              labelStyle: TextStyle(
                color: selected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
              side: BorderSide(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
              ),
              backgroundColor: colorScheme.surface,
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          Icon(
            Icons.tune_rounded,
            size: 18,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 7),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final selected = filter == _selectedFilter;

                  return FilterChip(
                    label: Text(filter),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    labelStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent(BuildContext context) {
    switch (_selectedTab) {
      case 1:
        return _buildMembers(context);
      case 2:
        return _buildOrganizations(context);
      case 3:
        return _buildPartnerships(context);
      default:
        return _buildOverview(context);
    }
  }

  Widget _buildOverview(BuildContext context) {
    return Column(
      children: [
        _sectionHeader(
          context,
          'Smart Collaboration',
          'Opportunities detected across your network',
          Icons.auto_awesome_rounded,
        ),
        _buildCollaborationOpportunity(context),
        _sectionHeader(
          context,
          'Active Community',
          'What is happening around you',
          Icons.dynamic_feed_rounded,
        ),
        _buildCommunityActivity(context),
        _sectionHeader(
          context,
          'Top Contributors',
          'Trusted members making a difference',
          Icons.emoji_events_outlined,
        ),
        _buildTopContributors(context),
        _sectionHeader(
          context,
          'Network Growth',
          'Community activity over the last 6 months',
          Icons.insights_rounded,
        ),
        _buildGrowthChart(context),
      ],
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 19,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollaborationOpportunity(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: colorScheme.secondaryContainer.withValues(alpha: 0.55),
          border: Border.all(
            color: colorScheme.secondary.withValues(alpha: 0.22),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'High-value connection found',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  '94%',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'VIT Community Hub needs 25 refurbished laptops, while a nearby verified provider has matching equipment available.',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _miniTag(
                  context,
                  Icons.location_on_outlined,
                  '3.2 km away',
                ),
                const SizedBox(width: 7),
                _miniTag(
                  context,
                  Icons.verified_outlined,
                  'Verified',
                ),
                const SizedBox(width: 7),
                _miniTag(
                  context,
                  Icons.bolt_rounded,
                  'Urgent',
                ),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showSnackBar(
                        'Opportunity saved to your network.',
                      );
                    },
                    icon: const Icon(Icons.bookmark_border_rounded),
                    label: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      _showSnackBar(
                        'Connection request sent.',
                      );
                    },
                    icon: const Icon(Icons.handshake_outlined),
                    label: const Text('Connect'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniTag(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityActivity(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _activityTile(
            context,
            Icons.add_circle_outline_rounded,
            '18 new resources added',
            'Members added educational equipment to the network.',
            '12 min ago',
          ),
          _activityTile(
            context,
            Icons.handshake_outlined,
            '7 exchanges completed',
            'Community members successfully completed exchanges.',
            '48 min ago',
          ),
          _activityTile(
            context,
            Icons.groups_outlined,
            'New organization joined',
            'Helping Hands Network joined the community.',
            '2 hrs ago',
          ),
        ],
      ),
    );
  }

  Widget _activityTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String time,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 19,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.35,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(
              fontSize: 9,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopContributors(BuildContext context) {
    final top = _members.take(3).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int index = 0; index < top.length; index++)
            _contributorCard(
              context,
              top[index],
              index + 1,
            ),
        ],
      ),
    );
  }

  Widget _contributorCard(
    BuildContext context,
    _Member member,
    int rank,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showMemberDetails(member),
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.primary,
                ),
              ),
            ),
            _avatar(
              context,
              member.initials,
              size: 45,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          member.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (member.verified) ...[
                        const SizedBox(width: 5),
                        Icon(
                          Icons.verified,
                          size: 15,
                          color: colorScheme.primary,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${member.contributions} contributions • ${member.location}',
                    style: TextStyle(
                      fontSize: 10,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 15,
                      color: Colors.amber,
                    ),
                    Text(
                      member.rating.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Trusted',
                  style: TextStyle(
                    fontSize: 9,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthChart(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final values = [0.38, 0.47, 0.53, 0.64, 0.76, 0.92];
    final months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.32),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Network activity',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  '+31.4%',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int index = 0; index < values.length; index++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${(values[index] * 100).round()}%',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 5),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: 105 * values[index],
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withValues(
                                  alpha: 0.25 + (values[index] * 0.6),
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(9),
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              months[index],
                              style: TextStyle(
                                fontSize: 9,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembers(BuildContext context) {
    final filtered = _members.where((member) {
      final matchesSearch = _searchQuery.isEmpty ||
          member.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          member.category.toLowerCase().contains(_searchQuery.toLowerCase());

      if (_selectedFilter == 'Verified') {
        return matchesSearch && member.verified;
      }

      if (_selectedFilter == 'Active') {
        return matchesSearch && member.online;
      }

      if (_selectedFilter == 'Top Rated') {
        return matchesSearch && member.rating >= 4.8;
      }

      return matchesSearch;
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: [
          _listSummary(
            context,
            '${filtered.length} members discovered',
            'People contributing to ResourceX',
          ),
          for (final member in filtered)
            _memberCard(context, member),
          if (filtered.isEmpty)
            _emptyState(
              context,
              Icons.people_outline_rounded,
              'No members found',
              'Try changing the search or filter.',
            ),
        ],
      ),
    );
  }

  Widget _memberCard(BuildContext context, _Member member) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showMemberDetails(member),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                _avatar(
                  context,
                  member.initials,
                  size: 52,
                ),
                if (member.online)
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
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
                          member.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (member.verified) ...[
                        const SizedBox(width: 5),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member.role,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        member.location,
                        style: TextStyle(
                          fontSize: 10,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        member.rating.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                _showSnackBar(
                  'Connection request sent to ${member.name}.',
                );
              },
              icon: const Icon(Icons.person_add_alt_1_rounded),
              tooltip: 'Connect',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizations(BuildContext context) {
    final filtered = _organizations.where((organization) {
      final matchesSearch = _searchQuery.isEmpty ||
          organization.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
          organization.type.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );

      if (_selectedFilter == 'Verified') {
        return matchesSearch && organization.verified;
      }

      if (_selectedFilter == 'Top Rated') {
        return matchesSearch && organization.impact >= 85;
      }

      return matchesSearch;
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: [
          _listSummary(
            context,
            '${filtered.length} organizations',
            'Verified communities and institutions',
          ),
          for (final organization in filtered)
            _organizationCard(context, organization),
          if (filtered.isEmpty)
            _emptyState(
              context,
              Icons.business_outlined,
              'No organizations found',
              'Try another search or filter.',
            ),
        ],
      ),
    );
  }

  Widget _organizationCard(
    BuildContext context,
    _Organization organization,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(21),
      onTap: () => _showOrganizationDetails(organization),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _avatar(
                  context,
                  organization.initials,
                  size: 55,
                  square: true,
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
                              organization.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          if (organization.verified) ...[
                            const SizedBox(width: 5),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        organization.type,
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            organization.location,
                            style: TextStyle(
                              fontSize: 10,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showSnackBar(
                      'Partnership interest sent.',
                    );
                  },
                  icon: const Icon(Icons.handshake_outlined),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _organizationMetric(
                  context,
                  '${organization.members}',
                  'Members',
                ),
                _organizationMetric(
                  context,
                  '${organization.resources}',
                  'Resources',
                ),
                _organizationMetric(
                  context,
                  '${organization.impact}%',
                  'Impact',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _organizationMetric(
    BuildContext context,
    String value,
    String label,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerships(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: [
          _listSummary(
            context,
            '${_partnerships.length} active opportunities',
            'Collaborations across the network',
          ),
          for (final partnership in _partnerships)
            _partnershipCard(context, partnership),
          _buildPartnershipSuggestion(context),
        ],
      ),
    );
  }

  Widget _partnershipCard(
    BuildContext context,
    _Partnership partnership,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.handshake_rounded,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partnership.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      partnership.organization,
                      style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _statusChip(
                context,
                partnership.status,
              ),
            ],
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                '${(partnership.progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: partnership.progress,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.people_outline_rounded,
                size: 15,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Text(
                partnership.people,
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _showSnackBar(
                    'Partnership details opened.',
                  );
                },
                child: const Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(BuildContext context, String status) {
    final colorScheme = Theme.of(context).colorScheme;

    final active = status == 'Active';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: (active ? colorScheme.primary : Colors.orange)
            .withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: active ? colorScheme.primary : Colors.orange,
        ),
      ),
    );
  }

  Widget _buildPartnershipSuggestion(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: colorScheme.primaryContainer.withValues(alpha: 0.55),
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: colorScheme.primary,
            size: 27,
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build a new partnership',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ResourceX found organizations with complementary needs.',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showSnackBar(
                'Opening partnership suggestions.',
              );
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _listSummary(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showSortOptions,
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 45,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(
    BuildContext context,
    String initials, {
    double size = 50,
    bool square = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          square ? 15 : size / 2,
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w900,
          fontSize: size * 0.28,
        ),
      ),
    );
  }

  void _showMemberDetails(_Member member) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final colorScheme = Theme.of(sheetContext).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _avatar(
                sheetContext,
                member.initials,
                size: 72,
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  if (member.verified) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.verified,
                      color: colorScheme.primary,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 5),
              Text(
                member.role,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _detailMetric(
                    sheetContext,
                    '${member.rating}',
                    'Rating',
                  ),
                  _detailMetric(
                    sheetContext,
                    '${member.contributions}',
                    'Contributions',
                  ),
                  _detailMetric(
                    sheetContext,
                    member.location,
                    'Location',
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Connection request sent to ${member.name}.',
                    );
                  },
                  icon: const Icon(Icons.handshake_outlined),
                  label: const Text('Connect with member'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Profile shared.',
                    );
                  },
                  icon: const Icon(Icons.share_outlined),
                  label: const Text('Share profile'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailMetric(
    BuildContext context,
    String value,
    String label,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showOrganizationDetails(
    _Organization organization,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final colorScheme = Theme.of(sheetContext).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _avatar(
                sheetContext,
                organization.initials,
                size: 70,
                square: true,
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      organization.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  if (organization.verified) ...[
                    const SizedBox(width: 5),
                    Icon(
                      Icons.verified,
                      color: colorScheme.primary,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 5),
              Text(
                organization.type,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _detailMetric(
                    sheetContext,
                    '${organization.members}',
                    'Members',
                  ),
                  _detailMetric(
                    sheetContext,
                    '${organization.resources}',
                    'Resources',
                  ),
                  _detailMetric(
                    sheetContext,
                    '${organization.impact}%',
                    'Impact',
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Partnership request sent to ${organization.name}.',
                    );
                  },
                  icon: const Icon(Icons.handshake_outlined),
                  label: const Text('Start partnership'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSearchDialog() {
    final controller = TextEditingController(
      text: _searchQuery,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Search Network',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search members or organizations',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onSubmitted: (_) {
              setState(() {
                _searchQuery = controller.text.trim();
              });
              Navigator.pop(dialogContext);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  _searchQuery = controller.text.trim();
                });
                Navigator.pop(dialogContext);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final options = [
          'Most relevant',
          'Highest rated',
          'Most active',
          'Nearest',
          'Recently joined',
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sort by',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                for (final option in options)
                  ListTile(
                    leading: const Icon(Icons.sort_rounded),
                    title: Text(option),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _showSnackBar(
                        'Sorted by $option.',
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNetworkActions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Grow your network',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 14),
                _actionTile(
                  sheetContext,
                  Icons.person_add_alt_1_rounded,
                  'Invite a member',
                  'Invite people who can contribute resources.',
                  () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Invite flow opened.',
                    );
                  },
                ),
                _actionTile(
                  sheetContext,
                  Icons.business_outlined,
                  'Invite an organization',
                  'Bring a community or institution to ResourceX.',
                  () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Organization invitation opened.',
                    );
                  },
                ),
                _actionTile(
                  sheetContext,
                  Icons.handshake_outlined,
                  'Create partnership',
                  'Start a collaboration with another organization.',
                  () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Partnership creation opened.',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 3),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
      ),
      onTap: onTap,
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Network Notifications',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  sheetContext,
                  Icons.handshake_rounded,
                  'New partnership opportunity',
                  'A verified organization wants to collaborate.',
                ),
                _notificationItem(
                  sheetContext,
                  Icons.person_add_alt_1_rounded,
                  'New connection request',
                  'Someone nearby wants to connect with you.',
                ),
                _notificationItem(
                  sheetContext,
                  Icons.trending_up_rounded,
                  'Network milestone',
                  'Your community reached 2,400 active members.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _notificationItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(
          icon,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }

  Future<void> _refreshNetwork() async {
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    _showSnackBar(
      'Community network refreshed.',
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _Member {
  final String name;
  final String role;
  final String location;
  final String initials;
  final double rating;
  final int contributions;
  final bool verified;
  final bool online;
  final String category;

  const _Member({
    required this.name,
    required this.role,
    required this.location,
    required this.initials,
    required this.rating,
    required this.contributions,
    required this.verified,
    required this.online,
    required this.category,
  });
}

class _Organization {
  final String name;
  final String type;
  final String location;
  final String initials;
  final int members;
  final int resources;
  final bool verified;
  final int impact;

  const _Organization({
    required this.name,
    required this.type,
    required this.location,
    required this.initials,
    required this.members,
    required this.resources,
    required this.verified,
    required this.impact,
  });
}

class _Partnership {
  final String title;
  final String organization;
  final String status;
  final double progress;
  final String people;

  const _Partnership({
    required this.title,
    required this.organization,
    required this.status,
    required this.progress,
    required this.people,
  });
}