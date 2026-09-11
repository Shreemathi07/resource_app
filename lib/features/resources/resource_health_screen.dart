import 'package:flutter/material.dart';

class ResourceHealthScreen extends StatefulWidget {
  const ResourceHealthScreen({super.key});

  @override
  State<ResourceHealthScreen> createState() => _ResourceHealthScreenState();
}

class _ResourceHealthScreenState extends State<ResourceHealthScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Overview',
    'Lifecycle',
    'Maintenance',
    'Insights',
  ];

  final List<_ResourceHealthItem> _resources = [
    _ResourceHealthItem(
      name: 'Dell Latitude 5420',
      category: 'Laptop',
      condition: 94,
      lifecycle: 'Active',
      age: '1.8 years',
      usage: 'High',
      maintenance: 'Healthy',
      icon: Icons.laptop_mac_outlined,
    ),
    _ResourceHealthItem(
      name: 'Epson EB-X06 Projector',
      category: 'Presentation',
      condition: 81,
      lifecycle: 'Active',
      age: '2.6 years',
      usage: 'Medium',
      maintenance: 'Due soon',
      icon: Icons.videocam_outlined,
    ),
    _ResourceHealthItem(
      name: 'Engineering Book Collection',
      category: 'Education',
      condition: 88,
      lifecycle: 'Reusable',
      age: '1.2 years',
      usage: 'High',
      maintenance: 'Healthy',
      icon: Icons.menu_book_outlined,
    ),
    _ResourceHealthItem(
      name: 'Modular Study Tables',
      category: 'Furniture',
      condition: 63,
      lifecycle: 'Needs review',
      age: '4.1 years',
      usage: 'High',
      maintenance: 'Inspection needed',
      icon: Icons.table_restaurant_outlined,
    ),
  ];

  final List<_MaintenanceItem> _maintenanceItems = [
    _MaintenanceItem(
      title: 'Projector inspection',
      resource: 'Epson EB-X06 Projector',
      date: 'Sep 12',
      priority: 'Upcoming',
      icon: Icons.build_outlined,
    ),
    _MaintenanceItem(
      title: 'Laptop battery health check',
      resource: 'Dell Latitude 5420',
      date: 'Sep 18',
      priority: 'Planned',
      icon: Icons.battery_charging_full_outlined,
    ),
    _MaintenanceItem(
      title: 'Furniture condition review',
      resource: 'Modular Study Tables',
      date: 'Sep 22',
      priority: 'Attention',
      icon: Icons.chair_outlined,
    ),
  ];

  final List<_LifecycleStage> _lifecycleStages = [
    _LifecycleStage(
      title: 'New',
      count: '48',
      percentage: 18,
      icon: Icons.fiber_new_outlined,
    ),
    _LifecycleStage(
      title: 'Active',
      count: '137',
      percentage: 51,
      icon: Icons.play_circle_outline_rounded,
    ),
    _LifecycleStage(
      title: 'Reusable',
      count: '62',
      percentage: 23,
      icon: Icons.recycling_outlined,
    ),
    _LifecycleStage(
      title: 'Needs Review',
      count: '21',
      percentage: 8,
      icon: Icons.warning_amber_outlined,
    ),
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showResourceDetails(_ResourceHealthItem resource) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        resource.icon,
                        color: Colors.green.shade700,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        resource.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  resource.category,
                ),
                _detailRow(
                  Icons.calendar_today_outlined,
                  'Resource age',
                  resource.age,
                ),
                _detailRow(
                  Icons.insights_outlined,
                  'Usage level',
                  resource.usage,
                ),
                _detailRow(
                  Icons.recycling_outlined,
                  'Lifecycle',
                  resource.lifecycle,
                ),
                _detailRow(
                  Icons.build_outlined,
                  'Maintenance',
                  resource.maintenance,
                ),
                const SizedBox(height: 5),
                Text(
                  'Condition score',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: resource.condition / 100,
                          minHeight: 9,
                          backgroundColor: Colors.grey.shade100,
                          color: _conditionColor(resource.condition),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${resource.condition}%',
                      style: TextStyle(
                        color: _conditionColor(resource.condition),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Maintenance request created');
                        },
                        icon: const Icon(Icons.build_outlined),
                        label: const Text('Maintain'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Lifecycle updated');
                        },
                        icon: const Icon(Icons.update_rounded),
                        label: const Text('Update'),
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
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green.shade700,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _conditionColor(int condition) {
    if (condition >= 80) {
      return Colors.green.shade700;
    }

    if (condition >= 60) {
      return Colors.orange.shade700;
    }

    return Colors.red.shade700;
  }

  void _showMaintenanceDetails(_MaintenanceItem item) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      item.icon,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _detailRow(
                Icons.inventory_2_outlined,
                'Resource',
                item.resource,
              ),
              _detailRow(
                Icons.event_outlined,
                'Scheduled',
                item.date,
              ),
              _detailRow(
                Icons.flag_outlined,
                'Priority',
                item.priority,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMessage('Maintenance task confirmed');
                  },
                  child: const Text('Confirm Maintenance'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLifecycleDetails(_LifecycleStage stage) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${stage.title} resources',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${stage.count} resources are currently in this lifecycle stage.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 20),
              _lifecycleInfo(
                'Resources',
                stage.count,
                Icons.inventory_2_outlined,
              ),
              _lifecycleInfo(
                'Network share',
                '${stage.percentage}%',
                Icons.pie_chart_outline_rounded,
              ),
              _lifecycleInfo(
                'Recommended action',
                stage.title == 'Needs Review'
                    ? 'Inspect'
                    : 'Continue monitoring',
                Icons.auto_awesome_outlined,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Showing ${stage.title.toLowerCase()} resources',
                    );
                  },
                  child: const Text('View Resources'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _lifecycleInfo(
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green.shade700,
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 10,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resource Health',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Monitor condition, lifecycle and maintenance',
              style: TextStyle(
                fontSize: 10.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showMessage('Resource health data refreshed');
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        children: [
          _buildHero(),
          const SizedBox(height: 18),
          _buildTabs(),
          const SizedBox(height: 20),
          if (_selectedTab == 0) ...[
            _buildOverviewStats(),
            const SizedBox(height: 20),
            _buildConditionOverview(),
            const SizedBox(height: 20),
            _buildAttentionCard(),
            const SizedBox(height: 20),
            _buildResourceList(),
          ] else if (_selectedTab == 1) ...[
            _buildLifecycleOverview(),
            const SizedBox(height: 20),
            _buildLifecycleTimeline(),
          ] else if (_selectedTab == 2) ...[
            _buildMaintenanceOverview(),
            const SizedBox(height: 20),
            _buildMaintenanceList(),
          ] else ...[
            _buildHealthInsights(),
            const SizedBox(height: 20),
            _buildOptimizationCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade800,
            Colors.teal.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.health_and_safety_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resource Health Score',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '84 / 100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Most resources are healthy and ready for reuse.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 62,
            height: 62,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.84,
                  strokeWidth: 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.14),
                  color: Colors.white,
                ),
                const Text(
                  '84%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedTab == index;

          return ChoiceChip(
            label: Text(
              _tabs[index],
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.grey.shade700,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedTab = index;
              });
            },
            selectedColor: Colors.green.shade700,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selected
                  ? Colors.green.shade700
                  : Colors.grey.shade200,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewStats() {
    return Row(
      children: [
        Expanded(
          child: _overviewStat(
            '268',
            'Tracked',
            Icons.inventory_2_outlined,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _overviewStat(
            '84%',
            'Healthy',
            Icons.check_circle_outline,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _overviewStat(
            '21',
            'Review',
            Icons.warning_amber_outlined,
          ),
        ),
      ],
    );
  }

  Widget _overviewStat(
    String value,
    String label,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.green.shade700,
            size: 19,
          ),
          const SizedBox(height: 9),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 8.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionOverview() {
    return _sectionCard(
      title: 'Condition distribution',
      subtitle: 'Overall health of resources in your network.',
      icon: Icons.monitor_heart_outlined,
      child: Column(
        children: [
          _conditionRow(
            'Excellent',
            '112',
            0.42,
            Colors.green,
          ),
          _conditionRow(
            'Good',
            '91',
            0.34,
            Colors.teal,
          ),
          _conditionRow(
            'Fair',
            '44',
            0.16,
            Colors.orange,
          ),
          _conditionRow(
            'Needs attention',
            '21',
            0.08,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _conditionRow(
    String title,
    String count,
    double value,
    MaterialColor color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                count,
                style: TextStyle(
                  color: color.shade700,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              backgroundColor: Colors.grey.shade100,
              color: color.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttentionCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange.shade800,
              size: 22,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '21 resources need attention',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Review condition or maintenance status before assigning these resources to new exchanges.',
                  style: TextStyle(
                    fontSize: 9.5,
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

  Widget _buildResourceList() {
    return _sectionCard(
      title: 'Tracked resources',
      subtitle: 'Health information for frequently exchanged resources.',
      icon: Icons.inventory_2_outlined,
      child: Column(
        children: _resources.map(
          (resource) {
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showResourceDetails(resource);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        resource.icon,
                        color: Colors.green.shade700,
                        size: 21,
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
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${resource.category} • ${resource.age}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 8.5,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: resource.condition / 100,
                                    minHeight: 5,
                                    backgroundColor:
                                        Colors.grey.shade100,
                                    color: _conditionColor(
                                      resource.condition,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                '${resource.condition}%',
                                style: TextStyle(
                                  color: _conditionColor(
                                    resource.condition,
                                  ),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildLifecycleOverview() {
    return _sectionCard(
      title: 'Lifecycle distribution',
      subtitle: 'Where your resources currently sit in their journey.',
      icon: Icons.timeline_rounded,
      child: Column(
        children: _lifecycleStages.map(
          (stage) {
            return InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                _showLifecycleDetails(stage);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        stage.icon,
                        color: Colors.green.shade700,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            stage.title,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${stage.count} resources',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 8.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${stage.percentage}%',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildLifecycleTimeline() {
    return _sectionCard(
      title: 'Lifecycle journey',
      subtitle: 'Recommended resource journey from creation to reuse.',
      icon: Icons.route_outlined,
      child: Column(
        children: [
          _timelineStep(
            'Added',
            'Resource registered in ResourceX',
            Icons.add_box_outlined,
            true,
          ),
          _timelineStep(
            'Active',
            'Available for matching and exchange',
            Icons.public_outlined,
            true,
          ),
          _timelineStep(
            'Reuse',
            'Transferred to a new beneficiary',
            Icons.recycling_outlined,
            true,
          ),
          _timelineStep(
            'Renew',
            'Repair or maintenance when required',
            Icons.build_outlined,
            false,
          ),
        ],
      ),
    );
  }

  Widget _timelineStep(
    String title,
    String subtitle,
    IconData icon,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: completed
                  ? Colors.green.withValues(alpha: 0.10)
                  : Colors.grey.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 19,
              color: completed
                  ? Colors.green.shade700
                  : Colors.grey.shade500,
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
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked,
            color: completed
                ? Colors.green.shade600
                : Colors.grey.shade400,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceOverview() {
    return Row(
      children: [
        Expanded(
          child: _overviewStat(
            '14',
            'Upcoming',
            Icons.event_outlined,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _overviewStat(
            '8',
            'Completed',
            Icons.check_circle_outline,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _overviewStat(
            '3',
            'Attention',
            Icons.priority_high_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildMaintenanceList() {
    return _sectionCard(
      title: 'Maintenance schedule',
      subtitle: 'Upcoming actions that keep resources exchange-ready.',
      icon: Icons.build_circle_outlined,
      child: Column(
        children: _maintenanceItems.map(
          (item) {
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showMaintenanceDetails(item);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        item.icon,
                        color: Colors.orange.shade800,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.resource,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 8.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.date,
                            style: TextStyle(
                              color: Colors.orange.shade800,
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: item.priority == 'Attention'
                            ? Colors.red.withValues(alpha: 0.08)
                            : Colors.orange.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.priority,
                        style: TextStyle(
                          color: item.priority == 'Attention'
                              ? Colors.red.shade700
                              : Colors.orange.shade800,
                          fontSize: 7.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildHealthInsights() {
    return _sectionCard(
      title: 'Health insights',
      subtitle: 'Recommendations based on resource condition and usage.',
      icon: Icons.auto_awesome_outlined,
      child: Column(
        children: [
          _insightRow(
            Icons.battery_alert_outlined,
            'Review older technology',
            '12 technology resources have been active for more than 3 years.',
          ),
          _insightRow(
            Icons.recycling_outlined,
            'Increase reuse cycles',
            'Books and furniture show strong potential for additional exchanges.',
          ),
          _insightRow(
            Icons.build_outlined,
            'Schedule maintenance',
            'Three resources may benefit from maintenance before their next exchange.',
          ),
          _insightRow(
            Icons.speed_outlined,
            'Optimize idle resources',
            'Seven resources have low recent usage despite good condition.',
          ),
        ],
      ),
    );
  }

  Widget _insightRow(
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: Colors.green.shade700,
              size: 20,
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
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9.5,
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

  Widget _buildOptimizationCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.teal.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.auto_graph_rounded,
                  color: Colors.green.shade700,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Lifecycle optimization',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Text(
            'Keeping resources maintained and moving through multiple reuse cycles can increase their overall community value.',
            style: TextStyle(
              fontSize: 10,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                _showMessage(
                  'Lifecycle optimization plan created',
                );
              },
              icon: const Icon(
                Icons.auto_awesome_rounded,
                size: 17,
              ),
              label: const Text('Optimize Resources'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.green.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _ResourceHealthItem {
  final String name;
  final String category;
  final int condition;
  final String lifecycle;
  final String age;
  final String usage;
  final String maintenance;
  final IconData icon;

  const _ResourceHealthItem({
    required this.name,
    required this.category,
    required this.condition,
    required this.lifecycle,
    required this.age,
    required this.usage,
    required this.maintenance,
    required this.icon,
  });
}

class _MaintenanceItem {
  final String title;
  final String resource;
  final String date;
  final String priority;
  final IconData icon;

  const _MaintenanceItem({
    required this.title,
    required this.resource,
    required this.date,
    required this.priority,
    required this.icon,
  });
}

class _LifecycleStage {
  final String title;
  final String count;
  final int percentage;
  final IconData icon;

  const _LifecycleStage({
    required this.title,
    required this.count,
    required this.percentage,
    required this.icon,
  });
}