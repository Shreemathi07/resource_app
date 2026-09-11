import 'package:flutter/material.dart';

class RecommendationCenterScreen extends StatefulWidget {
  const RecommendationCenterScreen({super.key});

  @override
  State<RecommendationCenterScreen> createState() =>
      _RecommendationCenterScreenState();
}

class _RecommendationCenterScreenState
    extends State<RecommendationCenterScreen> {
  int _selectedCategory = 0;
  String _selectedSort = 'Recommended';

  final List<String> _categories = [
    'For You',
    'Nearby',
    'Urgent',
    'Resources',
    'Organizations',
  ];

  final List<_Recommendation> _recommendations = [
    _Recommendation(
      title: 'Engineering Lab Equipment',
      subtitle: 'VIT Community Hub',
      type: 'Resource',
      category: 'Education',
      location: '1.2 km away',
      availability: 'Available now',
      score: 96,
      quantity: '12 items',
      icon: Icons.precision_manufacturing_outlined,
      reason: 'Matches your Education interest and nearby preference.',
      tags: ['Education', 'Equipment', 'Nearby'],
    ),
    _Recommendation(
      title: 'Community Laptop Requirement',
      subtitle: 'Digital Learning Foundation',
      type: 'Requirement',
      category: 'Technology',
      location: '2.4 km away',
      availability: 'Needed this week',
      score: 93,
      quantity: '8 laptops',
      icon: Icons.laptop_mac_outlined,
      reason: 'Your saved Technology resources can help this requirement.',
      tags: ['Technology', 'Urgent', 'High Impact'],
    ),
    _Recommendation(
      title: 'Reusable Event Materials',
      subtitle: 'Green Campus Initiative',
      type: 'Resource',
      category: 'Sustainability',
      location: '3.1 km away',
      availability: 'Available tomorrow',
      score: 89,
      quantity: '35 items',
      icon: Icons.recycling_outlined,
      reason: 'Strong match with your Sustainability activity.',
      tags: ['Green', 'Reusable', 'Campus'],
    ),
    _Recommendation(
      title: 'STEM Learning Partnership',
      subtitle: 'Bright Future NGO',
      type: 'Organization',
      category: 'Education',
      location: '4.7 km away',
      availability: 'Open for partnership',
      score: 86,
      quantity: 'Partnership',
      icon: Icons.handshake_outlined,
      reason: 'Similar impact goals and active education programs.',
      tags: ['Partnership', 'STEM', 'Impact'],
    ),
    _Recommendation(
      title: 'Medical Camp Supplies',
      subtitle: 'CareBridge Community',
      type: 'Requirement',
      category: 'Healthcare',
      location: '5.3 km away',
      availability: 'Urgent',
      score: 84,
      quantity: '24 kits',
      icon: Icons.medical_services_outlined,
      reason: 'High community impact with an urgent availability window.',
      tags: ['Urgent', 'Healthcare', 'Community'],
    ),
  ];

  final Set<int> _saved = {};

  List<_Recommendation> get _filteredRecommendations {
    List<_Recommendation> result = List.from(_recommendations);

    if (_selectedCategory == 1) {
      result = result.where((item) => item.location.contains('km')).toList();
    } else if (_selectedCategory == 2) {
      result = result
          .where(
            (item) =>
                item.availability.toLowerCase().contains('urgent') ||
                item.tags.any((tag) => tag.toLowerCase() == 'urgent'),
          )
          .toList();
    } else if (_selectedCategory == 3) {
      result = result.where((item) => item.type == 'Resource').toList();
    } else if (_selectedCategory == 4) {
      result = result.where((item) => item.type == 'Organization').toList();
    }

    if (_selectedSort == 'Highest Score') {
      result.sort((a, b) => b.score.compareTo(a.score));
    } else if (_selectedSort == 'Nearest') {
      result.sort(
        (a, b) => _distance(a.location).compareTo(_distance(b.location)),
      );
    } else if (_selectedSort == 'Urgent First') {
      result.sort((a, b) {
        final aUrgent =
            a.availability.toLowerCase().contains('urgent') ||
            a.tags.contains('Urgent');
        final bUrgent =
            b.availability.toLowerCase().contains('urgent') ||
            b.tags.contains('Urgent');

        if (aUrgent == bUrgent) {
          return b.score.compareTo(a.score);
        }

        return aUrgent ? -1 : 1;
      });
    } else {
      result.sort((a, b) => b.score.compareTo(a.score));
    }

    return result;
  }

  double _distance(String location) {
    final match = RegExp(r'([0-9.]+)').firstMatch(location);

    if (match == null) {
      return 999;
    }

    return double.tryParse(match.group(1)!) ?? 999;
  }

  void _showRecommendationDetails(_Recommendation item, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
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
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          item.icon,
                          color: Colors.indigo,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.type,
                              style: TextStyle(
                                color: Colors.indigo.shade700,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _detailScore(item.score),
                  const SizedBox(height: 20),
                  _detailRow(
                    Icons.business_outlined,
                    'Recommended from',
                    item.subtitle,
                  ),
                  _detailRow(
                    Icons.location_on_outlined,
                    'Location',
                    item.location,
                  ),
                  _detailRow(
                    Icons.inventory_2_outlined,
                    'Quantity',
                    item.quantity,
                  ),
                  _detailRow(
                    Icons.schedule_outlined,
                    'Availability',
                    item.availability,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Why ResourceX recommended this',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.reason,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: item.tags
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                            backgroundColor:
                                Colors.indigo.withValues(alpha: 0.08),
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);

                            setState(() {
                              if (_saved.contains(index)) {
                                _saved.remove(index);
                              } else {
                                _saved.add(index);
                              }
                            });

                            _showMessage(
                              _saved.contains(index)
                                  ? 'Recommendation saved'
                                  : 'Recommendation removed',
                            );
                          },
                          icon: Icon(
                            _saved.contains(index)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                          label: Text(
                            _saved.contains(index) ? 'Saved' : 'Save',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showMessage(
                              'Opening ${item.title}',
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Explore'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailScore(int score) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.shade50,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 62,
            height: 62,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.indigo.withValues(alpha: 0.10),
                  color: Colors.indigo,
                ),
                Text(
                  '$score%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommendation confidence',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Based on your activity, interests, location and availability.',
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: Colors.indigo,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  void _showSortSheet() {
    final options = [
      'Recommended',
      'Highest Score',
      'Nearest',
      'Urgent First',
    ];

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sort recommendations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              ...options.map(
                (option) => ListTile(
                  leading: Icon(
                    option == _selectedSort
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: option == _selectedSort
                        ? Colors.indigo
                        : Colors.grey,
                  ),
                  title: Text(option),
                  onTap: () {
                    setState(() {
                      _selectedSort = option;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _refreshRecommendations() {
    setState(() {
      _recommendations.shuffle();
    });

    _showMessage('Recommendations refreshed');
  }

  @override
  Widget build(BuildContext context) {
    final recommendations = _filteredRecommendations;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smart Recommendations',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 21,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Discover your next best opportunity',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _refreshRecommendations,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 500),
          );
          _refreshRecommendations();
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
          children: [
            _buildIntelligenceCard(),
            const SizedBox(height: 18),
            _buildPreferenceCard(),
            const SizedBox(height: 20),
            _buildCategorySelector(),
            const SizedBox(height: 18),
            _buildSectionHeader(recommendations.length),
            const SizedBox(height: 12),
            if (recommendations.isEmpty)
              _buildEmptyState()
            else
              ...recommendations.asMap().entries.map(
                    (entry) => _buildRecommendationCard(
                      entry.value,
                      entry.key,
                    ),
                  ),
            const SizedBox(height: 18),
            _buildLearningCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntelligenceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade800,
            Colors.blue.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'ResourceX Intelligence',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Your recommendations are personalized using your interests, previous activity, location, resource availability and community impact.',
            style: TextStyle(
              color: Colors.white,
              height: 1.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _intelligenceMetric(
                  '94%',
                  'Accuracy',
                ),
              ),
              Expanded(
                child: _intelligenceMetric(
                  '27',
                  'Suggestions',
                ),
              ),
              Expanded(
                child: _intelligenceMetric(
                  '8',
                  'High Impact',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _intelligenceMetric(
    String value,
    String label,
  ) {
    return Column(
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
            color: Colors.white.withValues(alpha: 0.72),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your preferences',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Education • Technology • Within 10 km',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showMessage('Preference settings opened');
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == _selectedCategory;

          return ChoiceChip(
            label: Text(_categories[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedCategory = index;
              });
            },
            selectedColor: Colors.indigo.shade100,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selected
                  ? Colors.indigo.shade200
                  : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: selected
                  ? Colors.indigo.shade800
                  : Colors.grey.shade700,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              fontSize: 11,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(int count) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Recommended for you',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          '$count results',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: _showSortSheet,
          icon: const Icon(Icons.sort_rounded),
          tooltip: 'Sort',
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
    _Recommendation item,
    int index,
  ) {
    final isSaved = _saved.contains(index);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          _showRecommendationDetails(item, index);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      item.icon,
                      color: Colors.indigo.shade700,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.indigo.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                item.type,
                                style: TextStyle(
                                  color: Colors.indigo.shade700,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${item.score}% match',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSaved) {
                          _saved.remove(index);
                        } else {
                          _saved.add(index);
                        }
                      });

                      _showMessage(
                        isSaved
                            ? 'Removed from saved'
                            : 'Saved recommendation',
                      );
                    },
                    icon: Icon(
                      isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isSaved
                          ? Colors.indigo
                          : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 17,
                      color: Colors.orange.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.reason,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 10.5,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 15,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.location,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 15,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.quantity,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    item.availability,
                    style: TextStyle(
                      color: item.availability == 'Urgent'
                          ? Colors.red
                          : Colors.green.shade700,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  ...item.tags.take(2).map(
                        (tag) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 54,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 14),
          const Text(
            'No recommendations found',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Try another category or refresh your recommendations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.insights_outlined,
              color: Colors.purple,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Improve your recommendations',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Save resources and complete exchanges to help ResourceX understand what matters to you.',
                  style: TextStyle(
                    fontSize: 10.5,
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
}

class _Recommendation {
  final String title;
  final String subtitle;
  final String type;
  final String category;
  final String location;
  final String availability;
  final int score;
  final String quantity;
  final IconData icon;
  final String reason;
  final List<String> tags;

  const _Recommendation({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.category,
    required this.location,
    required this.availability,
    required this.score,
    required this.quantity,
    required this.icon,
    required this.reason,
    required this.tags,
  });
}