import 'package:flutter/material.dart';

class ResourceReputationTrustScreen extends StatefulWidget {
  const ResourceReputationTrustScreen({super.key});

  @override
  State<ResourceReputationTrustScreen> createState() =>
      _ResourceReputationTrustScreenState();
}

class _ResourceReputationTrustScreenState
    extends State<ResourceReputationTrustScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> trustedMembers = [
    {
      'name': 'VIT Community Hub',
      'type': 'Organization',
      'score': 97,
      'level': 'Excellent',
      'exchanges': 84,
      'reliability': 98,
      'verified': true,
      'icon': Icons.account_balance_rounded,
    },
    {
      'name': 'GreenLoop Volunteers',
      'type': 'Community',
      'score': 94,
      'level': 'Excellent',
      'exchanges': 61,
      'reliability': 96,
      'verified': true,
      'icon': Icons.groups_rounded,
    },
    {
      'name': 'Arun Resource Network',
      'type': 'Provider',
      'score': 91,
      'level': 'Trusted',
      'exchanges': 43,
      'reliability': 93,
      'verified': true,
      'icon': Icons.person_rounded,
    },
    {
      'name': 'Campus Care Team',
      'type': 'Organization',
      'score': 87,
      'level': 'Trusted',
      'exchanges': 29,
      'reliability': 89,
      'verified': true,
      'icon': Icons.volunteer_activism_rounded,
    },
  ];

  final List<Map<String, dynamic>> feedback = [
    {
      'name': 'Meera S.',
      'resource': 'Study Materials',
      'rating': 5,
      'comment': 'Very reliable exchange and excellent communication.',
      'time': '2 days ago',
    },
    {
      'name': 'Rahul K.',
      'resource': 'Emergency Food Kits',
      'rating': 5,
      'comment': 'Resource condition was exactly as described.',
      'time': '5 days ago',
    },
    {
      'name': 'Nisha R.',
      'resource': 'Laptop Accessories',
      'rating': 4,
      'comment': 'Smooth coordination and quick response.',
      'time': '1 week ago',
    },
  ];

  final List<Map<String, dynamic>> badges = [
    {
      'title': 'Verified Contributor',
      'description': 'Identity and contribution history verified.',
      'icon': Icons.verified_rounded,
    },
    {
      'title': 'Reliable Partner',
      'description': 'Completed more than 25 successful exchanges.',
      'icon': Icons.handshake_rounded,
    },
    {
      'title': 'Community Builder',
      'description': 'Consistently supports resource-sharing activity.',
      'icon': Icons.diversity_3_rounded,
    },
    {
      'title': 'Safety Champion',
      'description': 'Maintains strong safety and compliance standards.',
      'icon': Icons.shield_rounded,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text(
          'Reputation & Trust',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: _showTrustInfo,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 25),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTrustHero(scheme),
                  const SizedBox(height: 18),
                  _buildSearchBar(scheme),
                  const SizedBox(height: 15),
                  _buildTabs(scheme),
                  const SizedBox(height: 18),
                  if (selectedTab == 0) _buildOverview(scheme),
                  if (selectedTab == 1) _buildCommunity(scheme),
                  if (selectedTab == 2) _buildFeedback(scheme),
                  if (selectedTab == 3) _buildBadges(scheme),
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showTrustActions,
        icon: const Icon(Icons.handshake_rounded),
        label: const Text('Trust Actions'),
      ),
    );
  }

  Widget _buildTrustHero(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Trusted',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Your Trust Score',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '94',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 53,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  bottom: 7,
                ),
                child: Text(
                  '/100',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.94,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.16),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 13),
          const Text(
            'Strong reputation based on reliability, safety, verification and successful exchanges.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme scheme) {
    return TextField(
      controller: searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search members or trust profiles...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: _showFilters,
          icon: const Icon(Icons.tune_rounded),
        ),
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTabs(ColorScheme scheme) {
    const tabs = [
      'Overview',
      'Community',
      'Feedback',
      'Badges',
    ];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final selected = selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedTab = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    color: selected ? scheme.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          selected ? FontWeight.w800 : FontWeight.w600,
                      color: selected
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverview(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Reputation Overview',
          'Understand what makes your profile trusted.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildStatsGrid(scheme),
        const SizedBox(height: 18),
        _buildTrustSignals(scheme),
        const SizedBox(height: 18),
        _sectionTitle(
          'Reputation Breakdown',
          'Key factors contributing to your score.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildScoreCard(
          scheme,
          'Exchange Reliability',
          '96%',
          0.96,
          Icons.handshake_rounded,
        ),
        _buildScoreCard(
          scheme,
          'Community Feedback',
          '94%',
          0.94,
          Icons.forum_rounded,
        ),
        _buildScoreCard(
          scheme,
          'Safety Compliance',
          '92%',
          0.92,
          Icons.shield_rounded,
        ),
        _buildScoreCard(
          scheme,
          'Verification Strength',
          '98%',
          0.98,
          Icons.verified_user_rounded,
        ),
        const SizedBox(height: 18),
        _buildGrowthCard(scheme),
        const SizedBox(height: 18),
        _sectionTitle(
          'Recent Trust Activity',
          'Latest events affecting your reputation.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          scheme,
          Icons.star_rounded,
          'Received a 5-star review',
          'Study Materials exchange',
          '2 days ago',
        ),
        _buildActivityItem(
          scheme,
          Icons.verified_rounded,
          'Verification completed',
          'Organization details verified',
          '5 days ago',
        ),
        _buildActivityItem(
          scheme,
          Icons.handshake_rounded,
          'Exchange completed successfully',
          'Emergency Food Kits',
          '1 week ago',
        ),
      ],
    );
  }

  Widget _buildStatsGrid(ColorScheme scheme) {
    final stats = [
      ('Successful Exchanges', '84', Icons.handshake_rounded),
      ('Positive Reviews', '79', Icons.star_rounded),
      ('Reliability', '98%', Icons.speed_rounded),
      ('Verified Signals', '12', Icons.verified_rounded),
    ];

    return GridView.builder(
      itemCount: stats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.42,
      ),
      itemBuilder: (context, index) {
        final item = stats[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(21),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                item.$3,
                color: scheme.primary,
                size: 23,
              ),
              const Spacer(),
              Text(
                item.$2,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                item.$1,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrustSignals(ColorScheme scheme) {
    final signals = [
      (
        Icons.verified_user_rounded,
        'Identity verified',
        'Profile identity has been successfully verified.',
      ),
      (
        Icons.schedule_rounded,
        'Consistent response',
        'Usually responds to exchange requests within 2 hours.',
      ),
      (
        Icons.check_circle_rounded,
        'Strong completion rate',
        '98% of accepted exchanges were completed successfully.',
      ),
      (
        Icons.shield_rounded,
        'Safety compliant',
        'Current resources meet safety and compliance requirements.',
      ),
    ];

    return Column(
      children: signals.map((signal) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Row(
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  signal.$1,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      signal.$2,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      signal.$3,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle_rounded,
                color: scheme.primary,
                size: 19,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScoreCard(
    ColorScheme scheme,
    String title,
    String score,
    double progress,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: scheme.primary,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                score,
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthCard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.trending_up_rounded,
              color: scheme.secondary,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trust is growing',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your reputation increased by 6 points this month.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '+6',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    ColorScheme scheme,
    IconData icon,
    String title,
    String subtitle,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: 23,
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
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunity(ColorScheme scheme) {
    final query = searchController.text.trim().toLowerCase();

    final filtered = trustedMembers.where((member) {
      final matchesSearch = query.isEmpty ||
          member['name'].toString().toLowerCase().contains(query) ||
          member['type'].toString().toLowerCase().contains(query);

      final matchesFilter = selectedFilter == 'All' ||
          member['level'].toString() == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Trusted Community',
          'Discover reliable people and organizations.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildCommunityFilters(scheme),
        const SizedBox(height: 14),
        if (filtered.isEmpty)
          _buildEmptyState(
            scheme,
            Icons.person_search_rounded,
            'No trusted profiles found',
            'Try a different search or filter.',
          )
        else
          ...filtered.map(
            (member) => _memberCard(member, scheme),
          ),
      ],
    );
  }

  Widget _buildCommunityFilters(ColorScheme scheme) {
    const filters = [
      'All',
      'Excellent',
      'Trusted',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final selected = selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: selected,
              onSelected: (_) {
                setState(() => selectedFilter = filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _memberCard(
    Map<String, dynamic> member,
    ColorScheme scheme,
  ) {
    final score = member['score'] as int;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => _showMemberDetails(member),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 53,
              width: 53,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(
                member['icon'] as IconData,
                color: scheme.primary,
                size: 27,
              ),
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
                          member['name'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (member['verified'] == true) ...[
                        const SizedBox(width: 5),
                        Icon(
                          Icons.verified_rounded,
                          size: 15,
                          color: scheme.primary,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member['type'] as String,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.handshake_rounded,
                        size: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${member['exchanges']} exchanges',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.speed_rounded,
                        size: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${member['reliability']}% reliable',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '$score',
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'trust',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Community Feedback',
          'Reviews from completed resource exchanges.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildRatingSummary(scheme),
        const SizedBox(height: 16),
        ...feedback.map(
          (item) => _feedbackCard(item, scheme),
        ),
        const SizedBox(height: 12),
        _buildFeedbackAction(scheme),
      ],
    );
  }

  Widget _buildRatingSummary(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          const Column(
            children: [
              Text(
                '4.9',
                style: TextStyle(
                  fontSize: 39,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Average rating',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              children: [
                _ratingBar(scheme, '5', 0.92),
                _ratingBar(scheme, '4', 0.06),
                _ratingBar(scheme, '3', 0.02),
                _ratingBar(scheme, '2', 0.0),
                _ratingBar(scheme, '1', 0.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(
    ColorScheme scheme,
    String label,
    double value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            child: Text(
              label,
              style: const TextStyle(fontSize: 9),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedbackCard(
    Map<String, dynamic> item,
    ColorScheme scheme,
  ) {
    final rating = item['rating'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Text(
                  (item['name'] as String).substring(0, 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      item['resource'] as String,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item['time'] as String,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
                size: 18,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item['comment'] as String,
            style: const TextStyle(
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackAction(ColorScheme scheme) {
    return InkWell(
      borderRadius: BorderRadius.circular(21),
      onTap: _giveFeedback,
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: scheme.primaryContainer.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Row(
          children: [
            Icon(
              Icons.rate_review_rounded,
              color: scheme.primary,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Give feedback',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Share your experience after an exchange.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildBadges(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Reputation Badges',
          'Achievements earned through responsible participation.',
          scheme,
        ),
        const SizedBox(height: 12),
        GridView.builder(
          itemCount: badges.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final badge = badges[index];

            return InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () => _showBadgeDetails(badge),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(
                    alpha: 0.34,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: scheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        badge['icon'] as IconData,
                        color: scheme.primary,
                        size: 29,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Text(
                      badge['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      badge['description'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 9,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 18),
        _buildNextBadge(scheme),
      ],
    );
  }

  Widget _buildNextBadge(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: scheme.secondary,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next milestone',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Complete 100 successful exchanges to unlock Community Champion.',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '84/100',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
    ColorScheme scheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    ColorScheme scheme,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 42,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 45,
            color: scheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showMemberDetails(Map<String, dynamic> member) {
    _showDetails(
      title: member['name'] as String,
      icon: member['icon'] as IconData,
      details: [
        'Trust score: ${member['score']}/100',
        'Reputation level: ${member['level']}',
        'Successful exchanges: ${member['exchanges']}',
        'Reliability: ${member['reliability']}%',
        'Identity verification completed',
      ],
      actionLabel: 'Connect',
      action: () => _showSnackBar(
        'Connection request sent to ${member['name']}.',
      ),
    );
  }

  void _showBadgeDetails(Map<String, dynamic> badge) {
    _showDetails(
      title: badge['title'] as String,
      icon: badge['icon'] as IconData,
      details: [
        badge['description'] as String,
        'This badge contributes to your overall trust profile.',
      ],
    );
  }

  void _showTrustInfo() {
    _showDetails(
      title: 'Trust Score',
      icon: Icons.workspace_premium_rounded,
      details: [
        'Trust Score represents the reliability of a ResourceX profile.',
        'It considers successful exchanges, community feedback, verification and safety compliance.',
        'Higher scores help users make more confident exchange decisions.',
      ],
    );
  }

  void _showNotifications() {
    _showDetails(
      title: 'Trust Notifications',
      icon: Icons.notifications_rounded,
      details: [
        'Your trust score increased by 2 points.',
        'A new 5-star review was received.',
        'You are 16 successful exchanges away from the next milestone.',
      ],
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Trust Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: const Icon(Icons.workspace_premium_rounded),
                  title: const Text('Trusted Community'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() {
                      selectedTab = 1;
                      selectedFilter = 'Trusted';
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star_rounded),
                  title: const Text('Community Feedback'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() => selectedTab = 2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.emoji_events_rounded),
                  title: const Text('Reputation Badges'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() => selectedTab = 3);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTrustActions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Trust Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                _actionTile(
                  sheetContext,
                  Icons.rate_review_rounded,
                  'Give Feedback',
                  'Rate a completed exchange.',
                  _giveFeedback,
                ),
                _actionTile(
                  sheetContext,
                  Icons.people_alt_rounded,
                  'Discover Trusted Members',
                  'Find reliable ResourceX participants.',
                  () {
                    setState(() => selectedTab = 1);
                  },
                ),
                _actionTile(
                  sheetContext,
                  Icons.verified_user_rounded,
                  'Improve Verification',
                  'Strengthen your trust profile.',
                  _improveVerification,
                ),
                _actionTile(
                  sheetContext,
                  Icons.flag_rounded,
                  'Report Profile',
                  'Report a trust or safety concern.',
                  _reportProfile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionTile(
    BuildContext sheetContext,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback action,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(sheetContext);
        action();
      },
    );
  }

  void _showDetails({
    required String title,
    required IconData icon,
    required List<String> details,
    String? actionLabel,
    VoidCallback? action,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ...details.map(
                  (detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 11),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            detail,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (actionLabel != null && action != null) ...[
                  const SizedBox(height: 7),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        action();
                      },
                      child: Text(actionLabel),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _giveFeedback() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Give Feedback'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Share your exchange experience...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showSnackBar('Feedback submitted successfully.');
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _improveVerification() {
    _showSnackBar('Verification improvement flow opened.');
  }

  void _reportProfile() {
    _showSnackBar('Profile report flow opened.');
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {});
    _showSnackBar('Trust data refreshed.');
  }

  void _showSnackBar(String message) {
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