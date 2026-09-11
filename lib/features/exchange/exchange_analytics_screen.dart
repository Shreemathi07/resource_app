import 'package:flutter/material.dart';

class ExchangeAnalyticsScreen extends StatefulWidget {
  const ExchangeAnalyticsScreen({super.key});

  @override
  State<ExchangeAnalyticsScreen> createState() =>
      _ExchangeAnalyticsScreenState();
}

class _ExchangeAnalyticsScreenState extends State<ExchangeAnalyticsScreen> {
  String selectedPeriod = '30 Days';
  int selectedTab = 0;

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> tabs = [
    'Overview',
    'Performance',
    'Members',
    'Insights',
  ];

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Study Materials',
      'count': 128,
      'percentage': 0.86,
      'growth': '+18%',
      'icon': Icons.menu_book_rounded,
    },
    {
      'name': 'Electronics',
      'count': 74,
      'percentage': 0.62,
      'growth': '+12%',
      'icon': Icons.devices_other_rounded,
    },
    {
      'name': 'Stationery',
      'count': 61,
      'percentage': 0.51,
      'growth': '+9%',
      'icon': Icons.edit_note_rounded,
    },
    {
      'name': 'Lab Equipment',
      'count': 43,
      'percentage': 0.36,
      'growth': '+6%',
      'icon': Icons.science_outlined,
    },
  ];

  final List<Map<String, dynamic>> members = [
    {
      'name': 'Aarav Kumar',
      'exchanges': 42,
      'success': '98%',
      'rating': '4.9',
      'status': 'Excellent',
    },
    {
      'name': 'Meera Nair',
      'exchanges': 36,
      'success': '97%',
      'rating': '4.8',
      'status': 'Excellent',
    },
    {
      'name': 'Rahul Dev',
      'exchanges': 31,
      'success': '95%',
      'rating': '4.7',
      'status': 'Reliable',
    },
    {
      'name': 'Priya S',
      'exchanges': 27,
      'success': '94%',
      'rating': '4.7',
      'status': 'Reliable',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Exchange Analytics',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showExportDialog,
            icon: const Icon(
              Icons.file_download_outlined,
              color: Color(0xFF18202A),
            ),
          ),
          IconButton(
            onPressed: showInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshAnalytics,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            buildHero(),
            const SizedBox(height: 18),
            buildPeriodSelector(),
            const SizedBox(height: 18),
            buildTabs(),
            const SizedBox(height: 18),
            buildSelectedContent(),
          ],
        ),
      ),
    );
  }

  Widget buildHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF18202A),
            Color(0xFF354354),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Exchange Performance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Overall exchange success',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '94.8%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  bottom: 8,
                ),
                child: Text(
                  '+6.4%',
                  style: TextStyle(
                    color: Color(0xFFB8F2D0),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Compared with the previous period',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.948,
              minHeight: 8,
              backgroundColor: Color(0x334A5564),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFB8F2D0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPeriodSelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final period = periods[index];
          final selected = selectedPeriod == period;

          return ChoiceChip(
            label: Text(period),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedPeriod = period;
              });
            },
            selectedColor: const Color(0xFF18202A),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected
                  ? Colors.white
                  : const Color(0xFF687382),
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          );
        },
      ),
    );
  }

  Widget buildTabs() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final selected = selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: selected
                          ? const Color(0xFF18202A)
                          : const Color(0xFF7A8491),
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

  Widget buildSelectedContent() {
    switch (selectedTab) {
      case 1:
        return buildPerformance();
      case 2:
        return buildMembers();
      case 3:
        return buildInsights();
      default:
        return buildOverview();
    }
  }

  Widget buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStatGrid(),
        const SizedBox(height: 22),
        sectionTitle(
          'Exchange activity',
          'Performance during $selectedPeriod',
        ),
        const SizedBox(height: 12),
        buildActivityChart(),
        const SizedBox(height: 22),
        sectionTitle(
          'Exchange outcomes',
          'Current distribution',
        ),
        const SizedBox(height: 12),
        buildOutcomeCard(),
        const SizedBox(height: 22),
        sectionTitle(
          'Top categories',
          'Most exchanged resources',
        ),
        const SizedBox(height: 12),
        ...categories.take(3).map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: categoryCard(item),
          ),
        ),
      ],
    );
  }

  Widget buildStatGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: analyticsStat(
                '286',
                'Completed',
                Icons.check_circle_outline_rounded,
                const Color(0xFF23844D),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: analyticsStat(
                '302',
                'Total exchanges',
                Icons.swap_horiz_rounded,
                const Color(0xFF3867D6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: analyticsStat(
                '4.6 hrs',
                'Avg. completion',
                Icons.timer_outlined,
                const Color(0xFFB27600),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: analyticsStat(
                '4.8/5',
                'Satisfaction',
                Icons.star_outline_rounded,
                const Color(0xFF8A5A00),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget analyticsStat(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7A8491),
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

  Widget buildActivityChart() {
    final values = [0.42, 0.58, 0.51, 0.73, 0.68, 0.88, 0.94];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Successful exchanges',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Text(
                '↑ 14.2%',
                style: TextStyle(
                  color: Color(0xFF23844D),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                values.length,
                (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${(values[index] * 100).round()}',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF7A8491),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 105 * values[index],
                            decoration: BoxDecoration(
                              color: const Color(0xFF3867D6),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            labels[index],
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF7A8491),
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

  Widget buildOutcomeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          outcomeRow(
            'Successfully completed',
            '286',
            0.948,
            const Color(0xFF23844D),
          ),
          const SizedBox(height: 15),
          outcomeRow(
            'Cancelled',
            '9',
            0.03,
            const Color(0xFF9AA3AE),
          ),
          const SizedBox(height: 15),
          outcomeRow(
            'Disputed',
            '5',
            0.017,
            const Color(0xFFC43D3D),
          ),
          const SizedBox(height: 15),
          outcomeRow(
            'Escalated',
            '2',
            0.007,
            const Color(0xFFB27600),
          ),
        ],
      ),
    );
  }

  Widget outcomeRow(
    String title,
    String value,
    double progress,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF596573),
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Color(0xFF18202A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: const Color(0xFFECEFF3),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget categoryCard(Map<String, dynamic> item) {
    return InkWell(
      onTap: () => showCategoryDetails(item),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3F6),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: const Color(0xFF3867D6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item['count']} exchanges',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              item['growth'].toString(),
              style: const TextStyle(
                color: Color(0xFF23844D),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9AA3AE),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPerformance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Performance indicators',
          'How efficiently exchanges are completed',
        ),
        const SizedBox(height: 12),
        performanceMetric(
          'Completion rate',
          '94.8%',
          0.948,
          Icons.task_alt_rounded,
          const Color(0xFF23844D),
        ),
        const SizedBox(height: 10),
        performanceMetric(
          'On-time handovers',
          '91.2%',
          0.912,
          Icons.schedule_rounded,
          const Color(0xFF3867D6),
        ),
        const SizedBox(height: 10),
        performanceMetric(
          'Member satisfaction',
          '96%',
          0.96,
          Icons.sentiment_satisfied_alt_rounded,
          const Color(0xFF8A5A00),
        ),
        const SizedBox(height: 10),
        performanceMetric(
          'Dispute-free exchanges',
          '98.3%',
          0.983,
          Icons.shield_outlined,
          const Color(0xFF6B4AA1),
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Efficiency analysis',
          'Key operational measurements',
        ),
        const SizedBox(height: 12),
        efficiencyCard(
          '4.6 hrs',
          'Average completion time',
          '↓ 38 min',
          Icons.timer_outlined,
        ),
        const SizedBox(height: 10),
        efficiencyCard(
          '18 min',
          'Average response time',
          '↓ 6 min',
          Icons.speed_rounded,
        ),
        const SizedBox(height: 10),
        efficiencyCard(
          '97%',
          'Resolution without escalation',
          '↑ 3.2%',
          Icons.support_agent_outlined,
        ),
      ],
    );
  }

  Widget performanceMetric(
    String title,
    String value,
    double progress,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18202A),
                        ),
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFECEFF3),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget efficiencyCard(
    String value,
    String title,
    String change,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF3867D6),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ],
            ),
          ),
          Text(
            change,
            style: const TextStyle(
              color: Color(0xFF23844D),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMembers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Top contributors',
          'Members with strong exchange performance',
        ),
        const SizedBox(height: 12),
        ...List.generate(
          members.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: memberCard(
              members[index],
              index + 1,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F5FF),
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: const Color(0xFFDCE7FF),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFF3867D6),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'High-performing members are 2.4x more likely to complete exchanges on time.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF4D5865),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget memberCard(
    Map<String, dynamic> member,
    int rank,
  ) {
    return InkWell(
      onTap: () => showMemberDetails(member),
      borderRadius: BorderRadius.circular(19),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3F6),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$rank',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF3867D6),
                ),
              ),
            ),
            const SizedBox(width: 11),
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F0FF),
                shape: BoxShape.circle,
              ),
              child: Text(
                member['name']
                    .toString()
                    .substring(0, 1),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF3867D6),
                ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${member['exchanges']} exchanges • ${member['success']} success',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF7A8491),
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
                      color: Color(0xFFB27600),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      member['rating'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  member['status'].toString(),
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF23844D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Smart insights',
          'Patterns detected from exchange activity',
        ),
        const SizedBox(height: 12),
        insightCard(
          Icons.trending_up_rounded,
          'Exchange activity is growing',
          'Weekly completed exchanges increased by 14.2%, mainly driven by study materials and electronics.',
          const Color(0xFF23844D),
        ),
        const SizedBox(height: 10),
        insightCard(
          Icons.location_on_outlined,
          'Nearby exchanges perform better',
          'Exchanges within a short distance have a higher completion rate and lower cancellation rate.',
          const Color(0xFF3867D6),
        ),
        const SizedBox(height: 10),
        insightCard(
          Icons.access_time_rounded,
          'Evening demand is increasing',
          'Most resource handovers are currently being scheduled between 4 PM and 8 PM.',
          const Color(0xFFB27600),
        ),
        const SizedBox(height: 10),
        insightCard(
          Icons.warning_amber_rounded,
          'Small dispute cluster detected',
          'Most recent disputes involve quantity confirmation and resource condition.',
          const Color(0xFFC43D3D),
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Recommended actions',
          'Improve future exchange performance',
        ),
        const SizedBox(height: 12),
        actionCard(
          Icons.fact_check_outlined,
          'Confirm resource quantity',
          'Add a confirmation step before handover.',
        ),
        const SizedBox(height: 10),
        actionCard(
          Icons.photo_camera_outlined,
          'Capture condition evidence',
          'Encourage members to upload condition photos.',
        ),
        const SizedBox(height: 10),
        actionCard(
          Icons.notifications_active_outlined,
          'Enable smart reminders',
          'Remind both parties before scheduled handovers.',
        ),
      ],
    );
  }

  Widget insightCard(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
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
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget actionCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF3867D6),
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
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF7A8491),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF18202A),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF7A8491),
          ),
        ),
      ],
    );
  }

  void showCategoryDetails(Map<String, dynamic> item) {
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
                Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: const Color(0xFF3867D6),
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['name'].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF18202A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                detailLine(
                  'Total exchanges',
                  '${item['count']}',
                ),
                detailLine(
                  'Growth',
                  item['growth'].toString(),
                ),
                detailLine(
                  'Demand level',
                  'High',
                ),
                detailLine(
                  'Completion rate',
                  '96.4%',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showMemberDetails(Map<String, dynamic> member) {
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
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: const Color(0xFFE8F0FF),
                  child: Text(
                    member['name']
                        .toString()
                        .substring(0, 1),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF3867D6),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  member['name'].toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${member['status']} contributor',
                  style: const TextStyle(
                    color: Color(0xFF23844D),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                detailLine(
                  'Exchanges',
                  '${member['exchanges']}',
                ),
                detailLine(
                  'Success rate',
                  member['success'].toString(),
                ),
                detailLine(
                  'Rating',
                  member['rating'].toString(),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget detailLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF7A8491),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18202A),
            ),
          ),
        ],
      ),
    );
  }

  void showExportDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Export Analytics',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'Choose a format to export the current exchange analytics report.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                showExportSuccess('PDF');
              },
              child: const Text('PDF'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                showExportSuccess('CSV');
              },
              child: const Text('CSV'),
            ),
          ],
        );
      },
    );
  }

  void showExportSuccess(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$format analytics report prepared successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showInfo() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Exchange Analytics',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'This dashboard analyzes exchange completion, satisfaction, member participation, resource categories and operational performance.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshAnalytics() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Exchange analytics updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}