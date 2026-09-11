import 'package:flutter/material.dart';

class ResourceReservationAnalyticsScreen extends StatefulWidget {
  const ResourceReservationAnalyticsScreen({super.key});

  @override
  State<ResourceReservationAnalyticsScreen> createState() =>
      _ResourceReservationAnalyticsScreenState();
}

class _ResourceReservationAnalyticsScreenState
    extends State<ResourceReservationAnalyticsScreen> {
  int selectedTab = 0;
  String selectedPeriod = '30 Days';

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> tabs = [
    'Overview',
    'Performance',
    'Resources',
    'Insights',
  ];

  final List<Map<String, dynamic>> reservationTrends = [
    {
      'day': 'Mon',
      'value': 62,
    },
    {
      'day': 'Tue',
      'value': 78,
    },
    {
      'day': 'Wed',
      'value': 70,
    },
    {
      'day': 'Thu',
      'value': 91,
    },
    {
      'day': 'Fri',
      'value': 84,
    },
    {
      'day': 'Sat',
      'value': 55,
    },
    {
      'day': 'Sun',
      'value': 48,
    },
  ];

  final List<Map<String, dynamic>> resourcePerformance = [
    {
      'name': 'Laptops',
      'category': 'Technology',
      'reservations': 86,
      'completion': 96,
      'growth': '+18%',
      'icon': Icons.laptop_mac_outlined,
    },
    {
      'name': 'Educational Books',
      'category': 'Education',
      'reservations': 72,
      'completion': 94,
      'growth': '+14%',
      'icon': Icons.menu_book_outlined,
    },
    {
      'name': 'Study Tables',
      'category': 'Furniture',
      'reservations': 54,
      'completion': 91,
      'growth': '+11%',
      'icon': Icons.table_restaurant_outlined,
    },
    {
      'name': 'Projectors',
      'category': 'Electronics',
      'reservations': 38,
      'completion': 89,
      'growth': '+8%',
      'icon': Icons.videocam_outlined,
    },
    {
      'name': 'Sports Equipment',
      'category': 'Sports',
      'reservations': 31,
      'completion': 86,
      'growth': '+5%',
      'icon': Icons.sports_basketball_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Reservation Analytics',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showExportOptions,
            icon: const Icon(Icons.file_download_outlined),
          ),
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(),
                const SizedBox(height: 18),
                _buildPeriodSelector(),
                const SizedBox(height: 18),
                _buildTabs(),
                const SizedBox(height: 18),
                _buildSelectedTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.68),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
            blurRadius: 25,
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
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Live Insights',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Reservation Performance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understand reservation demand, approval performance and resource usage across the ResourceX network.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _heroMetric('286', 'Reservations'),
              _heroMetric('93.4%', 'Completion'),
              _heroMetric('4.6h', 'Avg. response'),
            ],
          ),
        ],
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
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.70),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: periods.map((period) {
          final selected = selectedPeriod == period;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.grey.shade600,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.grey.shade700,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedTab() {
    switch (selectedTab) {
      case 1:
        return _buildPerformanceTab();
      case 2:
        return _buildResourcesTab();
      case 3:
        return _buildInsightsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Reservation Overview',
          'Current performance across the selected period',
          Icons.dashboard_outlined,
        ),
        const SizedBox(height: 12),
        _buildKpiGrid(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Reservation Trend',
          'Reservation activity over the week',
          Icons.show_chart_rounded,
        ),
        const SizedBox(height: 12),
        _buildTrendChart(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Reservation Outcomes',
          'How requests are progressing',
          Icons.donut_small_outlined,
        ),
        const SizedBox(height: 12),
        _buildOutcomeCard(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Category Performance',
          'Most active resource categories',
          Icons.category_outlined,
        ),
        const SizedBox(height: 12),
        _buildCategoryPerformance(),
      ],
    );
  }

  Widget _buildKpiGrid() {
    final kpis = [
      {
        'label': 'Total',
        'value': '286',
        'change': '+18%',
        'icon': Icons.calendar_month_outlined,
        'color': Colors.indigo,
      },
      {
        'label': 'Approved',
        'value': '247',
        'change': '+15%',
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
      },
      {
        'label': 'Rejected',
        'value': '18',
        'change': '-7%',
        'icon': Icons.cancel_outlined,
        'color': Colors.red,
      },
      {
        'label': 'Conflicts',
        'value': '12',
        'change': '-11%',
        'icon': Icons.warning_amber_outlined,
        'color': Colors.orange,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kpis.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) {
        final kpi = kpis[index];
        final color = kpi['color'] as Color;

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    kpi['icon'] as IconData,
                    color: color,
                    size: 19,
                  ),
                  const Spacer(),
                  Text(
                    kpi['change'].toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                kpi['value'].toString(),
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                kpi['label'].toString(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrendChart() {
    final maxValue = reservationTrends
        .map((item) => item['value'] as int)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      height: 230,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: reservationTrends.map((item) {
          final value = item['value'] as int;
          final height = 130 * value / maxValue;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$value',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(9),
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(
                            alpha: 0.25 + (value / maxValue) * 0.55,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['day'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOutcomeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          _outcomeRow(
            'Approved',
            '247',
            0.86,
            Colors.green,
          ),
          _outcomeRow(
            'Pending',
            '21',
            0.07,
            Colors.orange,
          ),
          _outcomeRow(
            'Rejected',
            '18',
            0.06,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _outcomeRow(
    String label,
    String value,
    double progress,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                color: color,
                backgroundColor: color.withValues(alpha: 0.10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPerformance() {
    final categories = [
      ['Technology', '112', '+21%', Icons.devices_outlined],
      ['Education', '74', '+16%', Icons.school_outlined],
      ['Furniture', '46', '+12%', Icons.chair_outlined],
      ['Electronics', '31', '+9%', Icons.electrical_services_outlined],
      ['Sports', '23', '+5%', Icons.sports_outlined],
    ];

    return Column(
      children: categories.map((category) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  category[3] as IconData,
                  size: 19,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  category[0].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                category[1].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 9),
              Text(
                category[2].toString(),
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPerformanceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Operational Performance',
          'Efficiency of the reservation process',
          Icons.speed_rounded,
        ),
        const SizedBox(height: 12),
        _buildPerformanceMetrics(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Response Efficiency',
          'How quickly reservation requests are handled',
          Icons.timer_outlined,
        ),
        const SizedBox(height: 12),
        _buildResponseCard(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Reservation Reliability',
          'Successful reservation completion indicators',
          Icons.verified_outlined,
        ),
        const SizedBox(height: 12),
        _buildReliabilityCard(),
      ],
    );
  }

  Widget _buildPerformanceMetrics() {
    final metrics = [
      ['Approval accuracy', '94%', 0.94, Colors.green],
      ['Conflict detection', '96%', 0.96, Colors.indigo],
      ['On-time pickup', '91%', 0.91, Colors.orange],
      ['Completion rate', '93%', 0.93, Colors.teal],
    ];

    return Column(
      children: metrics.map((metric) {
        return Container(
          margin: const EdgeInsets.only(bottom: 11),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      metric[0].toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    metric[1].toString(),
                    style: TextStyle(
                      color: metric[3] as Color,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: metric[2] as double,
                  minHeight: 8,
                  color: metric[3] as Color,
                  backgroundColor:
                      (metric[3] as Color).withValues(alpha: 0.10),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResponseCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _bigMetric(
                '4.6h',
                'Avg. response',
                Icons.timer_outlined,
              ),
              _bigMetric(
                '89%',
                'Within 2 hrs',
                Icons.flash_on_outlined,
              ),
              _bigMetric(
                '1.2h',
                'Fastest',
                Icons.speed_outlined,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(
                Icons.trending_down_rounded,
                color: Colors.green,
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Average response time improved by 18% compared with the previous period.',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bigMetric(
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReliabilityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          _reliabilityRow(
            'Successful reservations',
            '267 / 286',
            0.93,
          ),
          _reliabilityRow(
            'Completed on schedule',
            '244 / 267',
            0.91,
          ),
          _reliabilityRow(
            'No cancellation',
            '251 / 286',
            0.88,
          ),
          _reliabilityRow(
            'No conflict',
            '274 / 286',
            0.96,
          ),
        ],
      ),
    );
  }

  Widget _reliabilityRow(
    String title,
    String value,
    double progress,
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
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Top Requested Resources',
          'Resources receiving the highest reservation demand',
          Icons.inventory_2_outlined,
        ),
        const SizedBox(height: 12),
        ...resourcePerformance.asMap().entries.map(
          (entry) => _buildResourcePerformanceCard(
            entry.key + 1,
            entry.value,
          ),
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Resource Demand Distribution',
          'Reservation demand by resource category',
          Icons.bar_chart_rounded,
        ),
        const SizedBox(height: 12),
        _buildDemandDistribution(),
      ],
    );
  }

  Widget _buildResourcePerformanceCard(
    int rank,
    Map<String, dynamic> resource,
  ) {
    return GestureDetector(
      onTap: () => _showResourceDetails(resource),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 31,
              height: 31,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rank == 1
                    ? Colors.amber.withValues(alpha: 0.14)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Text(
                '#$rank',
                style: TextStyle(
                  color: rank == 1
                      ? Colors.amber.shade800
                      : Colors.grey.shade600,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 11),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                resource['icon'] as IconData,
                size: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource['name'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    resource['category'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        '${resource['reservations']} reservations',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        resource['growth'].toString(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${resource['completion']}%',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'completion',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemandDistribution() {
    final items = [
      ['Technology', 0.82, '112'],
      ['Education', 0.64, '74'],
      ['Furniture', 0.47, '46'],
      ['Electronics', 0.32, '31'],
      ['Sports', 0.24, '23'],
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 78,
                  child: Text(
                    item[0].toString(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: item[1] as double,
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 28,
                  child: Text(
                    item[2].toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
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

  Widget _buildInsightsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Smart Reservation Insights',
          'Patterns detected from reservation activity',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          Icons.trending_up_rounded,
          'Technology demand is rising',
          'Laptop reservations increased by 18% during the selected period. Demand is strongest before academic project deadlines.',
          Colors.indigo,
        ),
        _buildInsightCard(
          Icons.schedule_outlined,
          'Afternoon reservations dominate',
          'Most pickup reservations are scheduled between 2 PM and 5 PM. Consider increasing provider availability during this window.',
          Colors.orange,
        ),
        _buildInsightCard(
          Icons.location_on_outlined,
          'Campus demand is concentrated',
          'Vellore Campus currently contributes the highest reservation activity, followed by Katpadi and Sathuvachari.',
          Colors.teal,
        ),
        _buildInsightCard(
          Icons.warning_amber_rounded,
          'Conflicts are decreasing',
          'Detected reservation conflicts dropped by 11% after smart schedule validation was introduced.',
          Colors.green,
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Demand Forecast',
          'Expected reservation activity',
          Icons.insights_outlined,
        ),
        const SizedBox(height: 12),
        _buildForecastCard(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Recommended Actions',
          'Improve reservation efficiency',
          Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: 12),
        _buildRecommendation(
          'Increase laptop availability',
          'High demand detected for the next 7 days.',
          Icons.laptop_mac_outlined,
        ),
        _buildRecommendation(
          'Extend afternoon pickup slots',
          '2 PM–5 PM has the highest reservation activity.',
          Icons.access_time_outlined,
        ),
        _buildRecommendation(
          'Review conflict-prone resources',
          'Three resources have repeated schedule overlaps.',
          Icons.rule_outlined,
        ),
      ],
    );
  }

  Widget _buildInsightCard(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
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

  Widget _buildForecastCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              const Text(
                'Next 7 Days',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Text(
                '+13%',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Text(
            'Expected reservation demand is likely to increase moderately, especially for technology and education resources.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _forecastMetric('Expected', '324'),
              _forecastMetric('Peak day', 'Thu'),
              _forecastMetric('Confidence', '91%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastMetric(
    String label,
    String value,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.amber.shade800,
              size: 19,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
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
          const Icon(
            Icons.chevron_right_rounded,
            size: 19,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 19,
            color: Theme.of(context).colorScheme.primary,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showResourceDetails(
    Map<String, dynamic> resource,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.09),
                    child: Icon(
                      resource['icon'] as IconData,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      resource['name'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _detailLine(
                'Category',
                resource['category'].toString(),
              ),
              _detailLine(
                'Reservations',
                resource['reservations'].toString(),
              ),
              _detailLine(
                'Completion rate',
                '${resource['completion']}%',
              ),
              _detailLine(
                'Growth',
                resource['growth'].toString(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Resource analytics opened',
                    );
                  },
                  child: const Text(
                    'View Resource Analytics',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailLine(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
          const Spacer(),
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

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Export Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: const Icon(
                    Icons.picture_as_pdf_outlined,
                  ),
                  title: const Text('Export PDF Report'),
                  subtitle: const Text(
                    'Reservation analytics summary',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'PDF report prepared',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.table_chart_outlined,
                  ),
                  title: const Text('Export CSV Data'),
                  subtitle: const Text(
                    'Detailed reservation dataset',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'CSV data prepared',
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

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Analytics Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.trending_up_rounded,
                    color: Colors.green,
                  ),
                  title: const Text(
                    'Technology demand increased by 18%',
                  ),
                  subtitle: const Text('12 minutes ago'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.insights_outlined,
                    color: Colors.indigo,
                  ),
                  title: const Text(
                    'New reservation forecast is available',
                  ),
                  subtitle: const Text('1 hour ago'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  title: const Text(
                    '3 resources need availability review',
                  ),
                  subtitle: const Text('2 hours ago'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> refreshData() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    _showSnackBar('Reservation analytics refreshed');
  }
}