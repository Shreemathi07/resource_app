import 'package:flutter/material.dart';

class ResourceLifecycleScreen extends StatefulWidget {
  const ResourceLifecycleScreen({super.key});

  @override
  State<ResourceLifecycleScreen> createState() =>
      _ResourceLifecycleScreenState();
}

class _ResourceLifecycleScreenState extends State<ResourceLifecycleScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Overview',
    'Lifecycle',
    'Maintenance',
    'History',
  ];

  final List<_LifecycleResource> _resources = [
    _LifecycleResource(
      name: 'Laptop Devices',
      category: 'Technology',
      status: 'Active',
      condition: 'Excellent',
      age: '1.2 years',
      usage: 0.91,
      nextMaintenance: '12 Sep',
      icon: Icons.laptop_mac_outlined,
    ),
    _LifecycleResource(
      name: 'Projector Units',
      category: 'Education',
      status: 'Maintenance',
      condition: 'Good',
      age: '2.4 years',
      usage: 0.76,
      nextMaintenance: '08 Sep',
      icon: Icons.videocam_outlined,
    ),
    _LifecycleResource(
      name: 'Study Tables',
      category: 'Furniture',
      status: 'Active',
      condition: 'Good',
      age: '3.1 years',
      usage: 0.68,
      nextMaintenance: '22 Sep',
      icon: Icons.table_restaurant_outlined,
    ),
    _LifecycleResource(
      name: 'Food Storage Kits',
      category: 'Supplies',
      status: 'Review',
      condition: 'Fair',
      age: '1.8 years',
      usage: 0.54,
      nextMaintenance: '05 Sep',
      icon: Icons.inventory_2_outlined,
    ),
  ];

  final List<_MaintenanceItem> _maintenanceItems = [
    _MaintenanceItem(
      resource: 'Projector Units',
      task: 'Technical inspection',
      date: '08 Sep 2026',
      priority: 'High',
      icon: Icons.settings_outlined,
    ),
    _MaintenanceItem(
      resource: 'Food Storage Kits',
      task: 'Condition review',
      date: '05 Sep 2026',
      priority: 'High',
      icon: Icons.fact_check_outlined,
    ),
    _MaintenanceItem(
      resource: 'Laptop Devices',
      task: 'Performance check',
      date: '12 Sep 2026',
      priority: 'Normal',
      icon: Icons.speed_outlined,
    ),
    _MaintenanceItem(
      resource: 'Study Tables',
      task: 'Safety inspection',
      date: '22 Sep 2026',
      priority: 'Normal',
      icon: Icons.shield_outlined,
    ),
  ];

  final List<_HistoryItem> _history = [
    _HistoryItem(
      title: 'Laptop Devices inspected',
      description: 'Routine performance inspection completed',
      date: '02 Sep 2026',
      icon: Icons.check_circle_outline_rounded,
    ),
    _HistoryItem(
      title: 'Projector Units flagged',
      description: 'Maintenance requirement detected',
      date: '31 Aug 2026',
      icon: Icons.warning_amber_rounded,
    ),
    _HistoryItem(
      title: 'Study Tables renewed',
      description: 'Lifecycle status extended after inspection',
      date: '28 Aug 2026',
      icon: Icons.autorenew_rounded,
    ),
    _HistoryItem(
      title: 'Food Storage Kits reviewed',
      description: 'Condition review scheduled',
      date: '25 Aug 2026',
      icon: Icons.event_note_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Resource Lifecycle',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            tooltip: 'More options',
            onPressed: _showMoreOptions,
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLifecycleHero(context),
              const SizedBox(height: 18),
              _buildTabs(context),
              const SizedBox(height: 20),
              _buildSelectedTab(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddMaintenance,
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('Schedule'),
      ),
    );
  }

  Widget _buildLifecycleHero(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.72),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
            blurRadius: 22,
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
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.17),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.autorenew_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Lifecycle Intelligence',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Overall resource health',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '86',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '/100',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.86,
              minHeight: 7,
              backgroundColor: Colors.white.withValues(alpha: 0.18),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 13),
          const Text(
            'Most resources are healthy and actively contributing to the network.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 3),
        itemBuilder: (context, index) {
          final selected = _selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? scheme.surface : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                _tabs[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected
                      ? scheme.onSurface
                      : scheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedTab(BuildContext context) {
    switch (_selectedTab) {
      case 1:
        return _buildLifecycleTab(context);
      case 2:
        return _buildMaintenanceTab(context);
      case 3:
        return _buildHistoryTab(context);
      default:
        return _buildOverviewTab(context);
    }
  }

  Widget _buildOverviewTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          'Resource overview',
          'Current health and lifecycle status',
        ),
        const SizedBox(height: 14),
        _buildOverviewStats(context),
        const SizedBox(height: 22),
        _buildSectionTitle(
          context,
          'Condition distribution',
          'Current condition across tracked resources',
        ),
        const SizedBox(height: 14),
        _buildConditionCard(context),
        const SizedBox(height: 22),
        _buildSectionTitle(
          context,
          'Needs attention',
          'Resources requiring action soon',
        ),
        const SizedBox(height: 14),
        ..._resources
            .where((resource) => resource.status != 'Active')
            .map(
              (resource) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildResourceCard(context, resource),
              ),
            ),
        const SizedBox(height: 12),
        _buildSmartRecommendation(context),
      ],
    );
  }

  Widget _buildLifecycleTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          'Lifecycle journey',
          'Track resources from onboarding to retirement',
        ),
        const SizedBox(height: 14),
        _buildLifecycleDistribution(context),
        const SizedBox(height: 22),
        _buildSectionTitle(
          context,
          'Tracked resources',
          'Lifecycle status of your current resources',
        ),
        const SizedBox(height: 14),
        ..._resources.map(
          (resource) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildResourceCard(context, resource),
          ),
        ),
      ],
    );
  }

  Widget _buildMaintenanceTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          'Maintenance center',
          'Keep resources safe, useful and exchange-ready',
        ),
        const SizedBox(height: 14),
        _buildMaintenanceSummary(context),
        const SizedBox(height: 22),
        _buildSectionTitle(
          context,
          'Upcoming maintenance',
          'Scheduled inspections and reviews',
        ),
        const SizedBox(height: 14),
        ..._maintenanceItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildMaintenanceCard(context, item),
          ),
        ),
        const SizedBox(height: 12),
        _buildMaintenanceTip(context),
      ],
    );
  }

  Widget _buildHistoryTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          'Lifecycle history',
          'Recent resource health and maintenance events',
        ),
        const SizedBox(height: 14),
        _buildHistoryStats(context),
        const SizedBox(height: 22),
        ..._history.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildHistoryCard(context, item),
          ),
        ),
        const SizedBox(height: 12),
        _buildAuditCard(context),
      ],
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewStats(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final stats = [
      ('48', 'Tracked', Icons.inventory_2_outlined),
      ('39', 'Healthy', Icons.check_circle_outline_rounded),
      ('6', 'Maintenance', Icons.build_outlined),
      ('3', 'Review', Icons.warning_amber_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.75,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  stat.$3,
                  color: scheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stat.$1,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    stat.$2,
                    style: TextStyle(
                      fontSize: 10,
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildConditionCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final conditions = [
      ('Excellent', 0.42, '20 resources'),
      ('Good', 0.38, '18 resources'),
      ('Fair', 0.14, '7 resources'),
      ('Needs review', 0.06, '3 resources'),
    ];

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: conditions.map((condition) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        condition.$1,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      condition.$3,
                      style: TextStyle(
                        fontSize: 10,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: condition.$2,
                    minHeight: 8,
                    backgroundColor: scheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      scheme.primary.withValues(alpha: 0.65),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    _LifecycleResource resource,
  ) {
    final scheme = Theme.of(context).colorScheme;

    final statusColor = resource.status == 'Active'
        ? scheme.primary
        : resource.status == 'Maintenance'
            ? scheme.tertiary
            : scheme.error;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showResourceDetails(context, resource),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      resource.icon,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          resource.category,
                          style: TextStyle(
                            fontSize: 10,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.10),
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
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildMiniInfo(
                    context,
                    Icons.health_and_safety_outlined,
                    resource.condition,
                  ),
                  _buildMiniInfo(
                    context,
                    Icons.timelapse_rounded,
                    resource.age,
                  ),
                  _buildMiniInfo(
                    context,
                    Icons.bar_chart_rounded,
                    '${(resource.usage * 100).round()}%',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Next maintenance',
                    style: TextStyle(
                      fontSize: 10,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    resource.nextMaintenance,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniInfo(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: scheme.primary,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartRecommendation(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: scheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart recommendation',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Review Food Storage Kits before the next exchange cycle to improve resource reliability.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleDistribution(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final stages = [
      ('New', '7', 0.15, Icons.fiber_new_outlined),
      ('Active', '31', 0.65, Icons.play_circle_outline_rounded),
      ('Maintenance', '6', 0.13, Icons.build_outlined),
      ('Retirement', '4', 0.07, Icons.archive_outlined),
    ];

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: stages.map((stage) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    stage.$4,
                    size: 18,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              stage.$1,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            stage.$2,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: stage.$3,
                          minHeight: 7,
                          backgroundColor:
                              scheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            scheme.primary.withValues(alpha: 0.60),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMaintenanceSummary(BuildContext context) {
    

    return Row(
      children: [
        Expanded(
          child: _buildMaintenanceStat(
            context,
            '6',
            'Upcoming',
            Icons.event_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMaintenanceStat(
            context,
            '2',
            'High priority',
            Icons.priority_high_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMaintenanceStat(
            context,
            '94%',
            'On time',
            Icons.schedule_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildMaintenanceStat(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceCard(
    BuildContext context,
    _MaintenanceItem item,
  ) {
    final scheme = Theme.of(context).colorScheme;

    final priorityColor =
        item.priority == 'High' ? scheme.error : scheme.primary;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(19),
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: () => _showMaintenanceDetails(context, item),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  item.icon,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.resource,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.task,
                      style: TextStyle(
                        fontSize: 10,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.date,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
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
                  color: priorityColor.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  item.priority,
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaintenanceTip(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.tips_and_updates_outlined,
            color: scheme.primary,
            size: 23,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Text(
              'Keeping maintenance records updated helps ResourceX recommend safer and more reliable exchanges.',
              style: TextStyle(
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryStats(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final stats = [
      ('126', 'Inspections'),
      ('98%', 'Records complete'),
      ('17', 'Renewals'),
    ];

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: stat == stats.last ? 0 : 10,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Text(
                    stat.$1,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat.$2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    _HistoryItem item,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              item.icon,
              color: scheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.date,
                  style: TextStyle(
                    fontSize: 9,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: scheme.primary,
            size: 22,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Lifecycle records are maintained as part of ResourceX activity history for better traceability.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResourceDetails(
    BuildContext context,
    _LifecycleResource resource,
  ) {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        resource.icon,
                        color: scheme.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resource.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            resource.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailRow(
                  context,
                  'Lifecycle status',
                  resource.status,
                ),
                _buildDetailRow(
                  context,
                  'Condition',
                  resource.condition,
                ),
                _buildDetailRow(
                  context,
                  'Resource age',
                  resource.age,
                ),
                _buildDetailRow(
                  context,
                  'Utilization',
                  '${(resource.usage * 100).round()}%',
                ),
                _buildDetailRow(
                  context,
                  'Next maintenance',
                  resource.nextMaintenance,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Lifecycle editor opened');
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Maintenance scheduled');
                        },
                        icon: const Icon(Icons.build_outlined),
                        label: const Text('Maintain'),
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

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  void _showMaintenanceDetails(
    BuildContext context,
    _MaintenanceItem item,
  ) {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.resource,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.task,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 18),
                _buildDetailRow(
                  context,
                  'Scheduled date',
                  item.date,
                ),
                _buildDetailRow(
                  context,
                  'Priority',
                  item.priority,
                ),
                _buildDetailRow(
                  context,
                  'Status',
                  'Scheduled',
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage('Maintenance marked as completed');
                    },
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Mark completed'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddMaintenance() {
    final controller = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(context).viewInsets.bottom + 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Schedule maintenance',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Create a maintenance task for a resource.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Resource name',
                  hintText: 'Example: Laptop Devices',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: 'Routine inspection',
                decoration: const InputDecoration(
                  labelText: 'Maintenance type',
                  prefixIcon: Icon(Icons.build_outlined),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Routine inspection',
                    child: Text('Routine inspection'),
                  ),
                  DropdownMenuItem(
                    value: 'Condition review',
                    child: Text('Condition review'),
                  ),
                  DropdownMenuItem(
                    value: 'Safety check',
                    child: Text('Safety check'),
                  ),
                  DropdownMenuItem(
                    value: 'Technical service',
                    child: Text('Technical service'),
                  ),
                ],
                onChanged: (_) {},
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMessage(
                      controller.text.trim().isEmpty
                          ? 'Maintenance scheduled'
                          : 'Maintenance scheduled for ${controller.text.trim()}',
                    );
                  },
                  icon: const Icon(Icons.event_available_rounded),
                  label: const Text('Schedule maintenance'),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(controller.dispose);
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.download_outlined),
                title: const Text('Export lifecycle report'),
                subtitle: const Text('Prepare a resource lifecycle report'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Lifecycle report prepared');
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_active_outlined),
                title: const Text('Maintenance reminders'),
                subtitle: const Text('Manage upcoming reminders'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Maintenance reminders opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text('Lifecycle information'),
                subtitle: const Text('Learn how lifecycle scoring works'),
                onTap: () {
                  Navigator.pop(context);
                  _showLifecycleInfo();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLifecycleInfo() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resource Lifecycle'),
          content: const Text(
            'ResourceX uses condition, age, utilization, maintenance history and activity status to provide a lifecycle view of shared resources.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refreshData() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    _showMessage('Lifecycle data refreshed');
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }
}

class _LifecycleResource {
  final String name;
  final String category;
  final String status;
  final String condition;
  final String age;
  final double usage;
  final String nextMaintenance;
  final IconData icon;

  const _LifecycleResource({
    required this.name,
    required this.category,
    required this.status,
    required this.condition,
    required this.age,
    required this.usage,
    required this.nextMaintenance,
    required this.icon,
  });
}

class _MaintenanceItem {
  final String resource;
  final String task;
  final String date;
  final String priority;
  final IconData icon;

  const _MaintenanceItem({
    required this.resource,
    required this.task,
    required this.date,
    required this.priority,
    required this.icon,
  });
}

class _HistoryItem {
  final String title;
  final String description;
  final String date;
  final IconData icon;

  const _HistoryItem({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
  });
}