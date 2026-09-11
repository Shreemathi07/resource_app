import 'package:flutter/material.dart';

class RequirementAnalyticsScreen extends StatefulWidget {
  const RequirementAnalyticsScreen({super.key});

  @override
  State<RequirementAnalyticsScreen> createState() =>
      _RequirementAnalyticsScreenState();
}

class _RequirementAnalyticsScreenState
    extends State<RequirementAnalyticsScreen> {
  int selectedPeriod = 1;
  int selectedTab = 0;

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> tabs = [
    'Overview',
    'Demand',
    'Fulfillment',
    'Insights',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7FB),
        elevation: 0,
        title: const Text(
          'Requirement Analytics',
          style: TextStyle(
            color: Color(0xFF1D2638),
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF30384A),
            ),
          ),
          IconButton(
            onPressed: refreshData,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF30384A),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          buildHero(),
          const SizedBox(height: 18),
          buildPeriodSelector(),
          const SizedBox(height: 16),
          buildTabs(),
          const SizedBox(height: 20),
          if (selectedTab == 0) buildOverview(),
          if (selectedTab == 1) buildDemand(),
          if (selectedTab == 2) buildFulfillment(),
          if (selectedTab == 3) buildInsights(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showReportOptions,
        backgroundColor: const Color(0xFF5B5FEF),
        icon: const Icon(Icons.analytics_rounded),
        label: const Text(
          'Generate Report',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4E54E8),
            Color(0xFF777CF5),
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
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.insights_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'AI Insights',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Requirement\nPerformance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Understand demand, fulfillment speed and community resource gaps.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              buildHeroMetric('286', 'Requirements'),
              buildDivider(),
              buildHeroMetric('76%', 'Fulfilled'),
              buildDivider(),
              buildHeroMetric('4.6h', 'Avg. Match'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeroMetric(String value, String label) {
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
              color: Colors.white.withValues(alpha: 0.74),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      width: 1,
      height: 34,
      color: Colors.white.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget buildPeriodSelector() {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(
          periods.length,
          (index) {
            final selected = selectedPeriod == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPeriod = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    periods[index],
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFF5559E8)
                          : const Color(0xFF777F90),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
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

  Widget buildTabs() {
    return SizedBox(
      height: 42,
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF5B5FEF)
                    : Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF5B5FEF)
                      : const Color(0xFFE2E5ED),
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF697183),
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

  Widget buildOverview() {
    return Column(
      children: [
        buildStatsGrid(),
        const SizedBox(height: 22),
        buildSectionTitle(
          'Requirement Activity',
          'New requirements created over time',
        ),
        const SizedBox(height: 13),
        buildActivityChart(),
        const SizedBox(height: 22),
        buildSectionTitle(
          'Top Requirement Categories',
          'Categories generating the highest demand',
        ),
        const SizedBox(height: 13),
        buildCategoryCard(
          'Technology',
          '86',
          0.82,
          Icons.devices_rounded,
        ),
        buildCategoryCard(
          'Education',
          '64',
          0.68,
          Icons.school_rounded,
        ),
        buildCategoryCard(
          'Food',
          '51',
          0.54,
          Icons.restaurant_rounded,
        ),
        buildCategoryCard(
          'Medical',
          '39',
          0.42,
          Icons.medical_services_rounded,
        ),
      ],
    );
  }

  Widget buildStatsGrid() {
    final stats = [
      ['286', 'Total Requests', Icons.assignment_rounded],
      ['218', 'Fulfilled', Icons.task_alt_rounded],
      ['42', 'In Progress', Icons.pending_actions_rounded],
      ['26', 'Unmet', Icons.warning_amber_rounded],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: const Color(0xFFE5E8EF),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                stat[2] as IconData,
                color: const Color(0xFF5B5FEF),
                size: 21,
              ),
              const Spacer(),
              Text(
                stat[0] as String,
                style: const TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                stat[1] as String,
                style: const TextStyle(
                  color: Color(0xFF7D8493),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildActivityChart() {
    final values = [0.35, 0.52, 0.44, 0.72, 0.62, 0.88, 0.76];

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '286',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                '+18.4%',
                style: TextStyle(
                  color: Color(0xFF27A879),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              const Text(
                'Requests',
                style: TextStyle(
                  color: Color(0xFF858C9B),
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                values.length,
                (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FractionallySizedBox(
                        heightFactor: values[index],
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF686CF0),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 9),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Mon'),
              Text('Tue'),
              Text('Wed'),
              Text('Thu'),
              Text('Fri'),
              Text('Sat'),
              Text('Sun'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategoryCard(
    String title,
    String count,
    double progress,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5B5FEF),
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF30384A),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      count,
                      style: const TextStyle(
                        color: Color(0xFF30384A),
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFECEEF3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      Color(0xFF686CF0),
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

  Widget buildDemand() {
    return Column(
      children: [
        buildSectionTitle(
          'Demand Intelligence',
          'Where the community needs resources most',
        ),
        const SizedBox(height: 13),
        buildDemandCard(
          'Laptop & Computer Access',
          'Very High',
          '86 requests',
          0.91,
          Icons.laptop_mac_rounded,
        ),
        buildDemandCard(
          'Academic Books',
          'High',
          '64 requests',
          0.73,
          Icons.menu_book_rounded,
        ),
        buildDemandCard(
          'Food Support',
          'High',
          '51 requests',
          0.68,
          Icons.fastfood_rounded,
        ),
        buildDemandCard(
          'Medical Supplies',
          'Medium',
          '39 requests',
          0.48,
          Icons.medical_services_rounded,
        ),
        const SizedBox(height: 18),
        buildOpportunityCard(),
      ],
    );
  }

  Widget buildDemandCard(
    String title,
    String level,
    String requests,
    double progress,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5B5FEF),
              size: 21,
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
                    color: Color(0xFF30384A),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  requests,
                  style: const TextStyle(
                    color: Color(0xFF7C8493),
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFECEEF3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      Color(0xFF686CF0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            level,
            style: TextStyle(
              color: level == 'Very High'
                  ? const Color(0xFFE05D58)
                  : const Color(0xFFD58931),
              fontSize: 9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpportunityCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFE4B7),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: Color(0xFFD58931),
            size: 23,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High-Value Opportunity',
                  style: TextStyle(
                    color: Color(0xFF5C4A2E),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Technology resources currently have the largest unmet demand. Increasing supply in this category could improve fulfillment by approximately 14%.',
                  style: TextStyle(
                    color: Color(0xFF806D4C),
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFulfillment() {
    return Column(
      children: [
        buildSectionTitle(
          'Fulfillment Performance',
          'How efficiently requirements are being completed',
        ),
        const SizedBox(height: 13),
        buildFulfillmentOverview(),
        const SizedBox(height: 20),
        buildMetricCard(
          'Average Match Time',
          '4.6 hours',
          '18% faster',
          Icons.speed_rounded,
        ),
        buildMetricCard(
          'Successful Fulfillment',
          '76%',
          '+8.2%',
          Icons.task_alt_rounded,
        ),
        buildMetricCard(
          'Provider Response',
          '91%',
          '+5.6%',
          Icons.reply_rounded,
        ),
        buildMetricCard(
          'Requirement Satisfaction',
          '4.8 / 5',
          '+0.3',
          Icons.star_rounded,
        ),
        const SizedBox(height: 18),
        buildBottleneckCard(),
      ],
    );
  }

  Widget buildFulfillmentOverview() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              buildCircleProgress(0.76),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '76% Fulfilled',
                      style: TextStyle(
                        color: Color(0xFF202A3C),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '218 of 286 requirements successfully completed.',
                      style: TextStyle(
                        color: Color(0xFF7B8392),
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
          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '42',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'In Progress',
                      style: TextStyle(
                        color: Color(0xFF818898),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '26',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Unmet',
                      style: TextStyle(
                        color: Color(0xFF818898),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '18',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Expired',
                      style: TextStyle(
                        color: Color(0xFF818898),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCircleProgress(double value) {
    return SizedBox(
      width: 78,
      height: 78,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 78,
            height: 78,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: 8,
              backgroundColor: const Color(0xFFE9EBF1),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(
                Color(0xFF5B5FEF),
              ),
            ),
          ),
          Text(
            '${(value * 100).round()}%',
            style: const TextStyle(
              color: Color(0xFF30384A),
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMetricCard(
    String title,
    String value,
    String change,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF5B5FEF),
            size: 21,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF626B7C),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF30384A),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 9),
          Text(
            change,
            style: const TextStyle(
              color: Color(0xFF27A879),
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottleneckCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFD5D5),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFE05D58),
            size: 23,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fulfillment Bottleneck',
                  style: TextStyle(
                    color: Color(0xFF9A3F3B),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Medical and technology requirements are taking longer than average to find suitable providers.',
                  style: TextStyle(
                    color: Color(0xFF925D5A),
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInsights() {
    return Column(
      children: [
        buildSectionTitle(
          'Smart Insights',
          'Intelligent observations from requirement activity',
        ),
        const SizedBox(height: 13),
        buildInsight(
          Icons.trending_up_rounded,
          'Technology demand increased 24%',
          'Laptop and computer-related requirements are growing faster than other categories.',
          'High Impact',
        ),
        buildInsight(
          Icons.location_on_outlined,
          'Vellore has the highest demand',
          'Most active requirements currently originate from the Vellore community.',
          'Location',
        ),
        buildInsight(
          Icons.speed_rounded,
          'Matching is becoming faster',
          'Average provider matching time improved by 18% compared with the previous period.',
          'Positive',
        ),
        buildInsight(
          Icons.people_outline_rounded,
          'Provider participation is rising',
          'More verified providers are responding to community requirements.',
          'Growth',
        ),
        const SizedBox(height: 20),
        buildRecommendation(),
        const SizedBox(height: 20),
        buildForecastCard(),
      ],
    );
  }

  Widget buildInsight(
    IconData icon,
    String title,
    String description,
    String tag,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5B5FEF),
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
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
                          color: Color(0xFF30384A),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F7),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Color(0xFF737B8B),
                          fontSize: 7,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF7A8292),
                    fontSize: 9,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecommendation() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF0F1FF),
            Color(0xFFF8F8FF),
          ],
        ),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFDDE0FF),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF5B5FEF),
            size: 24,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Action',
                  style: TextStyle(
                    color: Color(0xFF4D52D7),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Encourage more technology providers to list available laptops and devices. This could address the largest current demand gap.',
                  style: TextStyle(
                    color: Color(0xFF697183),
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForecastCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.insights_rounded,
                color: Color(0xFF5B5FEF),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Demand Forecast',
                style: TextStyle(
                  color: Color(0xFF30384A),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Based on recent activity, technology and education requirements are expected to remain the highest-demand categories over the next period.',
            style: TextStyle(
              color: Color(0xFF777F90),
              fontSize: 10,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              buildForecastItem(
                'Technology',
                '↑ 22%',
              ),
              buildForecastItem(
                'Education',
                '↑ 14%',
              ),
              buildForecastItem(
                'Food',
                '↑ 8%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildForecastItem(
    String title,
    String value,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF27A879),
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF858C9B),
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1D2638),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF7B8392),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.more_horiz_rounded,
          color: Color(0xFF89909E),
        ),
      ],
    );
  }

  void showReportOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Generate Analytics Report',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              reportOption(
                Icons.picture_as_pdf_rounded,
                'Export PDF Report',
              ),
              reportOption(
                Icons.table_chart_rounded,
                'Export CSV Data',
              ),
              reportOption(
                Icons.share_rounded,
                'Share Summary',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    showSnackBar('Report generation started');
                  },
                  child: const Text('Generate'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget reportOption(
    IconData icon,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF5B5FEF),
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF30384A),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9299A8),
          ),
        ],
      ),
    );
  }

  void showInfo() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Requirement Analytics',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Text(
            'This dashboard analyzes requirement activity, demand patterns, fulfillment performance and intelligent community opportunities.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshData() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    showSnackBar('Analytics refreshed');
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}