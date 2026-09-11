import 'package:flutter/material.dart';

class ResourceReservationConflictScreen extends StatefulWidget {
  const ResourceReservationConflictScreen({super.key});

  @override
  State<ResourceReservationConflictScreen> createState() =>
      _ResourceReservationConflictScreenState();
}

class _ResourceReservationConflictScreenState
    extends State<ResourceReservationConflictScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Conflicts',
    'Timeline',
    'Alternatives',
    'Analytics',
  ];

  final List<String> filters = [
    'All',
    'Critical',
    'High',
    'Medium',
    'Resolved',
  ];

  final List<Map<String, dynamic>> conflicts = [
    {
      'resource': 'Dell Latitude 5420',
      'category': 'Technology',
      'level': 'Critical',
      'time': '10:30 AM - 12:30 PM',
      'date': 'Sep 8, 2026',
      'provider': 'VIT Resource Center',
      'seekerOne': 'Digital Learning Hub',
      'seekerTwo': 'Innovation Cell',
      'location': 'VIT Campus',
      'requested': 5,
      'available': 3,
      'status': 'Active',
      'icon': Icons.laptop_mac_outlined,
      'color': Colors.red,
    },
    {
      'resource': 'Projector with Stand',
      'category': 'Electronics',
      'level': 'High',
      'time': '2:00 PM - 4:00 PM',
      'date': 'Sep 9, 2026',
      'provider': 'Community Resource Hub',
      'seekerOne': 'Community Workshop',
      'seekerTwo': 'Student Innovation Club',
      'location': 'Katpadi',
      'requested': 2,
      'available': 1,
      'status': 'Active',
      'icon': Icons.videocam_outlined,
      'color': Colors.orange,
    },
    {
      'resource': 'Sports Equipment',
      'category': 'Sports',
      'level': 'Medium',
      'time': '4:30 PM - 6:30 PM',
      'date': 'Sep 10, 2026',
      'provider': 'Youth Activity Center',
      'seekerOne': 'VIT Sports Club',
      'seekerTwo': 'Youth Community',
      'location': 'Gandhi Nagar',
      'requested': 2,
      'available': 1,
      'status': 'Active',
      'icon': Icons.sports_basketball_outlined,
      'color': Colors.amber.shade800,
    },
    {
      'resource': 'Study Table Set',
      'category': 'Furniture',
      'level': 'Resolved',
      'time': '11:00 AM - 1:00 PM',
      'date': 'Sep 6, 2026',
      'provider': 'Student Support Center',
      'seekerOne': 'Community Library',
      'seekerTwo': 'Learning Hub',
      'location': 'Sathuvachari',
      'requested': 6,
      'available': 6,
      'status': 'Resolved',
      'icon': Icons.table_restaurant_outlined,
      'color': Colors.green,
    },
  ];

  List<Map<String, dynamic>> get filteredConflicts {
    return conflicts.where((conflict) {
      final matchesFilter = selectedFilter == 'All' ||
          conflict['level'] == selectedFilter ||
          conflict['status'] == selectedFilter;

      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          conflict['resource'].toString().toLowerCase().contains(query) ||
          conflict['provider'].toString().toLowerCase().contains(query) ||
          conflict['seekerOne'].toString().toLowerCase().contains(query) ||
          conflict['seekerTwo'].toString().toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  int get activeConflicts =>
      conflicts.where((item) => item['status'] == 'Active').length;

  int get criticalConflicts =>
      conflicts.where((item) => item['level'] == 'Critical').length;

  int get resolvedConflicts =>
      conflicts.where((item) => item['status'] == 'Resolved').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Conflict Resolution',
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
            Colors.deepOrange.shade700,
            scheme.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withValues(alpha: 0.16),
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
                  Icons.compare_arrows_rounded,
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
                  'Smart Resolution',
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
            'Reservation Conflicts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Detect overlapping reservations, identify shortages and resolve scheduling issues intelligently.',
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
                '$activeConflicts',
                'Active',
              ),
              _heroMetric(
                '$criticalConflicts',
                'Critical',
              ),
              _heroMetric(
                '$resolvedConflicts',
                'Resolved',
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
            '$activeConflicts',
            'Active',
            Colors.orange,
            Icons.warning_amber_outlined,
          ),
          _statItem(
            '$criticalConflicts',
            'Critical',
            Colors.red,
            Icons.priority_high_rounded,
          ),
          _statItem(
            '12 min',
            'Avg resolution',
            Colors.indigo,
            Icons.timer_outlined,
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
        return _buildTimeline();
      case 2:
        return _buildAlternatives();
      case 3:
        return _buildAnalytics();
      default:
        return _buildConflicts();
    }
  }

  Widget _buildConflicts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Conflict Queue',
          '${filteredConflicts.length} matching conflicts',
          Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 13),
        if (filteredConflicts.isEmpty)
          _emptyState()
        else
          ...filteredConflicts.map(_buildConflictCard),
      ],
    );
  }

  Widget _buildConflictCard(
    Map<String, dynamic> conflict,
  ) {
    final color = conflict['color'] as Color;
    final resolved = conflict['status'] == 'Resolved';

    return GestureDetector(
      onTap: () => _showConflictDetails(conflict),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: resolved
                ? Colors.green.withValues(alpha: 0.15)
                : color.withValues(alpha: 0.20),
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
                    conflict['icon'] as IconData,
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
                        conflict['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        conflict['category'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(
                  conflict['level'].toString(),
                  color,
                ),
              ],
            ),
            const SizedBox(height: 14),
            _conflictInfoRow(
              Icons.calendar_today_outlined,
              conflict['date'].toString(),
            ),
            _conflictInfoRow(
              Icons.access_time_outlined,
              conflict['time'].toString(),
            ),
            _conflictInfoRow(
              Icons.location_on_outlined,
              conflict['location'].toString(),
            ),
            const SizedBox(height: 11),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: color,
                    size: 17,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${conflict['requested']} requested • ${conflict['available']} available',
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _participantChip(
                    'Request A',
                    conflict['seekerOne'].toString(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _participantChip(
                    'Request B',
                    conflict['seekerTwo'].toString(),
                  ),
                ),
              ],
            ),
            if (!resolved) ...[
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showAlternativeOptions(conflict);
                      },
                      icon: const Icon(
                        Icons.swap_horiz_rounded,
                        size: 17,
                      ),
                      label: const Text(
                        'Resolve',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        _resolveConflict(conflict);
                      },
                      icon: const Icon(
                        Icons.check_rounded,
                        size: 17,
                      ),
                      label: const Text(
                        'Quick Fix',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _participantChip(
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

  Widget _conflictInfoRow(
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
    String text,
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
        text,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    final timelineItems = [
      {
        'time': '9:00 AM',
        'title': 'Resource released',
        'subtitle': 'Dell Latitude 5420 becomes available',
        'color': Colors.green,
        'icon': Icons.inventory_2_outlined,
      },
      {
        'time': '10:30 AM',
        'title': 'Reservation A starts',
        'subtitle': 'Digital Learning Hub pickup window',
        'color': Colors.indigo,
        'icon': Icons.login_rounded,
      },
      {
        'time': '11:00 AM',
        'title': 'Conflict detected',
        'subtitle': 'Innovation Cell overlaps with active reservation',
        'color': Colors.red,
        'icon': Icons.warning_amber_outlined,
      },
      {
        'time': '12:30 PM',
        'title': 'Suggested resolution',
        'subtitle': 'Move second request to 1:00 PM',
        'color': Colors.orange,
        'icon': Icons.auto_awesome_outlined,
      },
      {
        'time': '2:00 PM',
        'title': 'Alternative slot',
        'subtitle': 'Two compatible laptops become available',
        'color': Colors.teal,
        'icon': Icons.event_available_outlined,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Conflict Timeline',
          'Example schedule for the highest priority conflict',
          Icons.timeline_outlined,
        ),
        const SizedBox(height: 15),
        ...List.generate(
          timelineItems.length,
          (index) => _timelineItem(
            timelineItems[index],
            index,
            timelineItems.length,
          ),
        ),
        const SizedBox(height: 18),
        _smartResolutionCard(),
      ],
    );
  }

  Widget _timelineItem(
    Map<String, dynamic> item,
    int index,
    int total,
  ) {
    final color = item['color'] as Color;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 65,
            child: Text(
              item['time'].toString(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              if (index != total - 1)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color.withValues(alpha: 0.18),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: color,
                    size: 19,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'].toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['subtitle'].toString(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 9,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smartResolutionCard() {
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
            Icons.auto_awesome,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Resolution Recommendation',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Moving the second reservation by 30 minutes resolves the overlap without affecting the first participant.',
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

  Widget _buildAlternatives() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Alternative Resources',
          'Compatible options for unresolved conflicts',
          Icons.swap_horiz_rounded,
        ),
        const SizedBox(height: 14),
        _alternativeCard(
          'HP ProBook 440',
          'Technology',
          '2 units available',
          'VIT Campus',
          96,
          Icons.laptop_outlined,
          Colors.indigo,
        ),
        _alternativeCard(
          'Epson Projector',
          'Electronics',
          '1 unit available',
          'Katpadi',
          91,
          Icons.videocam_outlined,
          Colors.teal,
        ),
        _alternativeCard(
          'Study Table Set',
          'Furniture',
          '8 units available',
          'Sathuvachari',
          87,
          Icons.table_restaurant_outlined,
          Colors.orange,
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Alternative Time Slots',
          'Lower conflict probability',
          Icons.schedule_outlined,
        ),
        const SizedBox(height: 12),
        _slotCard(
          '12:30 PM - 2:30 PM',
          '92% compatibility',
          'No conflicts detected',
          Colors.green,
        ),
        _slotCard(
          '3:00 PM - 5:00 PM',
          '88% compatibility',
          'Low reservation traffic',
          Colors.indigo,
        ),
        _slotCard(
          '5:30 PM - 7:30 PM',
          '81% compatibility',
          'One nearby reservation',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _alternativeCard(
    String name,
    String category,
    String availability,
    String location,
    int score,
    IconData icon,
    Color color,
  ) {
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
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
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
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$availability • $location',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '$score%',
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'match',
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

  Widget _slotCard(
    String time,
    String compatibility,
    String note,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_outlined,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Text(
            compatibility,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalytics() {
    final categoryData = [
      ['Technology', 42, Colors.indigo],
      ['Electronics', 28, Colors.teal],
      ['Furniture', 18, Colors.orange],
      ['Sports', 12, Colors.green],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Conflict Analytics',
          'Reservation conflict patterns',
          Icons.bar_chart_outlined,
        ),
        const SizedBox(height: 14),
        _analyticsOverview(),
        const SizedBox(height: 18),
        _sectionTitle(
          'Conflicts by Category',
          'Share of detected scheduling conflicts',
          Icons.pie_chart_outline_rounded,
        ),
        const SizedBox(height: 13),
        ...categoryData.map(
          (item) => _categoryBar(
            item[0].toString(),
            item[1] as int,
            item[2] as Color,
          ),
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Resolution Performance',
          'How quickly conflicts are handled',
          Icons.speed_outlined,
        ),
        const SizedBox(height: 12),
        _performanceCard(
          'Average resolution time',
          '12 min',
          '18% faster than last month',
          Icons.timer_outlined,
          Colors.indigo,
        ),
        _performanceCard(
          'Successfully resolved',
          '94%',
          'Target is above 90%',
          Icons.check_circle_outline,
          Colors.green,
        ),
        _performanceCard(
          'Prevented conflicts',
          '78%',
          'Detected before pickup',
          Icons.shield_outlined,
          Colors.teal,
        ),
        const SizedBox(height: 18),
        _smartAnalyticsInsight(),
      ],
    );
  }

  Widget _analyticsOverview() {
    return Row(
      children: [
        Expanded(
          child: _miniMetric(
            '64',
            'Detected',
            Colors.indigo,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _miniMetric(
            '60',
            'Resolved',
            Colors.green,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _miniMetric(
            '4',
            'Open',
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _miniMetric(
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 17,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _categoryBar(
    String name,
    int value,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '$value%',
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 8,
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

  Widget _performanceCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 19,
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
                    fontSize: 11,
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
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smartAnalyticsInsight() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.amber.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: Colors.amber.shade800,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Insight',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Most conflicts happen when high-demand technology resources are reserved during afternoon peak hours.',
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

  Widget _emptyState() {
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
            Icons.check_circle_outline_rounded,
            size: 48,
            color: Colors.green.shade400,
          ),
          const SizedBox(height: 12),
          const Text(
            'No conflicts found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Everything looks clear for the selected filter.',
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

  void _showConflictDetails(
    Map<String, dynamic> conflict,
  ) {
    final color = conflict['color'] as Color;

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
                        conflict['icon'] as IconData,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        conflict['resource'].toString(),
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
                  Icons.warning_amber_outlined,
                  'Priority',
                  conflict['level'].toString(),
                ),
                _detailRow(
                  Icons.calendar_today_outlined,
                  'Date',
                  conflict['date'].toString(),
                ),
                _detailRow(
                  Icons.access_time_outlined,
                  'Time',
                  conflict['time'].toString(),
                ),
                _detailRow(
                  Icons.person_outline,
                  'Provider',
                  conflict['provider'].toString(),
                ),
                _detailRow(
                  Icons.people_outline,
                  'Request A',
                  conflict['seekerOne'].toString(),
                ),
                _detailRow(
                  Icons.people_outline,
                  'Request B',
                  conflict['seekerTwo'].toString(),
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Resource status',
                  '${conflict['available']} of ${conflict['requested']} available',
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  conflict['location'].toString(),
                ),
                const SizedBox(height: 15),
                if (conflict['status'] != 'Resolved')
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            _showAlternativeOptions(conflict);
                          },
                          child: const Text(
                            'Find Alternative',
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            _resolveConflict(conflict);
                          },
                          child: const Text(
                            'Resolve',
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

  void _showAlternativeOptions(
    Map<String, dynamic> conflict,
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
            28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resolve Conflict',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Choose the best option for ${conflict['resource']}.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 17),
              _resolutionOption(
                sheetContext,
                Icons.schedule_outlined,
                'Reschedule',
                'Move the second reservation to the next available slot.',
                Colors.indigo,
              ),
              _resolutionOption(
                sheetContext,
                Icons.swap_horiz_rounded,
                'Use alternative resource',
                'Assign a compatible resource nearby.',
                Colors.teal,
              ),
              _resolutionOption(
                sheetContext,
                Icons.location_on_outlined,
                'Change pickup location',
                'Find another verified pickup point.',
                Colors.orange,
              ),
              _resolutionOption(
                sheetContext,
                Icons.person_outline,
                'Contact participants',
                'Open a coordination request with both parties.',
                Colors.deepPurple,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _resolutionOption(
    BuildContext sheetContext,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(sheetContext);
        _showSnackBar('$title option selected');
      },
      borderRadius: BorderRadius.circular(17),
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(17),
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

  void _resolveConflict(
    Map<String, dynamic> conflict,
  ) {
    setState(() {
      conflict['status'] = 'Resolved';
      conflict['level'] = 'Resolved';
      conflict['color'] = Colors.green;
    });

    _showSnackBar(
      '${conflict['resource']} conflict resolved',
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
                  'Conflict Alerts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.priority_high_rounded,
                  'Critical laptop conflict detected',
                  '5 minutes ago',
                  Colors.red,
                ),
                _notificationItem(
                  Icons.schedule_outlined,
                  'Alternative slot found',
                  '18 minutes ago',
                  Colors.indigo,
                ),
                _notificationItem(
                  Icons.check_circle_outline,
                  'Study table conflict resolved',
                  '1 hour ago',
                  Colors.green,
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
      'Conflict center refreshed',
    );
  }
}