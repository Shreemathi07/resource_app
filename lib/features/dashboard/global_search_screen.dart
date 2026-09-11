import 'package:flutter/material.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedFilter = 0;
  bool _showFilters = false;

  final List<String> _filters = [
    'All',
    'Resources',
    'Requirements',
    'Matches',
    'Organizations',
    'Nearby',
  ];

  final List<_SearchResult> _results = [
    _SearchResult(
      title: 'Dell Latitude 5420 Laptop',
      subtitle: 'Available for educational use',
      category: 'Resources',
      location: 'Vellore • 2.4 km',
      tag: 'Available',
      icon: Icons.laptop_mac_outlined,
      score: '96%',
    ),
    _SearchResult(
      title: 'Need 15 Engineering Textbooks',
      subtitle: 'Required for community learning center',
      category: 'Requirements',
      location: 'Katpadi • 4.1 km',
      tag: 'Urgent',
      icon: Icons.menu_book_outlined,
      score: '91%',
    ),
    _SearchResult(
      title: 'VIT Community Hub',
      subtitle: 'Verified organization • 142 exchanges',
      category: 'Organizations',
      location: 'Vellore • 3.2 km',
      tag: 'Verified',
      icon: Icons.account_balance_outlined,
      score: '89%',
    ),
    _SearchResult(
      title: 'Projector and Presentation Kit',
      subtitle: 'Suitable for workshops and events',
      category: 'Resources',
      location: 'Vellore • 5.6 km',
      tag: 'Available',
      icon: Icons.videocam_outlined,
      score: '87%',
    ),
    _SearchResult(
      title: 'Community Medical Supplies',
      subtitle: 'Requirement for local health initiative',
      category: 'Requirements',
      location: 'Sathuvachari • 6.8 km',
      tag: 'Urgent',
      icon: Icons.medical_services_outlined,
      score: '84%',
    ),
    _SearchResult(
      title: 'Green Campus Initiative',
      subtitle: 'Sustainability-focused organization',
      category: 'Organizations',
      location: 'Vellore • 7.2 km',
      tag: 'Verified',
      icon: Icons.eco_outlined,
      score: '82%',
    ),
  ];

  final List<_RecentSearch> _recentSearches = [
    _RecentSearch(
      text: 'laptops',
      icon: Icons.history_rounded,
    ),
    _RecentSearch(
      text: 'engineering books',
      icon: Icons.history_rounded,
    ),
    _RecentSearch(
      text: 'nearby resources',
      icon: Icons.history_rounded,
    ),
    _RecentSearch(
      text: 'community organizations',
      icon: Icons.history_rounded,
    ),
  ];

  final List<_Suggestion> _suggestions = [
    _Suggestion(
      title: 'Laptop',
      subtitle: '12 available nearby',
      icon: Icons.laptop_mac_outlined,
    ),
    _Suggestion(
      title: 'Books',
      subtitle: '8 active requirements',
      icon: Icons.menu_book_outlined,
    ),
    _Suggestion(
      title: 'Medical',
      subtitle: '5 urgent requirements',
      icon: Icons.medical_services_outlined,
    ),
    _Suggestion(
      title: 'Furniture',
      subtitle: '19 resources available',
      icon: Icons.chair_outlined,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_SearchResult> get _filteredResults {
    final query = _searchController.text.trim().toLowerCase();

    return _results.where((result) {
      final matchesFilter = _selectedFilter == 0 ||
          result.category == _filters[_selectedFilter] ||
          (_filters[_selectedFilter] == 'Nearby' &&
              result.location.contains('km'));

      if (query.isEmpty) {
        return matchesFilter;
      }

      final searchableText =
          '${result.title} ${result.subtitle} ${result.category} '
                  '${result.location} ${result.tag}'
              .toLowerCase();

      return matchesFilter && searchableText.contains(query);
    }).toList();
  }

  void _performSearch() {
    if (_searchController.text.trim().isEmpty) {
      _showMessage('Enter something to search');
      return;
    }

    setState(() {});
    FocusScope.of(context).unfocus();
  }

  void _selectSuggestion(String value) {
    _searchController.text = value;
    setState(() {});
    FocusScope.of(context).unfocus();
  }

  void _selectRecentSearch(String value) {
    _searchController.text = value;
    setState(() {});
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
  }

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

  void _showResultDetails(_SearchResult result) {
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
                        result.icon,
                        color: Colors.green.shade700,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Text(
                        result.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  result.subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  result.category,
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  result.location,
                ),
                _detailRow(
                  Icons.auto_awesome_outlined,
                  'ResourceX match',
                  result.score,
                ),
                _detailRow(
                  Icons.verified_outlined,
                  'Status',
                  result.tag,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Saved to your discovery list');
                        },
                        icon: const Icon(Icons.bookmark_border_rounded),
                        label: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Connection request started');
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text('Explore'),
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
            size: 19,
            color: Colors.green.shade700,
          ),
          const SizedBox(width: 10),
          Text(
            '$title:',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAdvancedFilters() {
    bool verifiedOnly = false;
    bool urgentOnly = false;
    double radius = 10;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
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
                    const SizedBox(height: 20),
                    const Text(
                      'Advanced Search',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Verified members only',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: const Text(
                        'Show trusted ResourceX profiles',
                        style: TextStyle(fontSize: 9),
                      ),
                      value: verifiedOnly,
                      onChanged: (value) {
                        setSheetState(() {
                          verifiedOnly = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Urgent opportunities',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: const Text(
                        'Prioritize time-sensitive needs',
                        style: TextStyle(fontSize: 9),
                      ),
                      value: urgentOnly,
                      onChanged: (value) {
                        setSheetState(() {
                          urgentOnly = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Discovery radius',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${radius.round()} km',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: radius,
                      min: 1,
                      max: 25,
                      divisions: 24,
                      label: '${radius.round()} km',
                      onChanged: (value) {
                        setSheetState(() {
                          radius = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _showFilters = true;
                          });
                          _showMessage(
                            'Advanced filters applied',
                          );
                        },
                        child: const Text('Apply Filters'),
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

  @override
  Widget build(BuildContext context) {
    final results = _filteredResults;

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
              'Global Discovery',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Find resources, people and opportunities',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showAdvancedFilters,
            icon: Badge(
              isLabelVisible: _showFilters,
              child: const Icon(
                Icons.tune_rounded,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBox(),
          _buildFilterBar(),
          Expanded(
            child: results.isEmpty
                ? _buildEmptyState()
                : ListView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      100,
                    ),
                    children: [
                      if (_searchController.text.isEmpty) ...[
                        _buildDiscoveryHero(),
                        const SizedBox(height: 20),
                        _buildRecentSearches(),
                        const SizedBox(height: 20),
                        _buildSuggestedSearches(),
                        const SizedBox(height: 22),
                        _buildResultHeader(
                          results.length,
                          'Recommended for you',
                        ),
                      ] else ...[
                        _buildResultHeader(
                          results.length,
                          'Search results',
                        ),
                      ],
                      const SizedBox(height: 10),
                      ...results.map(
                        (result) => Padding(
                          padding: const EdgeInsets.only(bottom: 11),
                          child: _buildResultCard(result),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) {
            _performSearch();
          },
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search anything in ResourceX...',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.green.shade700,
            ),
            suffixIcon: _searchController.text.isEmpty
                ? IconButton(
                    onPressed: _performSearch,
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                    ),
                  )
                : IconButton(
                    onPressed: _clearSearch,
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 43,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedFilter == index;

          return ChoiceChip(
            label: Text(
              _filters[index],
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
                _selectedFilter = index;
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

  Widget _buildDiscoveryHero() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade800,
            Colors.teal.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.travel_explore_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover more',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'ResourceX searches across the entire exchange network to find relevant opportunities for you.',
                  style: TextStyle(
                    color: Colors.white70,
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

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Recent searches',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _showMessage('Search history cleared');
              },
              child: const Text(
                'Clear',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _recentSearches.map(
            (item) {
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  _selectRecentSearch(item.text);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.text,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildSuggestedSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular discoveries',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 11),
        SizedBox(
          height: 108,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _suggestions.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final suggestion = _suggestions[index];

              return InkWell(
                borderRadius: BorderRadius.circular(17),
                onTap: () {
                  _selectSuggestion(suggestion.title);
                },
                child: Container(
                  width: 142,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        suggestion.icon,
                        color: Colors.green.shade700,
                        size: 23,
                      ),
                      const Spacer(),
                      Text(
                        suggestion.title,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        suggestion.subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 8.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultHeader(
    int count,
    String title,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          '$count found',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(_SearchResult result) {
    return InkWell(
      borderRadius: BorderRadius.circular(19),
      onTap: () {
        _showResultDetails(result);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                result.icon,
                color: Colors.green.shade700,
                size: 23,
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
                          result.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          result.score,
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9.5,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          result.location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 8.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: result.tag == 'Urgent'
                              ? Colors.orange.withValues(alpha: 0.09)
                              : Colors.blue.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          result.tag,
                          style: TextStyle(
                            color: result.tag == 'Urgent'
                                ? Colors.orange.shade800
                                : Colors.blue.shade700,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 38,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Try another keyword or change your discovery filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: () {
                _clearSearch();
                setState(() {
                  _selectedFilter = 0;
                  _showFilters = false;
                });
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reset Search'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResult {
  final String title;
  final String subtitle;
  final String category;
  final String location;
  final String tag;
  final IconData icon;
  final String score;

  const _SearchResult({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.location,
    required this.tag,
    required this.icon,
    required this.score,
  });
}

class _RecentSearch {
  final String text;
  final IconData icon;

  const _RecentSearch({
    required this.text,
    required this.icon,
  });
}

class _Suggestion {
  final String title;
  final String subtitle;
  final IconData icon;

  const _Suggestion({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}