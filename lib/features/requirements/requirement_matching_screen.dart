import 'package:flutter/material.dart';

class RequirementMatchingScreen extends StatefulWidget {
  const RequirementMatchingScreen({super.key});

  @override
  State<RequirementMatchingScreen> createState() =>
      _RequirementMatchingScreenState();
}

class _RequirementMatchingScreenState
    extends State<RequirementMatchingScreen> {
  int selectedTab = 0;
  String selectedCategory = 'All';
  String selectedSort = 'Best Match';
  String searchText = '';

  final List<String> tabs = [
    'Best Matches',
    'Nearby',
    'Urgent',
    'Saved',
  ];

  final List<String> categories = [
    'All',
    'Technology',
    'Education',
    'Food',
    'Medical',
    'Clothing',
  ];

  final List<Map<String, dynamic>> matches = [
    {
      'resource': 'Dell Latitude Laptops',
      'provider': 'VIT Community Hub',
      'category': 'Technology',
      'location': 'Vellore',
      'distance': '1.8 km',
      'score': 96,
      'availability': 'Available',
      'quantity': '8 units',
      'condition': 'Excellent',
      'verified': true,
      'icon': Icons.laptop_mac_rounded,
      'reason': 'Category, quantity and location strongly match.',
    },
    {
      'resource': 'Engineering Textbooks',
      'provider': 'Student Resource Circle',
      'category': 'Education',
      'location': 'Katpadi',
      'distance': '3.2 km',
      'score': 92,
      'availability': 'Available',
      'quantity': '35 books',
      'condition': 'Good',
      'verified': true,
      'icon': Icons.menu_book_rounded,
      'reason': 'Strong category and requirement compatibility.',
    },
    {
      'resource': 'Community Food Kits',
      'provider': 'Hope Community Group',
      'category': 'Food',
      'location': 'Vellore',
      'distance': '4.1 km',
      'score': 89,
      'availability': 'Available',
      'quantity': '24 kits',
      'condition': 'Fresh',
      'verified': true,
      'icon': Icons.shopping_basket_rounded,
      'reason': 'High urgency and location compatibility.',
    },
    {
      'resource': 'First Aid Supplies',
      'provider': 'Care Support Network',
      'category': 'Medical',
      'location': 'Ranipet',
      'distance': '7.4 km',
      'score': 84,
      'availability': 'Limited',
      'quantity': '12 kits',
      'condition': 'New',
      'verified': true,
      'icon': Icons.medical_services_rounded,
      'reason': 'Medical category and urgency match.',
    },
    {
      'resource': 'Winter Clothing Collection',
      'provider': 'Community Volunteers',
      'category': 'Clothing',
      'location': 'Chennai',
      'distance': '9.8 km',
      'score': 78,
      'availability': 'Available',
      'quantity': '46 items',
      'condition': 'Good',
      'verified': false,
      'icon': Icons.checkroom_rounded,
      'reason': 'Good category compatibility with longer distance.',
    },
  ];

  List<Map<String, dynamic>> get filteredMatches {
    return matches.where((match) {
      final categoryMatch = selectedCategory == 'All' ||
          match['category'] == selectedCategory;

      final search = searchText.toLowerCase();

      final searchMatch = search.isEmpty ||
          match['resource'].toString().toLowerCase().contains(search) ||
          match['provider'].toString().toLowerCase().contains(search) ||
          match['category'].toString().toLowerCase().contains(search);

      final tabMatch = switch (selectedTab) {
        0 => true,
        1 => (match['distance'] as String).contains('1.') ||
            (match['distance'] as String).contains('3.') ||
            (match['distance'] as String).contains('4.'),
        2 => (match['score'] as int) >= 89,
        3 => match['score'] as int >= 90,
        _ => true,
      };

      return categoryMatch && searchMatch && tabMatch;
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
          'Requirement Matching',
          style: TextStyle(
            color: Color(0xFF1D2638),
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showMatchingInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF30384A),
            ),
          ),
          IconButton(
            onPressed: refreshMatches,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF30384A),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshMatches,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            buildHero(),
            const SizedBox(height: 18),
            buildSearch(),
            const SizedBox(height: 14),
            buildCategoryFilter(),
            const SizedBox(height: 16),
            buildTabs(),
            const SizedBox(height: 20),
            buildOverviewStats(),
            const SizedBox(height: 22),
            buildMatchHeader(),
            const SizedBox(height: 13),
            buildMatchList(),
          ],
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
            Color(0xFF4F54E8),
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
                  Icons.hub_rounded,
                  color: Colors.white,
                  size: 27,
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
                      'Smart AI',
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
          const SizedBox(height: 20),
          const Text(
            'Smart Requirement\nMatching',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Connect community requirements with the most suitable resources using intelligent compatibility scoring.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              buildHeroMetric('126', 'Active Matches'),
              buildHeroDivider(),
              buildHeroMetric('94%', 'Avg. Score'),
              buildHeroDivider(),
              buildHeroMetric('38', 'High Priority'),
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
      color: Colors.white.withValues(alpha: 0.22),
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
        hintText: 'Search resources or providers...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: showAdvancedFilters,
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

  Widget buildCategoryFilter() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
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
                category,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF626A7B),
                  fontSize: 10,
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

  Widget buildOverviewStats() {
    final stats = [
      ['126', 'Potential Matches', Icons.hub_rounded],
      ['94%', 'Avg. Compatibility', Icons.analytics_rounded],
      ['42', 'Nearby Options', Icons.location_on_rounded],
      ['18', 'New Today', Icons.bolt_rounded],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
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
              Icon(
                stat[2] as IconData,
                color: const Color(0xFF5B5FEF),
                size: 20,
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

  Widget buildMatchHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended Matches',
                style: TextStyle(
                  color: Color(0xFF1D2638),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Ranked by intelligent compatibility',
                style: TextStyle(
                  color: Color(0xFF7B8392),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          initialValue: selectedSort,
          onSelected: (value) {
            setState(() {
              selectedSort = value;
            });
          },
          itemBuilder: (context) {
            return [
              'Best Match',
              'Nearest',
              'Highest Availability',
              'Most Urgent',
            ].map((item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFE3E6EF),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.sort_rounded,
                  size: 15,
                  color: Color(0xFF626A7B),
                ),
                const SizedBox(width: 4),
                Text(
                  selectedSort,
                  style: const TextStyle(
                    color: Color(0xFF626A7B),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMatchList() {
    final items = filteredMatches;

    if (items.isEmpty) {
      return buildEmptyState();
    }

    return Column(
      children: items.map(buildMatchCard).toList(),
    );
  }

  Widget buildMatchCard(Map<String, dynamic> match) {
    final score = match['score'] as int;
    final highScore = score >= 90;

    return GestureDetector(
      onTap: () => showMatchDetails(match),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: const Color(0xFFE5E8EF),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F1FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    match['icon'] as IconData,
                    color: const Color(0xFF5B5FEF),
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match['resource'] as String,
                        style: const TextStyle(
                          color: Color(0xFF202A3C),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        match['provider'] as String,
                        style: const TextStyle(
                          color: Color(0xFF6E7687),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: Color(0xFF8B92A0),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${match['location']} • ${match['distance']}',
                            style: const TextStyle(
                              color: Color(0xFF8B92A0),
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
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: highScore
                            ? const Color(0xFFEAF9F3)
                            : const Color(0xFFFFF4E8),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$score%',
                        style: TextStyle(
                          color: highScore
                              ? const Color(0xFF21966A)
                              : const Color(0xFFD58931),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'MATCH',
                      style: TextStyle(
                        color: Color(0xFF8B92A0),
                        fontSize: 7,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            buildCompatibilityBar(score),
            const SizedBox(height: 15),
            Row(
              children: [
                buildInfoPill(
                  Icons.inventory_2_outlined,
                  match['quantity'] as String,
                ),
                const SizedBox(width: 7),
                buildInfoPill(
                  Icons.check_circle_outline_rounded,
                  match['condition'] as String,
                ),
                const SizedBox(width: 7),
                if (match['verified'] as bool)
                  buildInfoPill(
                    Icons.verified_rounded,
                    'Verified',
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF5B5FEF),
                    size: 15,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      match['reason'] as String,
                      style: const TextStyle(
                        color: Color(0xFF626A7B),
                        fontSize: 9,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => showWhyMatched(match),
                    child: const Text(
                      'Why this match?',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => connectWithProvider(match),
                    icon: const Icon(
                      Icons.link_rounded,
                      size: 15,
                    ),
                    label: const Text(
                      'Connect',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCompatibilityBar(int score) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Compatibility',
              style: TextStyle(
                color: Color(0xFF727A8A),
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '$score / 100',
              style: const TextStyle(
                color: Color(0xFF4F56DD),
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            minHeight: 6,
            value: score / 100,
            backgroundColor: const Color(0xFFECEFF3),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF5B5FEF),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoPill(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 12,
              color: const Color(0xFF737B8B),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF737B8B),
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.hub_outlined,
            size: 45,
            color: Color(0xFF9AA1B0),
          ),
          SizedBox(height: 12),
          Text(
            'No matching resources found',
            style: TextStyle(
              color: Color(0xFF30384A),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try changing your category or search criteria.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7A8292),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void showMatchDetails(Map<String, dynamic> match) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      isScrollControlled: true,
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
                      match['icon'] as IconData,
                      color: const Color(0xFF5B5FEF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      match['resource'] as String,
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
              detailRow(
                'Provider',
                match['provider'] as String,
              ),
              detailRow(
                'Category',
                match['category'] as String,
              ),
              detailRow(
                'Location',
                match['location'] as String,
              ),
              detailRow(
                'Distance',
                match['distance'] as String,
              ),
              detailRow(
                'Quantity',
                match['quantity'] as String,
              ),
              detailRow(
                'Condition',
                match['condition'] as String,
              ),
              detailRow(
                'Availability',
                match['availability'] as String,
              ),
              detailRow(
                'Compatibility',
                '${match['score']}%',
              ),
              const SizedBox(height: 16),
              buildBottomActions(
                sheetContext,
                match,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildBottomActions(
    BuildContext sheetContext,
    Map<String, dynamic> match,
  ) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(sheetContext);
              showWhyMatched(match);
            },
            child: const Text('Analyze Match'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FilledButton(
            onPressed: () {
              Navigator.pop(sheetContext);
              connectWithProvider(match);
            },
            child: const Text('Connect'),
          ),
        ),
      ],
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
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF30384A),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showWhyMatched(Map<String, dynamic> match) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        final score = match['score'] as int;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Why This Match?',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${match['resource']} has a $score% compatibility score.',
                style: const TextStyle(
                  color: Color(0xFF7A8292),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 20),
              buildReasonRow(
                Icons.category_rounded,
                'Category Match',
                'Excellent',
              ),
              buildReasonRow(
                Icons.inventory_2_rounded,
                'Quantity Match',
                'Strong',
              ),
              buildReasonRow(
                Icons.location_on_rounded,
                'Location Match',
                match['distance'] as String,
              ),
              buildReasonRow(
                Icons.verified_rounded,
                'Provider Trust',
                match['verified'] as bool
                    ? 'Verified'
                    : 'Unverified',
              ),
              buildReasonRow(
                Icons.access_time_rounded,
                'Availability',
                match['availability'] as String,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Got It'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildReasonRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF5B5FEF),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF626A7B),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF21966A),
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  void connectWithProvider(Map<String, dynamic> match) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Connect with Provider',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: Text(
            'Send a connection request to ${match['provider']} for ${match['resource']}?',
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
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
                showSnackBar(
                  'Connection request sent successfully',
                );
              },
              child: const Text('Send Request'),
            ),
          ],
        );
      },
    );
  }

  void showAdvancedFilters() {
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
                'Advanced Matching Filters',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 18),
              filterOption(
                Icons.location_on_rounded,
                'Within 5 km',
              ),
              filterOption(
                Icons.verified_rounded,
                'Verified providers only',
              ),
              filterOption(
                Icons.inventory_2_rounded,
                'Available resources only',
              ),
              filterOption(
                Icons.star_rounded,
                '90%+ compatibility',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget filterOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF5B5FEF),
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF4D5668),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Switch(
            value: false,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  void showMatchingInfo() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Smart Matching',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Text(
            'ResourceX compares category, quantity, availability, distance, urgency and provider trust to calculate a compatibility score for every potential match.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Understood'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshMatches() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 600),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
    showSnackBar('Smart matches updated');
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