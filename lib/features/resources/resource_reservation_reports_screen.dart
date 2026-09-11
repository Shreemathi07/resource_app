import 'package:flutter/material.dart';

class ResourceReservationReportsScreen extends StatefulWidget {
  const ResourceReservationReportsScreen({super.key});

  @override
  State<ResourceReservationReportsScreen> createState() =>
      _ResourceReservationReportsScreenState();
}

class _ResourceReservationReportsScreenState
    extends State<ResourceReservationReportsScreen> {
  int selectedTab = 0;
  String selectedPeriod = '30 Days';

  final List<String> tabs = [
    'Overview',
    'Resources',
    'People',
    'Insights',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<Map<String, dynamic>> resourceReports = [
    {
      'name': 'Dell Latitude 5420',
      'category': 'Technology',
      'reservations': 48,
      'completed': 44,
      'cancelled': 3,
      'rejected': 1,
      'utilization': 91,
      'rating': 4.8,
      'icon': Icons.laptop_mac_outlined,
      'color': Colors.indigo,
    },
    {
      'name': 'Educational Books',
      'category': 'Education',
      'reservations': 39,
      'completed': 37,
      'cancelled': 1,
      'rejected': 1,
      'utilization': 86,
      'rating': 4.7,
      'icon': Icons.menu_book_outlined,
      'color': Colors.green,
    },
    {
      'name': 'Projector with Stand',
      'category': 'Electronics',
      'reservations': 31,
      'completed': 27,
      'cancelled': 3,
      'rejected': 1,
      'utilization': 79,
      'rating': 4.5,
      'icon': Icons.videocam_outlined,
      'color': Colors.orange,
    },
    {
      'name': 'Study Table Set',
      'category': 'Furniture',
      'reservations': 24,
      'completed': 22,
      'cancelled': 1,
      'rejected': 1,
      'utilization': 74,
      'rating': 4.6,
      'icon': Icons.table_restaurant_outlined,
      'color': Colors.teal,
    },
    {
      'name': 'Sports Equipment',
      'category': 'Sports',
      'reservations': 18,
      'completed': 16,
      'cancelled': 2,
      'rejected': 0,
      'utilization': 68,
      'rating': 4.4,
      'icon': Icons.sports_basketball_outlined,
      'color': Colors.deepPurple,
    },
  ];

  final List<Map<String, dynamic>> peopleReports = [
    {
      'name': 'VIT Resource Center',
      'role': 'Provider',
      'reservations': 72,
      'completed': 69,
      'success': 96,
      'rating': 4.9,
      'icon': Icons.business_outlined,
      'color': Colors.indigo,
    },
    {
      'name': 'Digital Learning Hub',
      'role': 'Seeker',
      'reservations': 51,
      'completed': 48,
      'success': 94,
      'rating': 4.8,
      'icon': Icons.school_outlined,
      'color': Colors.teal,
    },
    {
      'name': 'Community Resource Hub',
      'role': 'Provider',
      'reservations': 43,
      'completed': 39,
      'success': 91,
      'rating': 4.6,
      'icon': Icons.hub_outlined,
      'color': Colors.orange,
    },
    {
      'name': 'Student Support Center',
      'role': 'Seeker',
      'reservations': 38,
      'completed': 35,
      'success': 92,
      'rating': 4.7,
      'icon': Icons.people_outline,
      'color': Colors.green,
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
          'Reservation Reports',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          IconButton(
            onPressed: refreshData,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showReportOptions,
        icon: const Icon(
          Icons.add_chart_rounded,
        ),
        label: const Text(
          'Create Report',
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
            Colors.teal.shade600,
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
                  'Smart Analytics',
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
            'Reservation Reports',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understand reservation performance, resource utilization and community activity through intelligent reports.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric(
                '160',
                'Reservations',
              ),
              _heroMetric(
                '92%',
                'Completion',
              ),
              _heroMetric(
                '4.7/5',
                'Satisfaction',
              ),
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
          const SizedBox(height: 3),
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
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final period = periods[index];
          final selected = selectedPeriod == period;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPeriod = period;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                ),
              ),
              child: Text(
                period,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.grey.shade700,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        },
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
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
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
        return _buildResourcesTab();
      case 2:
        return _buildPeopleTab();
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
          'Performance Overview',
          'Reservation activity for $selectedPeriod',
          Icons.dashboard_outlined,
        ),
        const SizedBox(height: 14),
        _buildKpiGrid(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Reservation Trend',
          'Completed reservations by period',
          Icons.show_chart_rounded,
        ),
        const SizedBox(height: 12),
        _buildTrendChart(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Reservation Outcomes',
          'Current reservation distribution',
          Icons.pie_chart_outline_rounded,
        ),
        const SizedBox(height: 12),
        _buildOutcomeCard(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Category Performance',
          'Reservation activity by category',
          Icons.category_outlined,
        ),
        const SizedBox(height: 12),
        _buildCategoryPerformance(),
      ],
    );
  }

  Widget _buildKpiGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.65,
      children: [
        _kpiCard(
          '160',
          'Total Reservations',
          Icons.event_note_outlined,
          Colors.indigo,
          '+18%',
        ),
        _kpiCard(
          '147',
          'Completed',
          Icons.check_circle_outline,
          Colors.green,
          '+14%',
        ),
        _kpiCard(
          '8',
          'Cancelled',
          Icons.cancel_outlined,
          Colors.orange,
          '-6%',
        ),
        _kpiCard(
          '5',
          'Rejected',
          Icons.block_outlined,
          Colors.red,
          '-3%',
        ),
      ],
    );
  }

  Widget _kpiCard(
    String value,
    String label,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
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
                icon,
                size: 19,
                color: color,
              ),
              const Spacer(),
              Text(
                trend,
                style: TextStyle(
                  color: trend.startsWith('+')
                      ? Colors.green
                      : Colors.orange,
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
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

  Widget _buildTrendChart() {
    final values = [18, 25, 21, 31, 28, 36, 42];
    final labels = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Container(
      height: 235,
      padding: const EdgeInsets.fromLTRB(
        14,
        18,
        14,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                values.length,
                (index) {
                  final value = values[index];

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$value',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            height: value * 3.2,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.75),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            labels[index],
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildOutcomeCard() {
    final outcomes = [
      {
        'title': 'Completed',
        'value': '147',
        'percent': 92,
        'color': Colors.green,
      },
      {
        'title': 'Cancelled',
        'value': '8',
        'percent': 5,
        'color': Colors.orange,
      },
      {
        'title': 'Rejected',
        'value': '5',
        'percent': 3,
        'color': Colors.red,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: outcomes.map((item) {
          final color = item['color'] as Color;
          final percent = item['percent'] as int;

          return Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['title'].toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      item['value'].toString(),
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      '$percent%',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 7,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      color,
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

  Widget _buildCategoryPerformance() {
    final categories = [
      {
        'name': 'Technology',
        'count': 48,
        'growth': '+21%',
        'color': Colors.indigo,
      },
      {
        'name': 'Education',
        'count': 39,
        'growth': '+16%',
        'color': Colors.green,
      },
      {
        'name': 'Electronics',
        'count': 31,
        'growth': '+11%',
        'color': Colors.orange,
      },
      {
        'name': 'Furniture',
        'count': 24,
        'growth': '+8%',
        'color': Colors.teal,
      },
      {
        'name': 'Sports',
        'count': 18,
        'growth': '+5%',
        'color': Colors.deepPurple,
      },
    ];

    return Column(
      children: categories.map((category) {
        final color = category['color'] as Color;

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
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withValues(alpha: 0.09),
                child: Icon(
                  Icons.category_outlined,
                  color: color,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['name'].toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: (category['count'] as int) / 50,
                      minHeight: 5,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${category['count']}',
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    category['growth'].toString(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResourcesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Resource Utilization',
          'Performance of reserved resources',
          Icons.inventory_2_outlined,
        ),
        const SizedBox(height: 14),
        ...resourceReports.map(_buildResourceReportCard),
        const SizedBox(height: 18),
        _buildUtilizationSummary(),
      ],
    );
  }

  Widget _buildResourceReportCard(
    Map<String, dynamic> resource,
  ) {
    final color = resource['color'] as Color;

    return GestureDetector(
      onTap: () => _showResourceReport(resource),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                resource['icon'] as IconData,
                color: color,
                size: 21,
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
                    '${resource['category']} • ${resource['reservations']} reservations',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value:
                                (resource['utilization'] as int) / 100,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(
                              color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${resource['utilization']}%',
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilizationSummary() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.teal.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.speed_outlined,
            color: Colors.teal,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Network Utilization',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Resource utilization is currently at a healthy 82%, with technology resources showing the highest demand.',
                  style: TextStyle(
                    color: Colors.grey,
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

  Widget _buildPeopleTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'People & Participation',
          'Provider and seeker performance',
          Icons.people_outline_rounded,
        ),
        const SizedBox(height: 14),
        ...peopleReports.map(_buildPersonReportCard),
        const SizedBox(height: 18),
        _buildCommunitySummary(),
      ],
    );
  }

  Widget _buildPersonReportCard(
    Map<String, dynamic> person,
  ) {
    final color = person['color'] as Color;

    return GestureDetector(
      onTap: () => _showPersonReport(person),
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
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.09),
              child: Icon(
                person['icon'] as IconData,
                color: color,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person['name'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${person['role']} • ${person['reservations']} reservations',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${person['rating']}',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${person['success']}% success',
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
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

  Widget _buildCommunitySummary() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Community Summary',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _summaryMetric(
                '86',
                'Active members',
                Colors.indigo,
              ),
              _summaryMetric(
                '73',
                'Verified members',
                Colors.green,
              ),
              _summaryMetric(
                '4.7',
                'Avg rating',
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryMetric(
    String value,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildInsightsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Report Intelligence',
          'Smart patterns from reservation data',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 14),
        _insightCard(
          Icons.trending_up_rounded,
          'Reservation demand is rising',
          'Reservation activity has increased by 18% during the selected reporting period.',
          Colors.green,
        ),
        _insightCard(
          Icons.laptop_mac_outlined,
          'Technology is the strongest category',
          'Technology resources currently account for the largest portion of reservation demand.',
          Colors.indigo,
        ),
        _insightCard(
          Icons.speed_outlined,
          'Resource utilization is healthy',
          'Overall utilization is 82%, leaving enough capacity for additional community exchanges.',
          Colors.teal,
        ),
        _insightCard(
          Icons.schedule_outlined,
          'Peak reservation window',
          'The highest activity is consistently recorded during afternoon hours.',
          Colors.orange,
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Recommended Actions',
          'Improve future reservation performance',
          Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: 12),
        _recommendationCard(
          'Increase technology availability',
          'Add more laptop and computing-resource slots during peak hours.',
          Icons.add_business_outlined,
          Colors.indigo,
        ),
        _recommendationCard(
          'Improve cancellation prevention',
          'Send reminders before reservation pickup windows.',
          Icons.notifications_active_outlined,
          Colors.orange,
        ),
        _recommendationCard(
          'Prioritize reliable providers',
          'Use historical completion rates when recommending future reservations.',
          Icons.verified_outlined,
          Colors.green,
        ),
      ],
    );
  }

  Widget _insightCard(
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
          color: color.withValues(alpha: 0.14),
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
          const SizedBox(width: 11),
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
                const SizedBox(height: 5),
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

  Widget _recommendationCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: color.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
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

  void _showResourceReport(
    Map<String, dynamic> resource,
  ) {
    final color = resource['color'] as Color;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sheetHandle(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: color.withValues(alpha: 0.10),
                      child: Icon(
                        resource['icon'] as IconData,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        resource['name'].toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  resource['category'].toString(),
                ),
                _detailRow(
                  Icons.event_note_outlined,
                  'Reservations',
                  resource['reservations'].toString(),
                ),
                _detailRow(
                  Icons.check_circle_outline,
                  'Completed',
                  resource['completed'].toString(),
                ),
                _detailRow(
                  Icons.cancel_outlined,
                  'Cancelled',
                  resource['cancelled'].toString(),
                ),
                _detailRow(
                  Icons.block_outlined,
                  'Rejected',
                  resource['rejected'].toString(),
                ),
                _detailRow(
                  Icons.speed_outlined,
                  'Utilization',
                  '${resource['utilization']}%',
                ),
                _detailRow(
                  Icons.star_outline_rounded,
                  'Rating',
                  '${resource['rating']}/5',
                ),
                const SizedBox(height: 15),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Detailed resource report generated',
                    );
                  },
                  icon: const Icon(
                    Icons.description_outlined,
                  ),
                  label: const Text(
                    'Generate Detailed Report',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPersonReport(
    Map<String, dynamic> person,
  ) {
    final color = person['color'] as Color;

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
              _sheetHandle(),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: color.withValues(alpha: 0.10),
                    child: Icon(
                      person['icon'] as IconData,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      person['name'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.badge_outlined,
                'Role',
                person['role'].toString(),
              ),
              _detailRow(
                Icons.event_note_outlined,
                'Reservations',
                person['reservations'].toString(),
              ),
              _detailRow(
                Icons.check_circle_outline,
                'Completed',
                person['completed'].toString(),
              ),
              _detailRow(
                Icons.trending_up_rounded,
                'Success rate',
                '${person['success']}%',
              ),
              _detailRow(
                Icons.star_outline_rounded,
                'Rating',
                '${person['rating']}/5',
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar(
                    'Participant report generated',
                  );
                },
                icon: const Icon(
                  Icons.analytics_outlined,
                ),
                label: const Text(
                  'View Full Report',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetHandle() {
    return Center(
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportOptions() {
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
              _sheetHandle(),
              const SizedBox(height: 18),
              const Text(
                'Create Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              _reportOption(
                sheetContext,
                Icons.picture_as_pdf_outlined,
                'PDF Report',
                'Create a formatted reservation report.',
                Colors.red,
              ),
              _reportOption(
                sheetContext,
                Icons.table_chart_outlined,
                'CSV Report',
                'Export reservation data for analysis.',
                Colors.green,
              ),
              _reportOption(
                sheetContext,
                Icons.share_outlined,
                'Share Summary',
                'Share key reservation insights.',
                Colors.indigo,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _reportOption(
    BuildContext sheetContext,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(sheetContext);
        _showSnackBar('$title selected');
      },
      borderRadius: BorderRadius.circular(17),
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 21,
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
            const Icon(
              Icons.chevron_right_rounded,
              size: 19,
            ),
          ],
        ),
      ),
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
                  'Report Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.analytics_outlined,
                  'Your monthly report is ready',
                  '15 minutes ago',
                  Colors.indigo,
                ),
                _notificationItem(
                  Icons.trending_up_rounded,
                  'Reservation completion improved',
                  '2 hours ago',
                  Colors.green,
                ),
                _notificationItem(
                  Icons.auto_awesome_outlined,
                  'New smart insight available',
                  'Yesterday',
                  Colors.orange,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _notificationItem(
    IconData icon,
    String title,
    String time,
    Color color,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.09),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        time,
        style: const TextStyle(
          fontSize: 9,
        ),
      ),
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

    _showSnackBar(
      'Reservation reports refreshed',
    );
  }
}