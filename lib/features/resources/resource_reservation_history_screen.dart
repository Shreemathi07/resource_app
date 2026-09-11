import 'package:flutter/material.dart';

class ResourceReservationHistoryScreen extends StatefulWidget {
  const ResourceReservationHistoryScreen({super.key});

  @override
  State<ResourceReservationHistoryScreen> createState() =>
      _ResourceReservationHistoryScreenState();
}

class _ResourceReservationHistoryScreenState
    extends State<ResourceReservationHistoryScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';
  String selectedPeriod = 'All Time';

  final List<String> tabs = [
    'History',
    'Resources',
    'People',
    'Insights',
  ];

  final List<String> filters = [
    'All',
    'Completed',
    'Cancelled',
    'Rejected',
    'Expired',
  ];

  final List<String> periods = [
    'All Time',
    'This Month',
    'Last 3 Months',
    'This Year',
  ];

  final List<Map<String, dynamic>> history = [
    {
      'resource': 'Dell Latitude 5420',
      'category': 'Technology',
      'provider': 'VIT Resource Center',
      'seeker': 'Digital Learning Hub',
      'date': 'Sep 5, 2026',
      'time': '10:30 AM - 12:30 PM',
      'location': 'VIT Campus',
      'quantity': 3,
      'status': 'Completed',
      'rating': 5,
      'duration': '2 hours',
      'icon': Icons.laptop_mac_outlined,
      'color': Colors.indigo,
    },
    {
      'resource': 'Educational Books',
      'category': 'Education',
      'provider': 'Community Learning Hub',
      'seeker': 'Student Support Center',
      'date': 'Sep 2, 2026',
      'time': '11:00 AM - 1:00 PM',
      'location': 'Sathuvachari',
      'quantity': 24,
      'status': 'Completed',
      'rating': 5,
      'duration': '2 hours',
      'icon': Icons.menu_book_outlined,
      'color': Colors.green,
    },
    {
      'resource': 'Projector with Stand',
      'category': 'Electronics',
      'provider': 'Community Resource Hub',
      'seeker': 'Innovation Cell',
      'date': 'Aug 29, 2026',
      'time': '2:00 PM - 4:00 PM',
      'location': 'Katpadi',
      'quantity': 1,
      'status': 'Cancelled',
      'rating': 0,
      'duration': '2 hours',
      'icon': Icons.videocam_outlined,
      'color': Colors.orange,
    },
    {
      'resource': 'Study Table Set',
      'category': 'Furniture',
      'provider': 'Student Support Center',
      'seeker': 'Community Library',
      'date': 'Aug 24, 2026',
      'time': '9:00 AM - 12:00 PM',
      'location': 'Vellore',
      'quantity': 6,
      'status': 'Completed',
      'rating': 4,
      'duration': '3 hours',
      'icon': Icons.table_restaurant_outlined,
      'color': Colors.teal,
    },
    {
      'resource': 'Sports Equipment',
      'category': 'Sports',
      'provider': 'Youth Activity Center',
      'seeker': 'VIT Sports Club',
      'date': 'Aug 18, 2026',
      'time': '4:30 PM - 6:30 PM',
      'location': 'Gandhi Nagar',
      'quantity': 2,
      'status': 'Rejected',
      'rating': 0,
      'duration': '2 hours',
      'icon': Icons.sports_basketball_outlined,
      'color': Colors.red,
    },
    {
      'resource': 'HP ProBook 440',
      'category': 'Technology',
      'provider': 'Digital Skills Lab',
      'seeker': 'Community Workshop',
      'date': 'Aug 12, 2026',
      'time': '1:00 PM - 3:00 PM',
      'location': 'VIT Campus',
      'quantity': 2,
      'status': 'Expired',
      'rating': 0,
      'duration': '2 hours',
      'icon': Icons.computer_outlined,
      'color': Colors.deepPurple,
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    return history.where((item) {
      final matchesFilter =
          selectedFilter == 'All' || item['status'] == selectedFilter;

      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          item['resource'].toString().toLowerCase().contains(query) ||
          item['provider'].toString().toLowerCase().contains(query) ||
          item['seeker'].toString().toLowerCase().contains(query) ||
          item['category'].toString().toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  int get completedCount =>
      history.where((item) => item['status'] == 'Completed').length;

  int get cancelledCount =>
      history.where((item) => item['status'] == 'Cancelled').length;

  int get rejectedCount =>
      history.where((item) => item['status'] == 'Rejected').length;

  double get completionRate {
    if (history.isEmpty) {
      return 0;
    }

    return completedCount / history.length * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Reservation History',
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
                _buildStats(),
                const SizedBox(height: 18),
                _buildSearch(),
                const SizedBox(height: 12),
                _buildPeriodSelector(),
                const SizedBox(height: 12),
                _buildFilters(),
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
            Colors.teal.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.17),
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
                  Icons.history_rounded,
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
                  'Smart Records',
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
            'Reservation History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep a complete record of resource reservations, outcomes, participants and reusable insights.',
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
                '$completedCount',
                'Completed',
              ),
              _heroMetric(
                '${completionRate.toStringAsFixed(0)}%',
                'Success rate',
              ),
              _heroMetric(
                '${history.length}',
                'Total records',
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
              fontSize: 21,
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

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          _statItem(
            '$completedCount',
            'Completed',
            Colors.green,
            Icons.check_circle_outline,
          ),
          _statItem(
            '$cancelledCount',
            'Cancelled',
            Colors.orange,
            Icons.cancel_outlined,
          ),
          _statItem(
            '$rejectedCount',
            'Rejected',
            Colors.red,
            Icons.block_outlined,
          ),
        ],
      ),
    );
  }

  Widget _statItem(
    String value,
    String label,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 19,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
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

  Widget _buildSearch() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search resource, provider or seeker',
        prefixIcon: const Icon(
          Icons.search_rounded,
        ),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    searchQuery = '';
                  });
                },
                icon: const Icon(
                  Icons.clear_rounded,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return SizedBox(
      height: 39,
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
                horizontal: 13,
                vertical: 9,
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
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
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
                filter,
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
        return _buildHistoryTab();
    }
  }

  Widget _buildHistoryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Reservation Records',
          '${filteredHistory.length} matching records',
          Icons.receipt_long_outlined,
        ),
        const SizedBox(height: 14),
        if (filteredHistory.isEmpty)
          _buildEmptyState()
        else
          ...filteredHistory.map(_buildHistoryCard),
        const SizedBox(height: 18),
        _buildExportCard(),
      ],
    );
  }

  Widget _buildHistoryCard(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;
    final status = item['status'].toString();
    final statusColor = _statusColor(status);

    return GestureDetector(
      onTap: () => _showReservationDetails(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
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
                        item['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['category'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(
                  status,
                  statusColor,
                ),
              ],
            ),
            const SizedBox(height: 13),
            _infoRow(
              Icons.calendar_today_outlined,
              item['date'].toString(),
            ),
            _infoRow(
              Icons.access_time_outlined,
              item['time'].toString(),
            ),
            _infoRow(
              Icons.location_on_outlined,
              item['location'].toString(),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Expanded(
                  child: _personBox(
                    'Provider',
                    item['provider'].toString(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _personBox(
                    'Seeker',
                    item['seeker'].toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 5),
                Text(
                  '${item['quantity']} units',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 5),
                Text(
                  item['duration'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
                const Spacer(),
                if (status == 'Completed')
                  _buildRating(
                    item['rating'] as int,
                  ),
              ],
            ),
            if (status == 'Completed') ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  _showSnackBar(
                    'Rebooking ${item['resource']}',
                  );
                },
                icon: const Icon(
                  Icons.replay_rounded,
                  size: 16,
                ),
                label: const Text(
                  'Rebook Resource',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRating(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating
              ? Icons.star_rounded
              : Icons.star_border_rounded,
          size: 14,
          color: Colors.amber.shade700,
        ),
      ),
    );
  }

  Widget _personBox(
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 7),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      case 'Expired':
        return Colors.grey;
      default:
        return Colors.indigo;
    }
  }

  Widget _buildResourcesTab() {
    final resourceGroups = <String, List<Map<String, dynamic>>>{};

    for (final item in history) {
      final name = item['resource'].toString();
      resourceGroups.putIfAbsent(name, () => []).add(item);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Resource History',
          'Reservation activity by resource',
          Icons.inventory_2_outlined,
        ),
        const SizedBox(height: 14),
        ...resourceGroups.entries.map(
          (entry) => _resourceHistoryCard(
            entry.key,
            entry.value,
          ),
        ),
        const SizedBox(height: 18),
        _buildPopularResourceCard(),
      ],
    );
  }

  Widget _resourceHistoryCard(
    String resource,
    List<Map<String, dynamic>> records,
  ) {
    final completed =
        records.where((item) => item['status'] == 'Completed').length;

    final first = records.first;
    final color = first['color'] as Color;

    return Container(
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
              first['icon'] as IconData,
              color: color,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${records.length} reservations • $completed completed',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: records.isEmpty
                      ? 0
                      : completed / records.length,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${records.length}',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularResourceCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.trending_up_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Most Requested',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Technology resources are currently generating the highest number of reservation requests.',
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
    final people = [
      {
        'name': 'VIT Resource Center',
        'role': 'Provider',
        'records': 28,
        'success': '96%',
        'icon': Icons.business_outlined,
        'color': Colors.indigo,
      },
      {
        'name': 'Digital Learning Hub',
        'role': 'Seeker',
        'records': 18,
        'success': '94%',
        'icon': Icons.school_outlined,
        'color': Colors.teal,
      },
      {
        'name': 'Community Resource Hub',
        'role': 'Provider',
        'records': 15,
        'success': '91%',
        'icon': Icons.hub_outlined,
        'color': Colors.orange,
      },
      {
        'name': 'Student Support Center',
        'role': 'Seeker',
        'records': 12,
        'success': '89%',
        'icon': Icons.people_outline,
        'color': Colors.green,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Participant History',
          'Reliable providers and active seekers',
          Icons.people_outline_rounded,
        ),
        const SizedBox(height: 14),
        ...people.map(
          (person) => _personHistoryCard(person),
        ),
        const SizedBox(height: 18),
        _buildTrustSummary(),
      ],
    );
  }

  Widget _personHistoryCard(
    Map<String, dynamic> person,
  ) {
    final color = person['color'] as Color;

    return Container(
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
                  '${person['role']} • ${person['records']} records',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                person['success'].toString(),
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'success',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustSummary() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.verified_outlined,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community Reliability',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '92% of historical reservations were completed successfully without disputes.',
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

  Widget _buildInsightsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'History Intelligence',
          'Patterns discovered from past reservations',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 14),
        _insightCard(
          Icons.trending_up_rounded,
          'Completion rate is improving',
          'Completed reservations increased by 14% compared with the previous period.',
          Colors.green,
        ),
        _insightCard(
          Icons.laptop_mac_outlined,
          'Technology leads demand',
          'Laptops and computing equipment account for the largest share of completed reservations.',
          Colors.indigo,
        ),
        _insightCard(
          Icons.schedule_outlined,
          'Afternoon reservations are common',
          'Most successful reservations happen between 1 PM and 5 PM.',
          Colors.orange,
        ),
        _insightCard(
          Icons.star_outline_rounded,
          'Strong participant satisfaction',
          'Completed exchanges maintain an average historical rating above 4.5 out of 5.',
          Colors.amber.shade800,
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Reservation Performance',
          'Historical operational metrics',
          Icons.analytics_outlined,
        ),
        const SizedBox(height: 12),
        _performanceMetric(
          'Completion Rate',
          '92%',
          0.92,
          Colors.green,
        ),
        _performanceMetric(
          'On-time Pickup',
          '88%',
          0.88,
          Colors.indigo,
        ),
        _performanceMetric(
          'Participant Satisfaction',
          '96%',
          0.96,
          Colors.orange,
        ),
        _performanceMetric(
          'Conflict-free Reservations',
          '94%',
          0.94,
          Colors.teal,
        ),
        const SizedBox(height: 18),
        _buildSmartRecommendation(),
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

  Widget _performanceMetric(
    String title,
    String value,
    double progress,
    Color color,
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
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
  }

  Widget _buildSmartRecommendation() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Recommendation',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Prioritize verified providers with strong completion history when making future reservations.',
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

  Widget _buildExportCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.file_download_outlined,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Export Reservation Records',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Create a summary of your reservation history.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showExportOptions,
            icon: const Icon(
              Icons.chevron_right_rounded,
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

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 42,
      ),
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
            Icons.history_toggle_off_rounded,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          const Text(
            'No records found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Try changing your search or filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _showReservationDetails(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;

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
                      radius: 27,
                      backgroundColor: color.withValues(alpha: 0.10),
                      child: Icon(
                        item['icon'] as IconData,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _detailRow(
                  Icons.check_circle_outline,
                  'Status',
                  item['status'].toString(),
                ),
                _detailRow(
                  Icons.calendar_today_outlined,
                  'Date',
                  item['date'].toString(),
                ),
                _detailRow(
                  Icons.access_time_outlined,
                  'Time',
                  item['time'].toString(),
                ),
                _detailRow(
                  Icons.person_outline,
                  'Provider',
                  item['provider'].toString(),
                ),
                _detailRow(
                  Icons.people_outline,
                  'Seeker',
                  item['seeker'].toString(),
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Quantity',
                  '${item['quantity']} units',
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  item['location'].toString(),
                ),
                _detailRow(
                  Icons.timer_outlined,
                  'Duration',
                  item['duration'].toString(),
                ),
                if (item['status'] == 'Completed')
                  _detailRow(
                    Icons.star_outline_rounded,
                    'Rating',
                    '${item['rating']}/5',
                  ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Reservation receipt opened',
                          );
                        },
                        icon: const Icon(
                          Icons.receipt_long_outlined,
                          size: 17,
                        ),
                        label: const Text(
                          'Receipt',
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    if (item['status'] == 'Completed')
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            _showSnackBar(
                              'Rebooking started',
                            );
                          },
                          icon: const Icon(
                            Icons.replay_rounded,
                            size: 17,
                          ),
                          label: const Text(
                            'Rebook',
                          ),
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
              const Text(
                'Export Records',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              _exportOption(
                sheetContext,
                Icons.picture_as_pdf_outlined,
                'Export as PDF',
                'Generate a formatted reservation report.',
                Colors.red,
              ),
              _exportOption(
                sheetContext,
                Icons.table_chart_outlined,
                'Export as CSV',
                'Create a spreadsheet-compatible record.',
                Colors.green,
              ),
              _exportOption(
                sheetContext,
                Icons.share_outlined,
                'Share Summary',
                'Share a summary of selected records.',
                Colors.indigo,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _exportOption(
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
                  'History Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.check_circle_outline,
                  'Your latest reservation was completed',
                  '10 minutes ago',
                  Colors.green,
                ),
                _notificationItem(
                  Icons.star_outline_rounded,
                  'Rate your completed reservation',
                  '2 hours ago',
                  Colors.amber.shade800,
                ),
                _notificationItem(
                  Icons.auto_awesome_outlined,
                  'New history insight available',
                  'Yesterday',
                  Colors.indigo,
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
      'Reservation history refreshed',
    );
  }
}