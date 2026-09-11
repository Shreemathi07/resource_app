import 'package:flutter/material.dart';

class ResourceReservationScreen extends StatefulWidget {
  const ResourceReservationScreen({super.key});

  @override
  State<ResourceReservationScreen> createState() =>
      _ResourceReservationScreenState();
}

class _ResourceReservationScreenState
    extends State<ResourceReservationScreen> {
  int selectedTab = 0;
  int selectedPeriod = 1;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Reservations',
    'Calendar',
    'Insights',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> filters = [
    'All',
    'Pending',
    'Confirmed',
    'Active',
    'Completed',
  ];

  final List<Map<String, dynamic>> reservations = [
    {
      'resource': 'Dell Latitude 5420',
      'category': 'Technology',
      'provider': 'VIT Digital Resource Club',
      'seeker': 'Digital Learning Hub',
      'location': 'Vellore Campus',
      'date': 'Sep 8, 2026',
      'time': '10:30 AM',
      'status': 'Confirmed',
      'quantity': 3,
      'duration': '7 days',
      'verification': 'Verified',
      'icon': Icons.laptop_mac_outlined,
    },
    {
      'resource': 'Study Table Set',
      'category': 'Furniture',
      'provider': 'Campus Community',
      'seeker': 'Student Support Center',
      'location': 'Katpadi',
      'date': 'Sep 9, 2026',
      'time': '2:00 PM',
      'status': 'Pending',
      'quantity': 5,
      'duration': '14 days',
      'verification': 'Pending',
      'icon': Icons.table_restaurant_outlined,
    },
    {
      'resource': 'Educational Book Bundle',
      'category': 'Education',
      'provider': 'Knowledge Share Group',
      'seeker': 'Community Learning Hub',
      'location': 'Sathuvachari',
      'date': 'Sep 10, 2026',
      'time': '11:00 AM',
      'status': 'Active',
      'quantity': 24,
      'duration': '30 days',
      'verification': 'Verified',
      'icon': Icons.menu_book_outlined,
    },
    {
      'resource': 'Projector with Stand',
      'category': 'Electronics',
      'provider': 'Innovation Cell',
      'seeker': 'Community Workshop',
      'location': 'Vellore',
      'date': 'Sep 11, 2026',
      'time': '4:30 PM',
      'status': 'Confirmed',
      'quantity': 1,
      'duration': '2 days',
      'verification': 'Verified',
      'icon': Icons.videocam_outlined,
    },
    {
      'resource': 'Sports Equipment Kit',
      'category': 'Sports',
      'provider': 'Campus Sports Club',
      'seeker': 'Youth Activity Center',
      'location': 'Gandhi Nagar',
      'date': 'Sep 5, 2026',
      'time': '9:00 AM',
      'status': 'Completed',
      'quantity': 2,
      'duration': '5 days',
      'verification': 'Verified',
      'icon': Icons.sports_basketball_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredReservations {
    return reservations.where((reservation) {
      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          reservation['resource'].toString().toLowerCase().contains(query) ||
          reservation['provider'].toString().toLowerCase().contains(query) ||
          reservation['seeker'].toString().toLowerCase().contains(query) ||
          reservation['category'].toString().toLowerCase().contains(query);

      final matchesFilter = selectedFilter == 'All' ||
          reservation['status'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
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
          'Resource Reservations',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: refreshData,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateReservation,
        icon: const Icon(Icons.event_available_outlined),
        label: const Text('Reserve'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroCard(),
                const SizedBox(height: 18),
                _buildSearchBar(),
                const SizedBox(height: 14),
                _buildPeriodSelector(),
                const SizedBox(height: 18),
                _buildReservationStats(),
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

  Widget _buildHeroCard() {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.20),
            blurRadius: 24,
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
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Smart Reservations',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Resource Reservation Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Reserve shared resources, manage pickup schedules and keep every exchange organized from one place.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('38', 'Active'),
              _heroMetric('12', 'Today'),
              _heroMetric('96%', 'On-time'),
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
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search resources, providers or seekers...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: _showFilters,
          icon: const Icon(Icons.tune_rounded),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedPeriod == index;

          return ChoiceChip(
            label: Text(periods[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedPeriod = index;
              });
            },
            labelStyle: TextStyle(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade700,
              fontWeight: FontWeight.w700,
            ),
          );
        },
      ),
    );
  }

  Widget _buildReservationStats() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
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
                  color: Colors.indigo.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.event_note_outlined,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reservation Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Current resource booking activity',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _statItem('38', 'Active', Colors.indigo),
              _statItem('7', 'Pending', Colors.orange),
              _statItem('64', 'Completed', Colors.green),
              _statItem('96%', 'Success', Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(
    String value,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
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
                  color: selected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
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
        return _buildReservationsTab();
      case 2:
        return _buildCalendarTab();
      case 3:
        return _buildInsightsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    final active = reservations.where(
      (reservation) =>
          reservation['status'] == 'Confirmed' ||
          reservation['status'] == 'Active',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Upcoming Reservations',
          'Your next resource bookings',
          Icons.upcoming_outlined,
        ),
        const SizedBox(height: 12),
        ...active.take(3).map(_buildReservationCard),
        const SizedBox(height: 10),
        _buildReminderCard(),
        const SizedBox(height: 18),
        _buildSmartReservationCard(),
      ],
    );
  }

  Widget _buildReservationsTab() {
    final items = filteredReservations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'All Reservations',
          'Manage every resource booking',
          Icons.list_alt_rounded,
        ),
        const SizedBox(height: 12),
        _buildFilterChips(),
        const SizedBox(height: 14),
        if (items.isEmpty)
          _buildEmptyState(
            Icons.event_busy_outlined,
            'No reservations found',
            'Try changing your search or reservation filter.',
          )
        else
          ...items.map(_buildReservationCard),
      ],
    );
  }

  Widget _buildCalendarTab() {
    final days = [
      ['07', 'Mon'],
      ['08', 'Tue'],
      ['09', 'Wed'],
      ['10', 'Thu'],
      ['11', 'Fri'],
      ['12', 'Sat'],
      ['13', 'Sun'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Smart Calendar',
          'Upcoming reservation schedule',
          Icons.calendar_view_week_outlined,
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, _) => const SizedBox(width: 9),
            itemBuilder: (context, index) {
              final selected = index == 1;

              return Container(
                width: 68,
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      days[index][0],
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      days[index][1],
                      style: TextStyle(
                        color: selected
                            ? Colors.white.withValues(alpha: 0.78)
                            : Colors.grey.shade600,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        _buildCalendarEvent(
          '10:30 AM',
          'Dell Latitude 5420',
          'VIT Digital Resource Club',
          Colors.indigo,
        ),
        _buildCalendarEvent(
          '2:00 PM',
          'Study Table Set',
          'Student Support Center',
          Colors.orange,
        ),
        const SizedBox(height: 18),
        _buildTimeSlotCard(),
      ],
    );
  }

  Widget _buildCalendarEvent(
    String time,
    String resource,
    String provider,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          SizedBox(
            width: 65,
            child: Text(
              time,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            width: 3,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.indigo,
              ),
              SizedBox(width: 9),
              Text(
                'Available Time Slots',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              '9:00 AM',
              '10:30 AM',
              '12:00 PM',
              '2:00 PM',
              '4:30 PM',
            ]
                .map(
                  (time) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      time,
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
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
          'Reservation Intelligence',
          'Smart patterns from resource bookings',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          'Peak pickup time',
          'Most resource pickups happen between 10 AM and 2 PM. Earlier slots may reduce waiting time.',
          Icons.schedule_outlined,
          Colors.indigo,
        ),
        _buildInsightCard(
          'Technology resources are highly requested',
          'Laptop and projector reservations account for a large portion of upcoming bookings.',
          Icons.devices_outlined,
          Colors.teal,
        ),
        _buildInsightCard(
          'Nearby reservations can be grouped',
          'Three upcoming reservations are within the same local area and may benefit from coordinated pickup.',
          Icons.route_outlined,
          Colors.orange,
        ),
        const SizedBox(height: 18),
        _buildReservationAnalytics(),
        const SizedBox(height: 18),
        _buildSmartReservationCard(),
      ],
    );
  }

  Widget _buildReservationAnalytics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reservation Performance',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _analyticsRow('On-time pickups', 0.96, '96%'),
          _analyticsRow('Confirmation rate', 0.91, '91%'),
          _analyticsRow('Resource utilization', 0.84, '84%'),
          _analyticsRow('Successful completion', 0.94, '94%'),
        ],
      ),
    );
  }

  Widget _analyticsRow(
    String label,
    double value,
    String percentage,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            percentage,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationCard(
    Map<String, dynamic> reservation,
  ) {
    final status = reservation['status'].toString();
    final color = _statusColor(status);

    return GestureDetector(
      onTap: () => _showReservationDetails(reservation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: status == 'Pending'
                ? Colors.orange.withValues(alpha: 0.20)
                : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    reservation['icon'] as IconData,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reservation['provider'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 5),
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
                              reservation['location'].toString(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _statusBadge(status, color),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  _reservationInfo(
                    Icons.calendar_today_outlined,
                    reservation['date'].toString(),
                  ),
                  _reservationInfo(
                    Icons.access_time_outlined,
                    reservation['time'].toString(),
                  ),
                  _reservationInfo(
                    Icons.inventory_2_outlined,
                    '${reservation['quantity']}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 5),
                Text(
                  'Duration: ${reservation['duration']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.verified_outlined,
                  size: 14,
                  color: reservation['verification'] == 'Verified'
                      ? Colors.green
                      : Colors.orange,
                ),
                const SizedBox(width: 4),
                Text(
                  reservation['verification'].toString(),
                  style: TextStyle(
                    color: reservation['verification'] == 'Verified'
                        ? Colors.green
                        : Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _reservationInfo(
    IconData icon,
    String value,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 13,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
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
        horizontal: 9,
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
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildReminderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.14),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: Colors.orange,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pickup Reminder',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'You have a confirmed resource pickup tomorrow at 10:30 AM. Keep your verification code ready.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
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

  Widget _buildSmartReservationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22),
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
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Reservation Suggestion',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'A nearby projector is available during your requested time. Reserving it now could reduce pickup travel and waiting time.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
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

  Widget _buildInsightCard(
    String title,
    String message,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
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
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
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

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = selectedFilter == filter;

          return FilterChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedFilter = filter;
              });
            },
          );
        },
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
            borderRadius: BorderRadius.circular(13),
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
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
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
            icon,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Confirmed':
        return Colors.indigo;
      case 'Active':
        return Colors.green;
      case 'Completed':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _showReservationDetails(
    Map<String, dynamic> reservation,
  ) {
    final status = reservation['status'].toString();
    final color = _statusColor(status);

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
                        reservation['icon'] as IconData,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        reservation['resource'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    _statusBadge(status, color),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  reservation['category'].toString(),
                ),
                _detailRow(
                  Icons.person_outline,
                  'Provider',
                  reservation['provider'].toString(),
                ),
                _detailRow(
                  Icons.person_search_outlined,
                  'Seeker',
                  reservation['seeker'].toString(),
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Pickup location',
                  reservation['location'].toString(),
                ),
                _detailRow(
                  Icons.calendar_today_outlined,
                  'Date',
                  reservation['date'].toString(),
                ),
                _detailRow(
                  Icons.access_time_outlined,
                  'Pickup time',
                  reservation['time'].toString(),
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Quantity',
                  reservation['quantity'].toString(),
                ),
                _detailRow(
                  Icons.timer_outlined,
                  'Duration',
                  reservation['duration'].toString(),
                ),
                _detailRow(
                  Icons.verified_outlined,
                  'Verification',
                  reservation['verification'].toString(),
                ),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.qr_code_2_rounded,
                        color: Colors.indigo,
                        size: 32,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verification Code Ready',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Show the exchange verification code during pickup.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showRescheduleSheet(reservation);
                        },
                        icon: const Icon(
                          Icons.schedule_outlined,
                        ),
                        label: const Text('Reschedule'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Reservation details confirmed',
                          );
                        },
                        icon: const Icon(
                          Icons.check_circle_outline,
                        ),
                        label: const Text('Confirm'),
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
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRescheduleSheet(
    Map<String, dynamic> reservation,
  ) {
    String selectedTime = reservation['time'].toString();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
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
                    'Reschedule Reservation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    reservation['resource'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    initialValue: selectedTime,
                    decoration: const InputDecoration(
                      labelText: 'Pickup Time',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: '9:00 AM',
                        child: Text('9:00 AM'),
                      ),
                      DropdownMenuItem(
                        value: '10:30 AM',
                        child: Text('10:30 AM'),
                      ),
                      DropdownMenuItem(
                        value: '12:00 PM',
                        child: Text('12:00 PM'),
                      ),
                      DropdownMenuItem(
                        value: '2:00 PM',
                        child: Text('2:00 PM'),
                      ),
                      DropdownMenuItem(
                        value: '4:30 PM',
                        child: Text('4:30 PM'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setSheetState(() {
                          selectedTime = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Reservation rescheduled to $selectedTime',
                        );
                      },
                      child: const Text(
                        'Save New Time',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showFilters() {
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
                  'Reservation Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ...filters.map(
                  (filter) => ListTile(
                    leading: Icon(
                      filter == 'Pending'
                          ? Icons.hourglass_empty_rounded
                          : filter == 'Confirmed'
                              ? Icons.check_circle_outline
                              : filter == 'Active'
                                  ? Icons.play_circle_outline
                                  : filter == 'Completed'
                                      ? Icons.task_alt_rounded
                                      : Icons.all_inbox_outlined,
                    ),
                    title: Text(filter),
                    trailing: selectedFilter == filter
                        ? const Icon(Icons.check_rounded)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                      Navigator.pop(sheetContext);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCreateReservation() {
    String category = 'Technology';

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
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Reservation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Reserve an available community resource.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Resource name',
                        hintText: 'Search or enter resource',
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Technology',
                          child: Text('Technology'),
                        ),
                        DropdownMenuItem(
                          value: 'Education',
                          child: Text('Education'),
                        ),
                        DropdownMenuItem(
                          value: 'Furniture',
                          child: Text('Furniture'),
                        ),
                        DropdownMenuItem(
                          value: 'Electronics',
                          child: Text('Electronics'),
                        ),
                        DropdownMenuItem(
                          value: 'Sports',
                          child: Text('Sports'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            category = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Preferred date',
                        hintText: 'Select reservation date',
                        suffixIcon: const Icon(
                          Icons.calendar_today_outlined,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Pickup location',
                        hintText: 'Enter preferred location',
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Reservation request created',
                          );
                        },
                        icon: const Icon(
                          Icons.event_available_outlined,
                        ),
                        label: const Text(
                          'Request Reservation',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
                  'Reservation Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.event_available_outlined,
                  'Your laptop reservation was confirmed',
                  '10 min ago',
                ),
                _notificationItem(
                  Icons.notifications_active_outlined,
                  'Pickup reminder for tomorrow',
                  '1 hour ago',
                ),
                _notificationItem(
                  Icons.auto_awesome_outlined,
                  'A better nearby reservation slot is available',
                  '2 hours ago',
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
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.10),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        time,
        style: const TextStyle(
          fontSize: 11,
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

    _showSnackBar('Reservation data refreshed');
  }
}