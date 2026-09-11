import 'package:flutter/material.dart';

class ResourceQualityInspectionScreen extends StatefulWidget {
  const ResourceQualityInspectionScreen({super.key});

  @override
  State<ResourceQualityInspectionScreen> createState() =>
      _ResourceQualityInspectionScreenState();
}

class _ResourceQualityInspectionScreenState
    extends State<ResourceQualityInspectionScreen> {
  int _selectedTab = 0;
  String _inspectionFilter = 'All';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _inspections = [
    {
      'resource': 'Laptops - Engineering Lab',
      'type': 'Electronics',
      'score': 94,
      'status': 'Approved',
      'inspector': 'Arun Kumar',
      'date': 'Today, 10:30 AM',
      'issues': 0,
      'condition': 'Excellent',
      'location': 'Vellore Campus',
    },
    {
      'resource': 'Study Tables',
      'type': 'Furniture',
      'score': 87,
      'status': 'Approved',
      'inspector': 'Priya S',
      'date': 'Yesterday, 4:15 PM',
      'issues': 1,
      'condition': 'Good',
      'location': 'Block C',
    },
    {
      'resource': 'Projector - Seminar Hall',
      'type': 'Electronics',
      'score': 72,
      'status': 'Needs Review',
      'inspector': 'Rahul M',
      'date': 'Sep 5, 2026',
      'issues': 3,
      'condition': 'Fair',
      'location': 'Main Block',
    },
    {
      'resource': 'Library Chairs',
      'type': 'Furniture',
      'score': 81,
      'status': 'Approved',
      'inspector': 'Meena R',
      'date': 'Sep 4, 2026',
      'issues': 1,
      'condition': 'Good',
      'location': 'Central Library',
    },
    {
      'resource': 'Science Equipment Kit',
      'type': 'Lab Equipment',
      'score': 64,
      'status': 'Rejected',
      'inspector': 'Vikram P',
      'date': 'Sep 3, 2026',
      'issues': 4,
      'condition': 'Poor',
      'location': 'Science Block',
    },
  ];

  final List<Map<String, dynamic>> _qualitySignals = [
    {
      'title': 'Excellent Condition',
      'value': '68%',
      'subtitle': 'of inspected resources',
      'icon': Icons.verified_rounded,
    },
    {
      'title': 'Issues Detected',
      'value': '14',
      'subtitle': 'requiring attention',
      'icon': Icons.warning_amber_rounded,
    },
    {
      'title': 'Inspection Rate',
      'value': '92%',
      'subtitle': 'completed this month',
      'icon': Icons.fact_check_rounded,
    },
    {
      'title': 'Re-inspections',
      'value': '6',
      'subtitle': 'scheduled this week',
      'icon': Icons.refresh_rounded,
    },
  ];

  final List<Map<String, dynamic>> _checklist = [
    {
      'title': 'Physical condition',
      'subtitle': 'Check visible damage and structural condition',
      'done': true,
    },
    {
      'title': 'Functionality',
      'subtitle': 'Confirm the resource works as expected',
      'done': true,
    },
    {
      'title': 'Cleanliness',
      'subtitle': 'Verify the resource is clean and usable',
      'done': true,
    },
    {
      'title': 'Safety condition',
      'subtitle': 'Check safety-related components',
      'done': false,
    },
    {
      'title': 'Accessories',
      'subtitle': 'Verify required accessories are available',
      'done': false,
    },
    {
      'title': 'Documentation',
      'subtitle': 'Confirm ownership and resource records',
      'done': false,
    },
  ];

  final List<Map<String, dynamic>> _defects = [
    {
      'title': 'Projector overheating',
      'resource': 'Projector - Seminar Hall',
      'severity': 'High',
      'status': 'Open',
      'date': 'Today',
    },
    {
      'title': 'Table surface damage',
      'resource': 'Study Tables',
      'severity': 'Low',
      'status': 'Resolved',
      'date': 'Yesterday',
    },
    {
      'title': 'Missing power adapter',
      'resource': 'Laptop - CS Lab',
      'severity': 'Medium',
      'status': 'In Progress',
      'date': 'Sep 5',
    },
    {
      'title': 'Chair back support issue',
      'resource': 'Library Chairs',
      'severity': 'Medium',
      'status': 'Open',
      'date': 'Sep 4',
    },
  ];

  final List<Map<String, dynamic>> _history = [
    {
      'title': 'Laptop batch inspection completed',
      'subtitle': '24 resources inspected',
      'date': 'Today, 10:30 AM',
      'icon': Icons.laptop_mac_rounded,
    },
    {
      'title': 'Projector re-inspection requested',
      'subtitle': '3 quality issues found',
      'date': 'Yesterday, 3:40 PM',
      'icon': Icons.videocam_rounded,
    },
    {
      'title': 'Furniture quality review',
      'subtitle': '18 resources approved',
      'date': 'Sep 5, 2026',
      'icon': Icons.chair_rounded,
    },
    {
      'title': 'Lab equipment inspection',
      'subtitle': '12 resources reviewed',
      'date': 'Sep 3, 2026',
      'icon': Icons.science_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text(
          'Quality & Inspection',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: _showSearch,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Notifications',
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startInspection,
        icon: const Icon(Icons.fact_check_rounded),
        label: const Text('Inspect'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildTabs()),
            if (_selectedTab == 0)
              ..._buildOverview()
            else if (_selectedTab == 1)
              ..._buildInspections()
            else if (_selectedTab == 2)
              ..._buildDefects()
            else
              ..._buildHistory(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
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
              color: scheme.primary.withValues(alpha: 0.22),
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.verified_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 8,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Quality Control',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'Resource Quality',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Inspect, verify and maintain the quality of every shared resource.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.84),
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                _scoreCircle(
                  score: 91,
                  label: 'Quality Score',
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Platform Quality',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Excellent quality across active resources',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.78),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.91,
                          minHeight: 7,
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.16),
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreCircle({
    required int score,
    required String label,
  }) {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.13),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.28),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$score',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            '/100',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = [
      ('Overview', Icons.dashboard_rounded),
      ('Inspections', Icons.fact_check_rounded),
      ('Defects', Icons.report_problem_rounded),
      ('History', Icons.history_rounded),
    ];

    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
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
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    tabs[index].$2,
                    size: 18,
                    color: selected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tabs[index].$1,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildOverview() {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: _sectionTitle(
            'Quality Overview',
            'Live inspection intelligence',
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = _qualitySignals[index];

              return _statCard(
                icon: item['icon'] as IconData,
                title: item['title'] as String,
                value: item['value'] as String,
                subtitle: item['subtitle'] as String,
              );
            },
            childCount: _qualitySignals.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
          child: _sectionTitle(
            'Attention Required',
            'Items that need quality action',
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _attentionCard(),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
          child: _sectionTitle(
            'Inspection Checklist',
            'Standard quality verification',
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = _checklist[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: _checklistTile(item),
            );
          },
          childCount: _checklist.length,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
          child: _sectionTitle(
            'Quality Insights',
            'What ResourceX is detecting',
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _insightCard(),
        ),
      ),
    ];
  }

  List<Widget> _buildInspections() {
    final filtered = _filteredInspections();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: _sectionTitle(
                  'Inspection Queue',
                  '${filtered.length} resources',
                ),
              ),
              IconButton(
                onPressed: _showInspectionFilter,
                icon: const Icon(Icons.tune_rounded),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filters = ['All', 'Approved', 'Needs Review', 'Rejected'];
              final selected = _inspectionFilter == filters[index];

              return FilterChip(
                selected: selected,
                label: Text(filters[index]),
                onSelected: (_) {
                  setState(() {
                    _inspectionFilter = filters[index];
                  });
                },
              );
            },
          ),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 18)),
      if (filtered.isEmpty)
        SliverToBoxAdapter(child: _emptyState())
      else
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = filtered[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _inspectionCard(item),
              );
            },
            childCount: filtered.length,
          ),
        ),
    ];
  }

  List<Widget> _buildDefects() {
    final filtered = _defects.where((item) {
      final title = item['title'].toString().toLowerCase();
      final resource = item['resource'].toString().toLowerCase();

      return title.contains(_searchQuery.toLowerCase()) ||
          resource.contains(_searchQuery.toLowerCase());
    }).toList();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
          child: _sectionTitle(
            'Defect Center',
            'Track and resolve quality issues',
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _defectSummary(),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
          child: _sectionTitle(
            'Detected Issues',
            '${filtered.length} active records',
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = filtered[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: _defectCard(item),
            );
          },
          childCount: filtered.length,
        ),
      ),
    ];
  }

  List<Widget> _buildHistory() {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
          child: _sectionTitle(
            'Inspection History',
            'Recent quality activity',
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _historySummary(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = _history[index];

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: _historyTile(item),
            );
          },
          childCount: _history.length,
        ),
      ),
    ];
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
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

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: 22,
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _attentionCard() {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = 2;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: scheme.errorContainer.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: scheme.error.withValues(alpha: 0.16),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.priority_high_rounded,
                color: scheme.error,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3 resources need review',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Quality issues were detected during recent inspections.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }

  Widget _checklistTile(Map<String, dynamic> item) {
    final scheme = Theme.of(context).colorScheme;
    final done = item['done'] as bool;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: done
                  ? scheme.primary.withValues(alpha: 0.12)
                  : scheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              done ? Icons.check_rounded : Icons.circle_outlined,
              color: done ? scheme.primary : scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['subtitle'] as String,
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
    );
  }

  Widget _insightCard() {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: scheme.primary,
              ),
              const SizedBox(width: 9),
              const Text(
                'Smart Quality Insight',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Text(
            'Electronics currently have the highest inspection demand. Scheduling preventive checks before exchange can reduce quality-related issues.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: _showQualityInsights,
            icon: const Icon(Icons.analytics_outlined),
            label: const Text('View insights'),
          ),
        ],
      ),
    );
  }

  Widget _inspectionCard(Map<String, dynamic> item) {
    final scheme = Theme.of(context).colorScheme;
    final score = item['score'] as int;
    final status = item['status'] as String;

    Color statusColor;

    if (status == 'Approved') {
      statusColor = Colors.green;
    } else if (status == 'Rejected') {
      statusColor = scheme.error;
    } else {
      statusColor = Colors.orange;
    }

    return GestureDetector(
      onTap: () => _showInspectionDetails(item),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.42),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.11),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    _resourceIcon(item['type'] as String),
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['resource'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item['type']} • ${item['location']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _scoreBadge(score),
              ],
            ),
            const SizedBox(height: 15),
            Divider(
              height: 1,
              color: scheme.outlineVariant.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item['inspector'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Icon(
                  Icons.schedule_rounded,
                  size: 15,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text(
                  item['date'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.11),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${item['issues']} issue${item['issues'] == 1 ? '' : 's'}',
                  style: TextStyle(
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreBadge(int score) {
  
    final good = score >= 80;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: (good ? Colors.green : Colors.orange)
            .withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$score/100',
        style: TextStyle(
          color: good ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _defectSummary() {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Expanded(
            child: _miniMetric(
              '14',
              'Total Issues',
              Icons.report_problem_rounded,
            ),
          ),
          Expanded(
            child: _miniMetric(
              '5',
              'Open',
              Icons.error_outline_rounded,
            ),
          ),
          Expanded(
            child: _miniMetric(
              '7',
              'Resolved',
              Icons.check_circle_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniMetric(
    String value,
    String title,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          size: 21,
          color: scheme.primary,
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _defectCard(Map<String, dynamic> item) {
    final scheme = Theme.of(context).colorScheme;
    final severity = item['severity'] as String;

    Color severityColor;

    if (severity == 'High') {
      severityColor = scheme.error;
    } else if (severity == 'Medium') {
      severityColor = Colors.orange;
    } else {
      severityColor = Colors.green;
    }

    return GestureDetector(
      onTap: () => _showDefectDetails(item),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: severityColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: severityColor,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['resource'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      _smallPill(
                        item['severity'] as String,
                        severityColor,
                      ),
                      const SizedBox(width: 6),
                      _smallPill(
                        item['status'] as String,
                        scheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              item['date'] as String,
              style: TextStyle(
                fontSize: 9,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _historySummary() {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: _historyMetric(
              '86',
              'Inspections',
            ),
          ),
          Expanded(
            child: _historyMetric(
              '91%',
              'Pass Rate',
            ),
          ),
          Expanded(
            child: _historyMetric(
              '4.8',
              'Avg. Score',
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyMetric(String value, String title) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _historyTile(Map<String, dynamic> item) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item['icon'] as IconData,
              color: scheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['date'] as String,
            style: TextStyle(
              fontSize: 9,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          Icon(
            Icons.fact_check_outlined,
            size: 58,
            color: scheme.onSurfaceVariant,
          ),
          const SizedBox(height: 15),
          const Text(
            'No inspections found',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another filter or start a new inspection.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filteredInspections() {
    return _inspections.where((item) {
      final statusMatch = _inspectionFilter == 'All' ||
          item['status'] == _inspectionFilter;

      final query = _searchQuery.toLowerCase();

      final searchMatch = query.isEmpty ||
          item['resource'].toString().toLowerCase().contains(query) ||
          item['type'].toString().toLowerCase().contains(query) ||
          item['location'].toString().toLowerCase().contains(query);

      return statusMatch && searchMatch;
    }).toList();
  }

  IconData _resourceIcon(String type) {
    switch (type) {
      case 'Electronics':
        return Icons.devices_other_rounded;
      case 'Furniture':
        return Icons.chair_rounded;
      case 'Lab Equipment':
        return Icons.science_rounded;
      default:
        return Icons.inventory_2_rounded;
    }
  }

  void _showInspectionDetails(Map<String, dynamic> item) {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        _resourceIcon(item['type'] as String),
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['resource'] as String,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _detailRow(
                  'Quality score',
                  '${item['score']}/100',
                ),
                _detailRow(
                  'Condition',
                  item['condition'] as String,
                ),
                _detailRow(
                  'Inspection status',
                  item['status'] as String,
                ),
                _detailRow(
                  'Issues found',
                  '${item['issues']}',
                ),
                _detailRow(
                  'Inspector',
                  item['inspector'] as String,
                ),
                _detailRow(
                  'Location',
                  item['location'] as String,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showInspectionChecklist(item);
                        },
                        icon: const Icon(Icons.checklist_rounded),
                        label: const Text('Checklist'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showQualityReport(item);
                        },
                        icon: const Icon(Icons.description_rounded),
                        label: const Text('Report'),
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

  Widget _detailRow(String title, String value) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showInspectionChecklist(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final completed =
                _checklist.where((e) => e['done'] == true).length;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inspection Checklist',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['resource'] as String,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: completed / _checklist.length,
                      minHeight: 7,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$completed of ${_checklist.length} checks completed',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(
                      _checklist.length,
                      (index) {
                        final check = _checklist[index];
                        final done = check['done'] as bool;

                        return CheckboxListTile(
                          value: done,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            check['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          subtitle: Text(
                            check['subtitle'] as String,
                            style: const TextStyle(fontSize: 10),
                          ),
                          onChanged: (value) {
                            setSheetState(() {
                              _checklist[index]['done'] = value ?? false;
                            });
                            setState(() {});
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Inspection checklist saved successfully.',
                              ),
                            ),
                          );
                        },
                        child: const Text('Save Inspection'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showQualityReport(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Quality Report',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.analytics_rounded,
                size: 52,
              ),
              const SizedBox(height: 14),
              Text(
                item['resource'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              _reportLine('Overall Score', '${item['score']}/100'),
              _reportLine('Condition', item['condition'] as String),
              _reportLine('Issues', '${item['issues']}'),
              _reportLine('Status', item['status'] as String),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('Quality report generated.'),
                  ),
                );
              },
              child: const Text('Generate'),
            ),
          ],
        );
      },
    );
  }

  Widget _reportLine(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  void _showDefectDetails(Map<String, dynamic> item) {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item['resource'] as String,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                _detailRow(
                  'Severity',
                  item['severity'] as String,
                ),
                _detailRow(
                  'Status',
                  item['status'] as String,
                ),
                _detailRow(
                  'Reported',
                  item['date'] as String,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Defect has been assigned for resolution.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.build_rounded),
                    label: const Text('Assign for Resolution'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInspectionFilter() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inspection Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ...[
                  'All',
                  'Approved',
                  'Needs Review',
                  'Rejected',
                ].map(
                  (filter) => ListTile(
                    leading: Icon(
                      _inspectionFilter == filter
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                    ),
                    title: Text(filter),
                    onTap: () {
                      setState(() {
                        _inspectionFilter = filter;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startInspection() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Start New Inspection',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose how you want to inspect a resource.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 18),
                _actionTile(
                  Icons.qr_code_scanner_rounded,
                  'Scan Resource',
                  'Quickly identify a resource using its QR code.',
                ),
                _actionTile(
                  Icons.inventory_2_rounded,
                  'Select Resource',
                  'Choose a resource from your inventory.',
                ),
                _actionTile(
                  Icons.add_circle_outline_rounded,
                  'Create Inspection',
                  'Start a new manual inspection record.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: scheme.primary,
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
        style: const TextStyle(fontSize: 10),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title selected.'),
          ),
        );
      },
    );
  }

  void _showSearch() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(
          text: _searchQuery,
        );

        return AlertDialog(
          title: const Text(
            'Search Quality Records',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Resource, type or location',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onSubmitted: (value) {
              setState(() {
                _searchQuery = value;
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
                  _searchQuery = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quality Alerts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.warning_amber_rounded),
                  title: Text('3 resources need review'),
                  subtitle: Text('Quality issues require attention.'),
                ),
                ListTile(
                  leading: Icon(Icons.refresh_rounded),
                  title: Text('2 re-inspections scheduled'),
                  subtitle: Text('Due within the next 48 hours.'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle_outline_rounded),
                  title: Text('Inspection batch approved'),
                  subtitle: Text('24 resources passed inspection.'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showQualityInsights() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Quality Intelligence',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.trending_up_rounded),
                title: Text('Quality score increased'),
                subtitle: Text(
                  'Overall platform quality improved by 6% this month.',
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.devices_other_rounded),
                title: Text('Electronics need more checks'),
                subtitle: Text(
                  'Electronics generate the highest inspection demand.',
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.schedule_rounded),
                title: Text('Preventive inspection recommended'),
                subtitle: Text(
                  'Schedule checks before high-value exchanges.',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quality data refreshed.'),
      ),
    );
  }
}