import 'package:flutter/material.dart';

class ResourceVerificationScreen extends StatefulWidget {
  const ResourceVerificationScreen({super.key});

  @override
  State<ResourceVerificationScreen> createState() =>
      _ResourceVerificationScreenState();
}

class _ResourceVerificationScreenState
    extends State<ResourceVerificationScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Overview',
    'Verification',
    'Safety',
    'History',
  ];

  final List<_VerificationResource> _resources = [
    _VerificationResource(
      name: 'Dell Latitude 5420',
      category: 'Laptop',
      provider: 'Arjun Kumar',
      status: 'Verified',
      score: 96,
      lastChecked: '2 days ago',
      location: 'Vellore',
      icon: Icons.laptop_mac_rounded,
    ),
    _VerificationResource(
      name: 'Projector - Epson X49',
      category: 'Electronics',
      provider: 'VIT Community Hub',
      status: 'Verified',
      score: 92,
      lastChecked: '5 days ago',
      location: 'Katpadi',
      icon: Icons.videocam_outlined,
    ),
    _VerificationResource(
      name: 'Engineering Textbook Set',
      category: 'Books',
      provider: 'Ananya Krishnan',
      status: 'Pending',
      score: 71,
      lastChecked: 'Today',
      location: 'Vellore',
      icon: Icons.menu_book_rounded,
    ),
    _VerificationResource(
      name: 'Arduino Starter Kit',
      category: 'Equipment',
      provider: 'Rahul Mehta',
      status: 'Needs Review',
      score: 58,
      lastChecked: '12 days ago',
      location: 'Chennai',
      icon: Icons.memory_rounded,
    ),
  ];

  final List<_VerificationEvent> _history = [
    _VerificationEvent(
      title: 'Dell Latitude 5420 verified',
      description: 'Identity, ownership and condition evidence approved.',
      time: '2 days ago',
      icon: Icons.verified_rounded,
    ),
    _VerificationEvent(
      title: 'Projector evidence updated',
      description: 'Provider uploaded updated resource photographs.',
      time: '5 days ago',
      icon: Icons.photo_camera_outlined,
    ),
    _VerificationEvent(
      title: 'Arduino kit flagged',
      description: 'Additional ownership information is required.',
      time: '12 days ago',
      icon: Icons.warning_amber_rounded,
    ),
    _VerificationEvent(
      title: 'Textbook set submitted',
      description: 'Verification request entered the review queue.',
      time: 'Today',
      icon: Icons.pending_actions_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Verification & Safety',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: _showVerificationInfo,
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Information',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildTrustHero(context),
            ),
            SliverToBoxAdapter(
              child: _buildTabs(context),
            ),
            SliverToBoxAdapter(
              child: _buildTabContent(context),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showVerificationActions,
        icon: const Icon(Icons.verified_user_outlined),
        label: const Text('Verify Resource'),
      ),
    );
  }

  Widget _buildTrustHero(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
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
              blurRadius: 25,
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
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
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
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Protected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'Resource Trust Score',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '91',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 43,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: 7),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    '/ 100',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              'Your network maintains a high level of verified resources and trusted exchanges.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.86),
                height: 1.45,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 19),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: 0.91,
                minHeight: 9,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                _heroMetric(
                  '86',
                  'Verified',
                ),
                _heroMetric(
                  '7',
                  'Pending',
                ),
                _heroMetric(
                  '3',
                  'Review',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroMetric(
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
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
      child: SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _tabs.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final selected = index == _selectedTab;

            return ChoiceChip(
              label: Text(_tabs[index]),
              selected: selected,
              onSelected: (_) {
                setState(() {
                  _selectedTab = index;
                });
              },
              selectedColor: colorScheme.primary,
              backgroundColor: colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.4),
              side: BorderSide(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
              ),
              labelStyle: TextStyle(
                color: selected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    switch (_selectedTab) {
      case 1:
        return _buildVerificationTab(context);
      case 2:
        return _buildSafetyTab(context);
      case 3:
        return _buildHistoryTab(context);
      default:
        return _buildOverviewTab(context);
    }
  }

  Widget _buildOverviewTab(BuildContext context) {
    return Column(
      children: [
        _sectionHeader(
          context,
          'Verification Overview',
          'Current trust and verification status',
          Icons.analytics_outlined,
        ),
        _buildOverviewStats(context),
        _sectionHeader(
          context,
          'Verification Health',
          'How your resource network is performing',
          Icons.health_and_safety_outlined,
        ),
        _buildHealthCard(context),
        _sectionHeader(
          context,
          'Resources Requiring Attention',
          'Items that may need additional evidence',
          Icons.priority_high_rounded,
        ),
        _buildAttentionResources(context),
        _sectionHeader(
          context,
          'Trust Signals',
          'Signals used to build resource confidence',
          Icons.insights_rounded,
        ),
        _buildTrustSignals(context),
      ],
    );
  }

  Widget _buildOverviewStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _overviewStat(
              context,
              Icons.verified_rounded,
              '86',
              'Verified',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _overviewStat(
              context,
              Icons.pending_actions_rounded,
              '7',
              'Pending',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _overviewStat(
              context,
              Icons.rate_review_outlined,
              '3',
              'Review',
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewStat(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 0.91,
                        strokeWidth: 7,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                      ),
                      Text(
                        '91%',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Excellent verification health',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Most resources have enough evidence to support safe community exchanges.',
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _progressRow(
              context,
              'Identity verified',
              0.94,
              '94%',
            ),
            _progressRow(
              context,
              'Ownership evidence',
              0.89,
              '89%',
            ),
            _progressRow(
              context,
              'Condition evidence',
              0.87,
              '87%',
            ),
            _progressRow(
              context,
              'Safety checks',
              0.95,
              '95%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressRow(
    BuildContext context,
    String label,
    double value,
    String percentage,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                percentage,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttentionResources(BuildContext context) {
    final attention = _resources
        .where((resource) => resource.status != 'Verified')
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final resource in attention)
            _resourceCard(context, resource),
        ],
      ),
    );
  }

  Widget _resourceCard(
    BuildContext context,
    _VerificationResource resource,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color statusColor;
    if (resource.status == 'Verified') {
      statusColor = colorScheme.primary;
    } else if (resource.status == 'Pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.redAccent;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showResourceDetails(resource),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 51,
              height: 51,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                resource.icon,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${resource.category} • ${resource.provider}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.11),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          resource.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Trust ${resource.score}/100',
                        style: TextStyle(
                          fontSize: 9,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustSignals(BuildContext context) {
    final signals = [
      (
        Icons.badge_outlined,
        'Verified provider',
        'Provider identity has been verified.',
        true,
      ),
      (
        Icons.receipt_long_outlined,
        'Ownership evidence',
        'Evidence supports resource ownership.',
        true,
      ),
      (
        Icons.photo_camera_outlined,
        'Recent photographs',
        'Visual evidence is less than 30 days old.',
        true,
      ),
      (
        Icons.history_rounded,
        'Exchange history',
        'Previous exchanges were completed successfully.',
        true,
      ),
      (
        Icons.warning_amber_rounded,
        'Risk indicators',
        'No significant safety indicators detected.',
        true,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final signal in signals)
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Row(
                children: [
                  Icon(
                    signal.$1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          signal.$2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          signal.$3,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    signal.$4
                        ? Icons.check_circle_rounded
                        : Icons.error_outline_rounded,
                    size: 19,
                    color: signal.$4
                        ? Theme.of(context).colorScheme.primary
                        : Colors.orange,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVerificationTab(BuildContext context) {
    return Column(
      children: [
        _sectionHeader(
          context,
          'Verification Queue',
          'Review the status of every resource',
          Icons.fact_check_outlined,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (final resource in _resources)
                _verificationQueueCard(context, resource),
            ],
          ),
        ),
        _sectionHeader(
          context,
          'Verification Checklist',
          'Evidence considered during verification',
          Icons.checklist_rounded,
        ),
        _buildChecklist(context),
      ],
    );
  }

  Widget _verificationQueueCard(
    BuildContext context,
    _VerificationResource resource,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color statusColor;
    if (resource.status == 'Verified') {
      statusColor = colorScheme.primary;
    } else if (resource.status == 'Pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.redAccent;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showResourceDetails(resource),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    resource.icon,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        resource.provider,
                        style: TextStyle(
                          fontSize: 10,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    resource.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Trust score',
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Text(
                  '${resource.score}/100',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: statusColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: resource.score / 100,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Icon(
                  Icons.schedule_outlined,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  'Checked ${resource.lastChecked}',
                  style: TextStyle(
                    fontSize: 9,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 19,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklist(BuildContext context) {
    final items = [
      'Provider identity',
      'Resource ownership',
      'Current condition',
      'Resource photographs',
      'Safety indicators',
      'Previous exchange history',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          children: [
            for (int index = 0; index < items.length; index++)
              Padding(
                padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : 13,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 19,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        items[index],
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'Checked',
                      style: TextStyle(
                        fontSize: 9,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
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

  Widget _buildSafetyTab(BuildContext context) {
    return Column(
      children: [
        _sectionHeader(
          context,
          'Safety Center',
          'Keep every exchange safe and transparent',
          Icons.shield_outlined,
        ),
        _buildSafetyScore(context),
        _sectionHeader(
          context,
          'Safety Checks',
          'Automated and community-level safeguards',
          Icons.security_rounded,
        ),
        _buildSafetyChecks(context),
        _sectionHeader(
          context,
          'Safe Exchange Guidelines',
          'Recommended practices for ResourceX members',
          Icons.menu_book_outlined,
        ),
        _buildSafetyGuidelines(context),
        _sectionHeader(
          context,
          'Report a Concern',
          'Help keep the ResourceX network trustworthy',
          Icons.flag_outlined,
        ),
        _buildReportCard(context),
      ],
    );
  }

  Widget _buildSafetyScore(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 78,
              height: 78,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 0.96,
                    strokeWidth: 8,
                    backgroundColor:
                        colorScheme.surface.withValues(alpha: 0.55),
                  ),
                  Text(
                    '96',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 17),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Safety score: Excellent',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'No major safety concerns have been detected in your recent resource activity.',
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.45,
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

  Widget _buildSafetyChecks(BuildContext context) {
    final checks = [
      (
        Icons.person_search_outlined,
        'Verified identities',
        'Provider identity checks',
        'Passed',
      ),
      (
        Icons.location_on_outlined,
        'Safe meeting locations',
        'Exchange location guidance',
        'Passed',
      ),
      (
        Icons.history_rounded,
        'Exchange reliability',
        'Previous completion history',
        'Passed',
      ),
      (
        Icons.report_problem_outlined,
        'Risk monitoring',
        'Suspicious activity signals',
        'Clear',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final check in checks)
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Row(
                children: [
                  Icon(
                    check.$1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          check.$2,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          check.$3,
                          style: TextStyle(
                            fontSize: 9,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      check.$4,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSafetyGuidelines(BuildContext context) {
    final guidelines = [
      (
        Icons.groups_outlined,
        'Prefer public handover locations',
        'Choose visible community locations whenever possible.',
      ),
      (
        Icons.fact_check_outlined,
        'Confirm resource details',
        'Review the resource information before accepting an exchange.',
      ),
      (
        Icons.chat_outlined,
        'Keep communication inside ResourceX',
        'Use the platform conversation history for exchange coordination.',
      ),
      (
        Icons.flag_outlined,
        'Report suspicious activity',
        'Flag inaccurate or unsafe resource information promptly.',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final guideline in guidelines)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      guideline.$1,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guideline.$2,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          guideline.$3,
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.35,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReportCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Row(
          children: [
            Icon(
              Icons.flag_outlined,
              color: colorScheme.error,
              size: 27,
            ),
            const SizedBox(width: 13),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Something does not look right?',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Report inaccurate, suspicious or unsafe resource information.',
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _showReportDialog,
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab(BuildContext context) {
    return Column(
      children: [
        _sectionHeader(
          context,
          'Verification History',
          'A transparent record of trust decisions',
          Icons.history_rounded,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (final event in _history)
                _historyCard(context, event),
            ],
          ),
        ),
        _sectionHeader(
          context,
          'Verification Activity',
          'Recent network verification performance',
          Icons.timeline_rounded,
        ),
        _buildActivitySummary(context),
      ],
    );
  }

  Widget _historyCard(
    BuildContext context,
    _VerificationEvent event,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              event.icon,
              size: 20,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.35,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            event.time,
            style: TextStyle(
              fontSize: 9,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySummary(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          children: [
            _activityMetric(
              context,
              '92%',
              'Verification approval rate',
              0.92,
            ),
            _activityMetric(
              context,
              '4.6 hrs',
              'Average review time',
              0.76,
            ),
            _activityMetric(
              context,
              '98%',
              'Safety check completion',
              0.98,
            ),
            _activityMetric(
              context,
              '87%',
              'Evidence completeness',
              0.87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityMetric(
    BuildContext context,
    String value,
    String label,
    double progress,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.primary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.fromLTRB(16, 19, 16, 11),
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
                    fontSize: 10,
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

  void _showResourceDetails(
    _VerificationResource resource,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final sheetColors = Theme.of(sheetContext).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: sheetColors.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  resource.icon,
                  color: sheetColors.primary,
                  size: 30,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                resource.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${resource.category} • ${resource.provider}',
                style: TextStyle(
                  color: sheetColors.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _detailMetric(
                    sheetContext,
                    '${resource.score}/100',
                    'Trust score',
                  ),
                  _detailMetric(
                    sheetContext,
                    resource.status,
                    'Status',
                  ),
                  _detailMetric(
                    sheetContext,
                    resource.location,
                    'Location',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _detailRow(
                sheetContext,
                Icons.schedule_outlined,
                'Last verification',
                resource.lastChecked,
              ),
              _detailRow(
                sheetContext,
                Icons.person_outline_rounded,
                'Provider',
                resource.provider,
              ),
              _detailRow(
                sheetContext,
                Icons.shield_outlined,
                'Safety status',
                'No major concerns',
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showVerificationReview(resource);
                  },
                  icon: const Icon(Icons.fact_check_outlined),
                  label: Text(
                    resource.status == 'Verified'
                        ? 'Review verification'
                        : 'Continue verification',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    colorScheme;
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
              fontSize: 12,
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

  Widget _detailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showVerificationReview(
    _VerificationResource resource,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final colorScheme = Theme.of(sheetContext).colorScheme;

        final steps = [
          'Confirm provider identity',
          'Review ownership evidence',
          'Review resource condition',
          'Check safety indicators',
          'Approve verification status',
        ];

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Verification Review',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                resource.name,
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              for (final step in steps)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.check_circle_outline_rounded,
                    color: colorScheme.primary,
                  ),
                  title: Text(
                    step,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Verification review completed.',
                    );
                  },
                  child: const Text('Complete Review'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showVerificationActions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 7, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Start Verification',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _actionTile(
                  sheetContext,
                  Icons.add_box_outlined,
                  'Verify a resource',
                  'Start a new resource verification process.',
                  () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'New verification process started.',
                    );
                  },
                ),
                _actionTile(
                  sheetContext,
                  Icons.refresh_rounded,
                  'Re-verify resources',
                  'Review resources with outdated evidence.',
                  () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Re-verification queue opened.',
                    );
                  },
                ),
                _actionTile(
                  sheetContext,
                  Icons.upload_file_outlined,
                  'Upload evidence',
                  'Add photographs or supporting information.',
                  () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Evidence upload flow opened.',
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
          fontSize: 13,
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

  void _showReportDialog() {
    String reason = 'Incorrect information';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Report a Concern',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select the reason for reporting this resource.',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: reason,
                    decoration: const InputDecoration(
                      labelText: 'Reason',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Incorrect information',
                        child: Text('Incorrect information'),
                      ),
                      DropdownMenuItem(
                        value: 'Ownership concern',
                        child: Text('Ownership concern'),
                      ),
                      DropdownMenuItem(
                        value: 'Safety concern',
                        child: Text('Safety concern'),
                      ),
                      DropdownMenuItem(
                        value: 'Suspicious activity',
                        child: Text('Suspicious activity'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          reason = value;
                        });
                      }
                    },
                  ),
                ],
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
                    Navigator.pop(dialogContext);
                    _showSnackBar(
                      'Report submitted: $reason',
                    );
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showVerificationInfo() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'How verification works',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'ResourceX combines provider verification, ownership evidence, resource information, condition evidence, safety signals and previous exchange history to calculate a trust score.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    _showSnackBar(
      'Verification and safety data refreshed.',
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

class _VerificationResource {
  final String name;
  final String category;
  final String provider;
  final String status;
  final int score;
  final String lastChecked;
  final String location;
  final IconData icon;

  const _VerificationResource({
    required this.name,
    required this.category,
    required this.provider,
    required this.status,
    required this.score,
    required this.lastChecked,
    required this.location,
    required this.icon,
  });
}

class _VerificationEvent {
  final String title;
  final String description;
  final String time;
  final IconData icon;

  const _VerificationEvent({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });
}