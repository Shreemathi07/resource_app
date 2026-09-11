import 'package:flutter/material.dart';

class ResourceCampaignsScreen extends StatefulWidget {
  const ResourceCampaignsScreen({super.key});

  @override
  State<ResourceCampaignsScreen> createState() =>
      _ResourceCampaignsScreenState();
}

class _ResourceCampaignsScreenState extends State<ResourceCampaignsScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Discover',
    'My Campaigns',
    'Participating',
    'Completed',
  ];

  final List<Map<String, dynamic>> _campaigns = [
    {
      'title': 'Back to School Drive 2026',
      'organization': 'VIT Resource Hub',
      'category': 'Education',
      'description':
          'Collect reusable books, stationery and learning resources for students.',
      'progress': 0.78,
      'collected': '1,248',
      'target': '1,600',
      'participants': '86',
      'days': '6 days left',
      'location': 'Vellore',
      'status': 'Active',
      'icon': Icons.school_rounded,
    },
    {
      'title': 'Digital Access Initiative',
      'organization': 'Community Tech Network',
      'category': 'Technology',
      'description':
          'Redistribute working laptops, tablets and accessories to learners.',
      'progress': 0.61,
      'collected': '37',
      'target': '60',
      'participants': '42',
      'days': '12 days left',
      'location': 'Katpadi',
      'status': 'Active',
      'icon': Icons.devices_rounded,
    },
    {
      'title': 'Campus Furniture Revival',
      'organization': 'Green Campus Collective',
      'category': 'Furniture',
      'description':
          'Recover usable study tables and chairs before the new semester.',
      'progress': 0.44,
      'collected': '22',
      'target': '50',
      'participants': '31',
      'days': '18 days left',
      'location': 'Vellore',
      'status': 'Active',
      'icon': Icons.chair_rounded,
    },
    {
      'title': 'Winter Essentials Collection',
      'organization': 'Student Volunteer Network',
      'category': 'Community',
      'description':
          'Coordinate useful clothing and essential resources for communities.',
      'progress': 0.92,
      'collected': '920',
      'target': '1,000',
      'participants': '74',
      'days': '2 days left',
      'location': 'Ranipet',
      'status': 'Urgent',
      'icon': Icons.volunteer_activism_rounded,
    },
  ];

  final List<Map<String, dynamic>> _myCampaigns = [
    {
      'title': 'Engineering Book Redistribution',
      'category': 'Education',
      'progress': 0.84,
      'collected': '420',
      'target': '500',
      'participants': '29',
      'status': 'Active',
      'icon': Icons.menu_book_rounded,
    },
    {
      'title': 'Lab Equipment Recovery',
      'category': 'Technology',
      'progress': 0.56,
      'collected': '14',
      'target': '25',
      'participants': '18',
      'status': 'Active',
      'icon': Icons.science_rounded,
    },
  ];

  final List<Map<String, dynamic>> _participating = [
    {
      'title': 'Digital Access Initiative',
      'organization': 'Community Tech Network',
      'progress': 0.61,
      'role': 'Contributor',
      'icon': Icons.devices_rounded,
    },
    {
      'title': 'Back to School Drive 2026',
      'organization': 'VIT Resource Hub',
      'progress': 0.78,
      'role': 'Volunteer',
      'icon': Icons.school_rounded,
    },
  ];

  final List<Map<String, dynamic>> _completed = [
    {
      'title': 'Campus Stationery Recovery',
      'organization': 'VIT Sustainability Cell',
      'result': '860 items redistributed',
      'impact': '142 students supported',
      'icon': Icons.edit_note_rounded,
    },
    {
      'title': 'Community Computer Drive',
      'organization': 'Tech for Everyone',
      'result': '28 devices redistributed',
      'impact': '96 learners supported',
      'icon': Icons.computer_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campaigns & Drives',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Search campaigns',
            onPressed: _showSearch,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Notifications',
            onPressed: _showNotifications,
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createCampaign,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Create Campaign'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHero(context),
            ),
            SliverToBoxAdapter(
              child: _buildStats(context),
            ),
            SliverToBoxAdapter(
              child: _buildTabs(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  _buildTabContent(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.campaign_rounded,
                  color: scheme.onPrimary,
                  size: 29,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'RESOURCE IMPACT',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'Campaigns & Drives',
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Turn individual contributions into coordinated community action.',
            style: TextStyle(
              color: scheme.onPrimary.withValues(alpha: 0.82),
              height: 1.4,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric(context, '18', 'Active drives'),
              _heroMetric(context, '426', 'Contributors'),
              _heroMetric(context, '8.4K', 'Items moved'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(
    BuildContext context,
    String value,
    String label,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: scheme.onPrimary.withValues(alpha: 0.72),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final stats = [
      ('Active', '18', Icons.bolt_rounded),
      ('Joining', '7', Icons.people_alt_rounded),
      ('Near you', '9', Icons.location_on_rounded),
      ('Completed', '32', Icons.check_circle_rounded),
    ];

    return SizedBox(
      height: 105,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final stat = stats[index];

          return Container(
            width: 120,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: scheme.outlineVariant,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  stat.$3,
                  size: 20,
                  color: scheme.primary,
                ),
                const Spacer(),
                Text(
                  stat.$2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  stat.$1,
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            selectedColor: scheme.primaryContainer,
            labelStyle: TextStyle(
              color: selected
                  ? scheme.onPrimaryContainer
                  : scheme.onSurfaceVariant,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTabContent(BuildContext context) {
    switch (_selectedTab) {
      case 1:
        return [
          _buildMyCampaigns(context),
          const SizedBox(height: 20),
          _buildCampaignAnalytics(context),
        ];
      case 2:
        return [
          _buildParticipating(context),
          const SizedBox(height: 20),
          _buildContributionSummary(context),
        ];
      case 3:
        return [
          _buildCompleted(context),
          const SizedBox(height: 20),
          _buildImpactSummary(context),
        ];
      default:
        return [
          _buildSmartSuggestion(context),
          const SizedBox(height: 20),
          _buildFeaturedCampaigns(context),
          const SizedBox(height: 20),
          _buildNearbyCampaigns(context),
        ];
    }
  }

  Widget _buildSmartSuggestion(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: scheme.secondary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: scheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smart campaign suggestion',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'There are 14 nearby education resources matching active community needs.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showMessage('Smart campaign recommendations opened');
            },
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCampaigns(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Featured Campaigns',
      icon: Icons.star_rounded,
      trailing: TextButton(
        onPressed: () {
          _showMessage('All campaigns opened');
        },
        child: const Text('View all'),
      ),
      child: Column(
        children: [
          for (final campaign in _campaigns.take(2))
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _campaignCard(
                context,
                campaign,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNearbyCampaigns(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Near You',
      icon: Icons.location_on_rounded,
      child: Column(
        children: [
          for (final campaign in _campaigns.skip(2))
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _compactCampaignCard(
                context,
                campaign,
              ),
            ),
        ],
      ),
    );
  }

  Widget _campaignCard(
    BuildContext context,
    Map<String, dynamic> campaign,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final progress = campaign['progress'] as double;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showCampaignDetails(campaign),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.38),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: scheme.outlineVariant,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _campaignIcon(
                  context,
                  campaign['icon'] as IconData,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        campaign['organization'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusChip(
                  context,
                  campaign['status'] as String,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              campaign['description'] as String,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  '${campaign['collected']} / ${campaign['target']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.people_outline_rounded,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text(
                  '${campaign['participants']} participants',
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.schedule_rounded,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text(
                  campaign['days'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _compactCampaignCard(
    BuildContext context,
    Map<String, dynamic> campaign,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => _showCampaignDetails(campaign),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          _campaignIcon(
            context,
            campaign['icon'] as IconData,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${campaign['location']} • ${campaign['days']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }

  Widget _campaignIcon(
    BuildContext context,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: scheme.onPrimaryContainer,
      ),
    );
  }

  Widget _statusChip(
    BuildContext context,
    String status,
  ) {
    final scheme = Theme.of(context).colorScheme;

    final bool urgent = status == 'Urgent';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: urgent
            ? scheme.errorContainer
            : scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: urgent
              ? scheme.onErrorContainer
              : scheme.onSecondaryContainer,
        ),
      ),
    );
  }

  Widget _buildMyCampaigns(BuildContext context) {
    return _sectionCard(
      context,
      title: 'My Campaigns',
      icon: Icons.dashboard_customize_rounded,
      child: Column(
        children: [
          for (final campaign in _myCampaigns)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _myCampaignCard(
                context,
                campaign,
              ),
            ),
        ],
      ),
    );
  }

  Widget _myCampaignCard(
    BuildContext context,
    Map<String, dynamic> campaign,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _campaignIcon(
                context,
                campaign['icon'] as IconData,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaign['category'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _showCampaignActions(
                    campaign['title'] as String,
                  );
                },
                icon: const Icon(Icons.more_horiz_rounded),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: campaign['progress'] as double,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '${campaign['collected']} / ${campaign['target']} items',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${campaign['participants']} participants',
                style: TextStyle(
                  fontSize: 11,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignAnalytics(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Campaign Analytics',
      icon: Icons.analytics_rounded,
      child: Column(
        children: [
          _analyticsRow(
            context,
            'Goal completion',
            '71%',
            0.71,
          ),
          const SizedBox(height: 16),
          _analyticsRow(
            context,
            'Participant growth',
            '+24%',
            0.82,
          ),
          const SizedBox(height: 16),
          _analyticsRow(
            context,
            'Resource utilization',
            '88%',
            0.88,
          ),
          const SizedBox(height: 16),
          _analyticsRow(
            context,
            'Successful exchanges',
            '96%',
            0.96,
          ),
          const SizedBox(height: 14),
          Divider(color: scheme.outlineVariant),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 18,
                color: scheme.primary,
              ),
              const SizedBox(width: 7),
              Text(
                'Campaign efficiency improved 13% this month',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _analyticsRow(
    BuildContext context,
    String title,
    String value,
    double progress,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 42,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: scheme.primary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipating(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Campaigns You Joined',
      icon: Icons.people_alt_rounded,
      child: Column(
        children: [
          for (final campaign in _participating)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: _campaignIcon(
                context,
                campaign['icon'] as IconData,
              ),
              title: Text(
                campaign['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                '${campaign['organization']} • ${campaign['role']}',
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
              ),
              onTap: () {
                _showMessage(
                  '${campaign['title']} opened',
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildContributionSummary(BuildContext context) {
    

    return _sectionCard(
      context,
      title: 'Your Contribution',
      icon: Icons.volunteer_activism_rounded,
      child: Row(
        children: [
          _contributionMetric(
            context,
            '14',
            'Items',
          ),
          _contributionMetric(
            context,
            '5',
            'Campaigns',
          ),
          _contributionMetric(
            context,
            '3',
            'Communities',
          ),
          _contributionMetric(
            context,
            '82',
            'Impact pts',
          ),
        ],
      ),
    );
  }

  Widget _contributionMetric(
    BuildContext context,
    String value,
    String label,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: scheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleted(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Completed Campaigns',
      icon: Icons.task_alt_rounded,
      child: Column(
        children: [
          for (final campaign in _completed)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: _campaignIcon(
                context,
                campaign['icon'] as IconData,
              ),
              title: Text(
                campaign['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                '${campaign['result']} • ${campaign['impact']}',
              ),
              isThreeLine: true,
              trailing: const Icon(
                Icons.check_circle_rounded,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImpactSummary(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            Icons.public_rounded,
            size: 35,
            color: scheme.primary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Campaign impact',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your completed campaigns helped redirect 1,420 resources instead of leaving them unused.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: scheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.035),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  size: 19,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 17),
          child,
        ],
      ),
    );
  }

  void _showCampaignDetails(
    Map<String, dynamic> campaign,
  ) {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _campaignIcon(
                      context,
                      campaign['icon'] as IconData,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            campaign['title'] as String,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            campaign['organization'] as String,
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _detailRow(
                  context,
                  Icons.category_rounded,
                  'Category',
                  campaign['category'] as String,
                ),
                _detailRow(
                  context,
                  Icons.location_on_rounded,
                  'Location',
                  campaign['location'] as String,
                ),
                _detailRow(
                  context,
                  Icons.people_rounded,
                  'Participants',
                  campaign['participants'] as String,
                ),
                _detailRow(
                  context,
                  Icons.schedule_rounded,
                  'Deadline',
                  campaign['days'] as String,
                ),
                const SizedBox(height: 12),
                Text(
                  'Campaign Progress',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                LinearProgressIndicator(
                  value: campaign['progress'] as double,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 8),
                Text(
                  '${campaign['collected']} of ${campaign['target']} target reached',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Campaign saved');
                        },
                        icon: const Icon(
                          Icons.bookmark_border_rounded,
                        ),
                        label: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _joinCampaign(
                            campaign['title'] as String,
                          );
                        },
                        icon: const Icon(
                          Icons.volunteer_activism_rounded,
                        ),
                        label: const Text('Join'),
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

  Widget _detailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: scheme.primary,
          ),
          const SizedBox(width: 11),
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _joinCampaign(String title) {
    _showMessage('You joined $title');
  }

  void _createCampaign() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Create Resource Campaign',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                _actionTile(
                  context,
                  Icons.campaign_rounded,
                  'Start a new campaign',
                  'Define a resource goal and deadline',
                  () {
                    Navigator.pop(context);
                    _showCampaignForm();
                  },
                ),
                _actionTile(
                  context,
                  Icons.group_add_rounded,
                  'Create volunteer drive',
                  'Build a team around a resource need',
                  () {
                    Navigator.pop(context);
                    _showMessage(
                      'Volunteer drive setup opened',
                    );
                  },
                ),
                _actionTile(
                  context,
                  Icons.business_rounded,
                  'Organization initiative',
                  'Create a campaign for your organization',
                  () {
                    Navigator.pop(context);
                    _showMessage(
                      'Organization campaign setup opened',
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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _showCampaignForm() {
    showDialog<void>(
      context: context,
      builder: (context) {
        final titleController = TextEditingController();

        return AlertDialog(
          title: const Text('New Campaign'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Campaign name',
              hintText: 'Example: Books for Community',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final title = titleController.text.trim();

                Navigator.pop(context);

                _showMessage(
                  title.isEmpty
                      ? 'Campaign draft created'
                      : '$title campaign created',
                );
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showCampaignActions(String title) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit_rounded),
                title: const Text('Edit campaign'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Editing $title');
                },
              ),
              ListTile(
                leading: const Icon(Icons.people_rounded),
                title: const Text('Manage participants'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Participant management opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics_rounded),
                title: const Text('View campaign analytics'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Campaign analytics opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.pause_circle_outline_rounded),
                title: const Text('Pause campaign'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('$title paused');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSearch() {
    showSearch<void>(
      context: context,
      delegate: _CampaignSearchDelegate(
        campaigns: _campaigns,
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              25,
            ),
            children: const [
              Text(
                'Campaign Notifications',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.people_alt_rounded),
                title: Text('12 new contributors joined'),
                subtitle: Text('Back to School Drive 2026'),
              ),
              ListTile(
                leading: Icon(Icons.warning_amber_rounded),
                title: Text('Campaign deadline approaching'),
                subtitle: Text('Winter Essentials Collection'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_rounded),
                title: Text('Campaign target reached 78%'),
                subtitle: Text('Digital Access Initiative'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    _showMessage('Campaign data refreshed');
  }

  void _showMessage(String message) {
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

class _CampaignSearchDelegate
    extends SearchDelegate<void> {
  final List<Map<String, dynamic>> campaigns;

  _CampaignSearchDelegate({
    required this.campaigns,
  });

  @override
  List<Widget>? buildActions(
    BuildContext context,
  ) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear_rounded),
        ),
    ];
  }

  @override
  Widget? buildLeading(
    BuildContext context,
  ) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    return _buildResults(context);
  }

  @override
  Widget buildSuggestions(
    BuildContext context,
  ) {
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    final results = campaigns.where((campaign) {
      final title =
          campaign['title'].toString().toLowerCase();
      final category =
          campaign['category'].toString().toLowerCase();

      return title.contains(query.toLowerCase()) ||
          category.contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No campaigns found',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final campaign = results[index];

        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tileColor: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withValues(alpha: 0.45),
          leading: CircleAvatar(
            child: Icon(
              campaign['icon'] as IconData,
            ),
          ),
          title: Text(
            campaign['title'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            campaign['category'] as String,
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
          ),
          onTap: () {
            close(context, null);
          },
        );
      },
    );
  }
}