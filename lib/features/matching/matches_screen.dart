import 'package:flutter/material.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({
    super.key,
    this.role = 'Resource Seeker',
  });

  final String role;

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  String _selectedFilter = 'All';
  String _sortBy = 'Best Match';

  final List<Map<String, dynamic>> _matches = [
    {
      'title': 'Refurbished Laptops',
      'provider': 'TechShare Community',
      'category': 'Technology',
      'location': 'Vellore',
      'distance': '2.4 km',
      'quantity': '12 units',
      'score': 96,
      'reason': 'Matches your technology requirement',
      'status': 'Available now',
      'icon': Icons.laptop_mac_rounded,
      'priority': 'High relevance',
    },
    {
      'title': 'Office Study Tables',
      'provider': 'Campus Resource Hub',
      'category': 'Furniture',
      'location': 'Katpadi',
      'distance': '4.1 km',
      'quantity': '18 units',
      'score': 91,
      'reason': 'Exact category and nearby location',
      'status': 'Available this week',
      'icon': Icons.table_restaurant_rounded,
      'priority': 'Good match',
    },
    {
      'title': 'Solar Lighting Kits',
      'provider': 'Green Future Foundation',
      'category': 'Energy',
      'location': 'Vellore',
      'distance': '6.8 km',
      'quantity': '25 kits',
      'score': 87,
      'reason': 'Matches your sustainability interest',
      'status': 'Limited availability',
      'icon': Icons.lightbulb_outline_rounded,
      'priority': 'Good match',
    },
    {
      'title': 'Unused School Supplies',
      'provider': 'Learning Circle',
      'category': 'Education',
      'location': 'Ranipet',
      'distance': '12.2 km',
      'quantity': '150 items',
      'score': 82,
      'reason': 'Strong requirement compatibility',
      'status': 'Available',
      'icon': Icons.school_outlined,
      'priority': 'Potential match',
    },
  ];

  final List<String> _filters = [
    'All',
    '95%+',
    'Nearby',
    'Urgent',
    'Saved',
  ];

  List<Map<String, dynamic>> get _filteredMatches {
    List<Map<String, dynamic>> result = List.from(_matches);

    if (_selectedFilter == '95%+') {
      result = result.where((item) => item['score'] >= 95).toList();
    } else if (_selectedFilter == 'Nearby') {
      result = result.where((item) {
        final distance = double.tryParse(
          item['distance'].toString().replaceAll(' km', ''),
        );
        return distance != null && distance <= 5;
      }).toList();
    } else if (_selectedFilter == 'Urgent') {
      result = result
          .where((item) => item['priority'] == 'High relevance')
          .toList();
    }

    if (_sortBy == 'Highest Score') {
      result.sort(
        (a, b) => (b['score'] as int).compareTo(a['score'] as int),
      );
    } else if (_sortBy == 'Nearest') {
      result.sort((a, b) {
        final aDistance = double.tryParse(
              a['distance'].toString().replaceAll(' km', ''),
            ) ??
            999;

        final bDistance = double.tryParse(
              b['distance'].toString().replaceAll(' km', ''),
            ) ??
            999;

        return aDistance.compareTo(bDistance);
      });
    }

    return result;
  }

  void _showMatchDetails(Map<String, dynamic> match) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        match['icon'] as IconData,
                        color: scheme.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match['title'] as String,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            match['provider'] as String,
                            style: TextStyle(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _detailScore(match, scheme),
                const SizedBox(height: 22),
                const Text(
                  'Why ResourceX matched this',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                _reasonItem(
                  Icons.category_outlined,
                  'Category compatibility',
                  '${match['category']} matches your interests',
                ),
                _reasonItem(
                  Icons.location_on_outlined,
                  'Location compatibility',
                  '${match['distance']} from your preferred area',
                ),
                _reasonItem(
                  Icons.inventory_2_outlined,
                  'Quantity compatibility',
                  '${match['quantity']} currently available',
                ),
                _reasonItem(
                  Icons.schedule_rounded,
                  'Availability',
                  match['status'] as String,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Match saved');
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
                          _showMessage(
                            'Connection request sent to ${match['provider']}',
                          );
                        },
                        icon: const Icon(Icons.handshake_outlined),
                        label: const Text('Connect'),
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

  Widget _detailScore(
    Map<String, dynamic> match,
    ColorScheme scheme,
  ) {
    final score = match['score'] as int;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 8,
                  backgroundColor: scheme.surface,
                ),
                Text(
                  '$score%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Excellent compatibility',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  match['reason'] as String,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _reasonItem(
    IconData icon,
    String title,
    String subtitle,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              size: 21,
              color: scheme.primary,
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
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle_rounded,
            color: scheme.primary,
            size: 20,
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final options = [
          'Best Match',
          'Highest Score',
          'Nearest',
        ];

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort Matches',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              ...options.map(
                (option) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    option == _sortBy
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                  ),
                  title: Text(option),
                  onTap: () {
                    setState(() {
                      _sortBy = option;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Smart Matches',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Sort',
            onPressed: _showSortOptions,
            icon: const Icon(Icons.swap_vert_rounded),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildMatchOverview(scheme),
          ),
          SliverToBoxAdapter(
            child: _buildFilterBar(scheme),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Recommended for you',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    '${_filteredMatches.length} matches',
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_filteredMatches.isEmpty)
            SliverToBoxAdapter(
              child: _buildEmptyState(scheme),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildMatchCard(
                      _filteredMatches[index],
                      scheme,
                    );
                  },
                  childCount: _filteredMatches.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMatchOverview(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: scheme.primary,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ResourceX Intelligence',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Finding useful connections for you',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            '24',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'potential matches discovered',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _overviewStat(
                '8',
                'High match',
                Icons.bolt_rounded,
              ),
              const SizedBox(width: 10),
              _overviewStat(
                '11',
                'Nearby',
                Icons.near_me_rounded,
              ),
              const SizedBox(width: 10),
              _overviewStat(
                '5',
                'New today',
                Icons.fiber_new_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewStat(
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface
              .withAlpha(150),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 19,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(ColorScheme scheme) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final selected = filter == _selectedFilter;

          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildMatchCard(
    Map<String, dynamic> match,
    ColorScheme scheme,
  ) {
    final score = match['score'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outlineVariant,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _showMatchDetails(match),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Icon(
                      match['icon'] as IconData,
                      color: scheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                match['title'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$score%',
                                style: TextStyle(
                                  color: scheme.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          match['provider'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _infoChip(
                    Icons.category_outlined,
                    match['category'] as String,
                    scheme,
                  ),
                  const SizedBox(width: 7),
                  _infoChip(
                    Icons.location_on_outlined,
                    match['distance'] as String,
                    scheme,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 17,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        match['reason'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${match['quantity']} • ${match['status']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'View match',
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: scheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(
    IconData icon,
    String text,
    ColorScheme scheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: scheme.primary,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 55,
            color: scheme.primary,
          ),
          const SizedBox(height: 14),
          const Text(
            'No matches found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try changing your filter to discover more opportunities.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}