import 'package:flutter/material.dart';

class CommunityNeedsIntelligenceScreen extends StatefulWidget {
  const CommunityNeedsIntelligenceScreen({super.key});

  @override
  State<CommunityNeedsIntelligenceScreen> createState() =>
      _CommunityNeedsIntelligenceScreenState();
}

class _CommunityNeedsIntelligenceScreenState
    extends State<CommunityNeedsIntelligenceScreen> {
  int selectedTab = 0;
  String selectedPeriod = '30 Days';
  String selectedCategory = 'All';
  String searchText = '';

  final List<String> tabs = [
    'Overview',
    'Demand',
    'Supply',
    'Insights',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> categories = [
    'All',
    'Education',
    'Food',
    'Medical',
    'Technology',
    'Clothing',
  ];

  final List<Map<String, dynamic>> needs = [
    {
      'title': 'Educational Laptops',
      'category': 'Technology',
      'location': 'Vellore',
      'requests': 48,
      'supply': 17,
      'gap': 31,
      'urgency': 'High',
      'trend': '+28%',
      'icon': Icons.laptop_mac_rounded,
    },
    {
      'title': 'School Stationery',
      'category': 'Education',
      'location': 'Katpadi',
      'requests': 72,
      'supply': 46,
      'gap': 26,
      'urgency': 'Medium',
      'trend': '+21%',
      'icon': Icons.menu_book_rounded,
    },
    {
      'title': 'Food Support Kits',
      'category': 'Food',
      'location': 'Vellore',
      'requests': 61,
      'supply': 29,
      'gap': 32,
      'urgency': 'High',
      'trend': '+34%',
      'icon': Icons.shopping_basket_rounded,
    },
    {
      'title': 'Medical Supplies',
      'category': 'Medical',
      'location': 'Ranipet',
      'requests': 44,
      'supply': 19,
      'gap': 25,
      'urgency': 'High',
      'trend': '+31%',
      'icon': Icons.medical_services_rounded,
    },
    {
      'title': 'Clothing Support',
      'category': 'Clothing',
      'location': 'Chennai',
      'requests': 39,
      'supply': 24,
      'gap': 15,
      'urgency': 'Medium',
      'trend': '+16%',
      'icon': Icons.checkroom_rounded,
    },
  ];

  final List<Map<String, dynamic>> locations = [
    {
      'name': 'Vellore',
      'demand': 86,
      'supply': 49,
      'gap': 37,
    },
    {
      'name': 'Katpadi',
      'demand': 72,
      'supply': 58,
      'gap': 14,
    },
    {
      'name': 'Ranipet',
      'demand': 64,
      'supply': 39,
      'gap': 25,
    },
    {
      'name': 'Chennai',
      'demand': 58,
      'supply': 52,
      'gap': 6,
    },
  ];

  List<Map<String, dynamic>> get filteredNeeds {
    return needs.where((need) {
      final categoryMatches = selectedCategory == 'All' ||
          need['category'] == selectedCategory;

      final text = searchText.toLowerCase();

      final searchMatches = text.isEmpty ||
          need['title'].toString().toLowerCase().contains(text) ||
          need['category'].toString().toLowerCase().contains(text) ||
          need['location'].toString().toLowerCase().contains(text);

      return categoryMatches && searchMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7FB),
        elevation: 0,
        title: const Text(
          'Needs Intelligence',
          style: TextStyle(
            color: Color(0xFF182033),
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF182033),
            ),
          ),
          IconButton(
            onPressed: refreshData,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF182033),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            buildHero(),
            const SizedBox(height: 20),
            buildSearch(),
            const SizedBox(height: 14),
            buildPeriodSelector(),
            const SizedBox(height: 14),
            buildTabs(),
            const SizedBox(height: 20),
            buildSelectedContent(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showCreateRequirement,
        backgroundColor: const Color(0xFF5B5FEF),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Create Requirement',
          style: TextStyle(fontWeight: FontWeight.w700),
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
            Color(0xFF5559E8),
            Color(0xFF777BF5),
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
                  Icons.psychology_rounded,
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
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'AI Powered',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Community Needs\nIntelligence',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Understand community demand and identify resource opportunities before shortages occur.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              buildHeroMetric('284', 'Active Needs'),
              buildHeroDivider(),
              buildHeroMetric('91%', 'Demand Signal'),
              buildHeroDivider(),
              buildHeroMetric('37', 'Urgent'),
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
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeroDivider() {
    return Container(
      width: 1,
      height: 34,
      color: Colors.white.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget buildSearch() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search needs, categories or locations...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: showFilters,
          icon: const Icon(Icons.tune_rounded),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
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
          final selected = period == selectedPeriod;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPeriod = period;
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
                      : const Color(0xFFE3E6EF),
                ),
              ),
              child: Text(
                period,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF626A7B),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
        color: const Color(0xFFE8EAF2),
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
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFF5559E8)
                          : const Color(0xFF747B8B),
                      fontSize: 11,
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

  Widget buildSelectedContent() {
    if (selectedTab == 0) {
      return buildOverview();
    }

    if (selectedTab == 1) {
      return buildDemand();
    }

    if (selectedTab == 2) {
      return buildSupply();
    }

    return buildInsights();
  }

  Widget buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Demand Overview',
          'Real-time community requirement signals',
        ),
        const SizedBox(height: 14),
        buildStats(),
        const SizedBox(height: 22),
        sectionTitle(
          'Demand Heatmap',
          'Areas with higher unmet demand',
        ),
        const SizedBox(height: 14),
        buildHeatmap(),
        const SizedBox(height: 22),
        sectionTitle(
          'Priority Needs',
          'Requirements that need attention',
        ),
        const SizedBox(height: 14),
        buildNeedsList(),
      ],
    );
  }

  Widget buildStats() {
    final stats = [
      ['284', 'Total Requests', '+18%', Icons.assignment_rounded],
      ['97', 'Unmet Needs', '+11%', Icons.warning_amber_rounded],
      ['78%', 'Avg. Urgency', '+7%', Icons.priority_high_rounded],
      ['86%', 'Match Potential', '+15%', Icons.track_changes_rounded],
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
              color: const Color(0xFFE6E9F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F1FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      stat[3] as IconData,
                      color: const Color(0xFF5B5FEF),
                      size: 18,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    stat[2] as String,
                    style: const TextStyle(
                      color: Color(0xFF21966A),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                stat[0] as String,
                style: const TextStyle(
                  color: Color(0xFF1C2537),
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                stat[1] as String,
                style: const TextStyle(
                  color: Color(0xFF7A8292),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildHeatmap() {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: CustomPaint(
                painter: DemandHeatmapPainter(),
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 18,
            child: mapLabel('Vellore', '86%'),
          ),
          Positioned(
            top: 72,
            right: 22,
            child: mapLabel('Katpadi', '72%'),
          ),
          Positioned(
            bottom: 55,
            left: 35,
            child: mapLabel('Ranipet', '64%'),
          ),
          Positioned(
            bottom: 20,
            right: 25,
            child: mapLabel('Chennai', '58%'),
          ),
        ],
      ),
    );
  }

  Widget mapLabel(String name, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF30384A),
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            '$value demand',
            style: const TextStyle(
              color: Color(0xFF5B5FEF),
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNeedsList() {
    if (filteredNeeds.isEmpty) {
      return emptyState();
    }

    return Column(
      children: filteredNeeds.map(buildNeedCard).toList(),
    );
  }

  Widget buildNeedCard(Map<String, dynamic> need) {
    final highPriority = need['urgency'] == 'High';

    return GestureDetector(
      onTap: () => showNeedDetails(need),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE6E9F0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F1FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    need['icon'] as IconData,
                    color: const Color(0xFF5B5FEF),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        need['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF20293B),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: Color(0xFF858C9B),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            need['location'] as String,
                            style: const TextStyle(
                              color: Color(0xFF858C9B),
                              fontSize: 10,
                            ),
                          ),
                        ],
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
                    color: highPriority
                        ? const Color(0xFFFFEEEE)
                        : const Color(0xFFFFF5E9),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    need['urgency'] as String,
                    style: TextStyle(
                      color: highPriority
                          ? const Color(0xFFE15B5B)
                          : const Color(0xFFD28A31),
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
                miniStat('Requests', '${need['requests']}'),
                miniStat('Supply', '${need['supply']}'),
                miniStat('Unmet', '${need['gap']}'),
                miniStat('Trend', need['trend'] as String),
              ],
            ),
            const SizedBox(height: 13),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                minHeight: 7,
                value:
                    (need['supply'] as int) / (need['requests'] as int),
                backgroundColor: const Color(0xFFECEFF3),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF5B5FEF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget miniStat(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF30384A),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF858C9B),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDemand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Demand Analysis',
          'Compare current demand with available supply',
        ),
        const SizedBox(height: 14),
        buildDemandComparison(),
        const SizedBox(height: 22),
        sectionTitle(
          'Unmet Opportunities',
          'Areas where providers can create impact',
        ),
        const SizedBox(height: 14),
        ...filteredNeeds.map(buildOpportunityCard),
        const SizedBox(height: 10),
        buildDemandInsight(),
      ],
    );
  }

  Widget buildDemandComparison() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Column(
        children: [
          buildComparisonRow('Technology', 88, 42),
          buildComparisonRow('Food', 82, 47),
          buildComparisonRow('Education', 76, 61),
          buildComparisonRow('Medical', 69, 38),
          buildComparisonRow('Clothing', 55, 44),
        ],
      ),
    );
  }

  Widget buildComparisonRow(
    String name,
    int demand,
    int supply,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF555E70),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                'Demand $demand%',
                style: const TextStyle(
                  color: Color(0xFF5B5FEF),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            minHeight: 7,
            value: demand / 100,
            backgroundColor: const Color(0xFFECEFF3),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF5B5FEF),
            ),
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            minHeight: 4,
            value: supply / 100,
            backgroundColor: const Color(0xFFECEFF3),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF35B58A),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpportunityCard(Map<String, dynamic> need) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Color(0xFFE68B35),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  need['title'] as String,
                  style: const TextStyle(
                    color: Color(0xFF202A3C),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${need['gap']} resources currently unmet',
                  style: const TextStyle(
                    color: Color(0xFF7C8494),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'HIGH',
            style: TextStyle(
              color: Color(0xFF21966A),
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDemandInsight() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.insights_rounded,
            color: Color(0xFF5B5FEF),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Technology demand is growing faster than available supply. Laptop requirements may become a critical shortage if the current trend continues.',
              style: TextStyle(
                color: Color(0xFF5F6580),
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupply() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Supply Coverage',
          'How available resources cover community needs',
        ),
        const SizedBox(height: 14),
        buildCoverageCard(),
        const SizedBox(height: 22),
        sectionTitle(
          'Location Intelligence',
          'Demand and supply by location',
        ),
        const SizedBox(height: 14),
        ...locations.map(buildLocationCard),
        const SizedBox(height: 12),
        buildSupplyRecommendation(),
      ],
    );
  }

  Widget buildCoverageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 92,
            width: 92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.67,
                  strokeWidth: 9,
                  backgroundColor: const Color(0xFFECEFF3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF35B58A),
                  ),
                ),
                const Text(
                  '67%',
                  style: TextStyle(
                    color: Color(0xFF202A3C),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Supply Coverage',
                  style: TextStyle(
                    color: Color(0xFF202A3C),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  '67% of active requirements currently have matching resources.',
                  style: TextStyle(
                    color: Color(0xFF7A8292),
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationCard(Map<String, dynamic> location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Color(0xFF5B5FEF),
                size: 19,
              ),
              const SizedBox(width: 8),
              Text(
                location['name'] as String,
                style: const TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '${location['gap']} gap',
                style: const TextStyle(
                  color: Color(0xFFE05D58),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          buildLocationProgress(
            'Demand',
            location['demand'] as int,
            const Color(0xFF5B5FEF),
          ),
          const SizedBox(height: 9),
          buildLocationProgress(
            'Supply',
            location['supply'] as int,
            const Color(0xFF35B58A),
          ),
        ],
      ),
    );
  }

  Widget buildLocationProgress(
    String label,
    int value,
    Color color,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 52,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7C8494),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            minHeight: 6,
            value: value / 100,
            backgroundColor: const Color(0xFFECEFF3),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          '$value%',
          style: const TextStyle(
            color: Color(0xFF4E5667),
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget buildSupplyRecommendation() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFECFAF5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF21966A),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Redirecting available resources toward Vellore and Ranipet could significantly reduce the current unmet-demand gap.',
              style: TextStyle(
                color: Color(0xFF528273),
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Intelligent Insights',
          'Important patterns detected from community activity',
        ),
        const SizedBox(height: 14),
        buildInsight(
          Icons.devices_rounded,
          'Technology shortage detected',
          'Laptop and tablet requests are increasing faster than local supply.',
          '94%',
        ),
        buildInsight(
          Icons.restaurant_rounded,
          'Food demand rising',
          'Food support requirements have increased significantly.',
          '89%',
        ),
        buildInsight(
          Icons.location_on_rounded,
          'Vellore needs attention',
          'Vellore currently has the highest demand-to-supply gap.',
          '92%',
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Opportunity Radar',
          'Where ResourceX can create the most impact',
        ),
        const SizedBox(height: 14),
        buildOpportunityRadar(),
        const SizedBox(height: 22),
        buildSeekerPatterns(),
        const SizedBox(height: 22),
        buildSmartRecommendation(),
      ],
    );
  }

  Widget buildInsight(
    IconData icon,
    String title,
    String description,
    String score,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5B5FEF),
              size: 20,
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
                          color: Color(0xFF202A3C),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      score,
                      style: const TextStyle(
                        color: Color(0xFF5B5FEF),
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF777F90),
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpportunityRadar() {
    final opportunities = [
      ['Technology', 94, Icons.devices_rounded],
      ['Food Support', 89, Icons.restaurant_rounded],
      ['Medical', 86, Icons.medical_services_rounded],
      ['Education', 81, Icons.school_rounded],
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Column(
        children: opportunities.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Icon(
                  item[2] as IconData,
                  color: const Color(0xFF5B5FEF),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item[0] as String,
                    style: const TextStyle(
                      color: Color(0xFF555E70),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: LinearProgressIndicator(
                    minHeight: 7,
                    value: (item[1] as int) / 100,
                    backgroundColor: const Color(0xFFECEFF3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      Color(0xFF5B5FEF),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${item[1]}%',
                  style: const TextStyle(
                    color: Color(0xFF5B5FEF),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildSeekerPatterns() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE6E9F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.groups_rounded,
                color: Color(0xFF5B5FEF),
              ),
              SizedBox(width: 9),
              Text(
                'Seeker Demand Patterns',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          patternRow('Repeat requirements', '42%'),
          patternRow('First-time seekers', '31%'),
          patternRow('Urgent requests', '19%'),
          patternRow('Scheduled needs', '8%'),
        ],
      ),
    );
  }

  Widget patternRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 7,
            color: Color(0xFF9AA1AF),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF626A7B),
                fontSize: 11,
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
        ],
      ),
    );
  }

  Widget buildSmartRecommendation() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5B5FEF),
            Color(0xFF777BF5),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 21,
              ),
              SizedBox(width: 9),
              Text(
                'Smart Recommendation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Focus outreach on laptop, food-kit and medical-supply providers around Vellore and Ranipet.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 11,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: showRecommendation,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
            icon: const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
            ),
            label: const Text(
              'View Recommendation',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, String subtitle) {
    return Column(
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
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget emptyState() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: Color(0xFF9AA1B0),
          ),
          SizedBox(height: 12),
          Text(
            'No matching needs',
            style: TextStyle(
              color: Color(0xFF343C4E),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try another search or category.',
            style: TextStyle(
              color: Color(0xFF7C8494),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void showFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Needs',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: category == selectedCategory,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                      Navigator.pop(sheetContext);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void showNeedDetails(Map<String, dynamic> need) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F1FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      need['icon'] as IconData,
                      color: const Color(0xFF5B5FEF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      need['title'] as String,
                      style: const TextStyle(
                        color: Color(0xFF202A3C),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              detailRow('Category', need['category'] as String),
              detailRow('Location', need['location'] as String),
              detailRow('Requests', '${need['requests']}'),
              detailRow('Available Supply', '${need['supply']}'),
              detailRow('Unmet Need', '${need['gap']}'),
              detailRow('Urgency', need['urgency'] as String),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    showSnackBar('Searching for suitable matches...');
                  },
                  icon: const Icon(Icons.link_rounded),
                  label: const Text('Find Matches'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF7B8392),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF30384A),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  void showCreateRequirement() {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Requirement',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Tell the community what resource is needed.',
                style: TextStyle(
                  color: Color(0xFF7A8292),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'What is needed?',
                  hintText: 'Example: 5 laptops for students',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    showSnackBar('Requirement created successfully');
                  },
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Publish Requirement'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showRecommendation() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Smart Recommendation',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Text(
            'ResourceX recommends prioritizing technology, food and medical resources around Vellore and Ranipet because these areas currently show the strongest combination of urgency and unmet demand.',
            style: TextStyle(height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                showSnackBar('Recommendation saved');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showNotifications() {
    showSnackBar('No new intelligence alerts');
  }

  Future<void> refreshData() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 600),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
    showSnackBar('Needs intelligence updated');
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

class DemandHeatmapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = const Color(0xFFF1F3F8);

    canvas.drawRect(
      Offset.zero & size,
      backgroundPaint,
    );

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final roadLinePaint = Paint()
      ..color = const Color(0xFFDDE2EC)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final roadOne = Path()
      ..moveTo(0, size.height * 0.30)
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.45,
        size.width * 0.55,
        size.height * 0.32,
      )
      ..quadraticBezierTo(
        size.width * 0.80,
        size.height * 0.22,
        size.width,
        size.height * 0.40,
      );

    final roadTwo = Path()
      ..moveTo(size.width * 0.18, size.height)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.62,
        size.width * 0.47,
        size.height * 0.38,
      )
      ..quadraticBezierTo(
        size.width * 0.58,
        size.height * 0.18,
        size.width * 0.75,
        0,
      );

    canvas.drawPath(roadOne, roadPaint);
    canvas.drawPath(roadOne, roadLinePaint);
    canvas.drawPath(roadTwo, roadPaint);
    canvas.drawPath(roadTwo, roadLinePaint);

    drawHeatPoint(
      canvas,
      Offset(size.width * 0.30, size.height * 0.37),
      48,
      const Color(0xFF6B6FF0),
    );

    drawHeatPoint(
      canvas,
      Offset(size.width * 0.68, size.height * 0.30),
      39,
      const Color(0xFF969AF7),
    );

    drawHeatPoint(
      canvas,
      Offset(size.width * 0.30, size.height * 0.72),
      34,
      const Color(0xFF8589F5),
    );

    drawHeatPoint(
      canvas,
      Offset(size.width * 0.82, size.height * 0.67),
      25,
      const Color(0xFFB9BCFC),
    );
  }

  void drawHeatPoint(
    Canvas canvas,
    Offset center,
    double radius,
    Color color,
  ) {
    final outerPaint = Paint()
      ..color = color.withValues(alpha: 0.12);

    final innerPaint = Paint()
      ..color = color.withValues(alpha: 0.28);

    canvas.drawCircle(
      center,
      radius,
      outerPaint,
    );

    canvas.drawCircle(
      center,
      radius * 0.52,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}