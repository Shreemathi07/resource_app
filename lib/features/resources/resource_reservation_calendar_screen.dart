import 'package:flutter/material.dart';

class ResourceReservationCalendarScreen extends StatefulWidget {
  const ResourceReservationCalendarScreen({super.key});

  @override
  State<ResourceReservationCalendarScreen> createState() =>
      _ResourceReservationCalendarScreenState();
}

class _ResourceReservationCalendarScreenState
    extends State<ResourceReservationCalendarScreen> {
  int selectedTab = 0;
  int selectedDay = 2;
  String selectedCategory = 'All';
  String selectedResource = 'All Resources';

  final List<String> tabs = [
    'Calendar',
    'Availability',
    'Reservations',
    'Insights',
  ];

  final List<String> categories = [
    'All',
    'Technology',
    'Education',
    'Furniture',
    'Electronics',
    'Sports',
  ];

  final List<String> resources = [
    'All Resources',
    'Dell Latitude 5420',
    'Study Table Set',
    'Projector with Stand',
    'Educational Books',
    'Sports Equipment',
  ];

  final List<Map<String, dynamic>> days = [
    {
      'day': 'Mon',
      'date': '7',
      'fullDate': 'Sep 7, 2026',
    },
    {
      'day': 'Tue',
      'date': '8',
      'fullDate': 'Sep 8, 2026',
    },
    {
      'day': 'Wed',
      'date': '9',
      'fullDate': 'Sep 9, 2026',
    },
    {
      'day': 'Thu',
      'date': '10',
      'fullDate': 'Sep 10, 2026',
    },
    {
      'day': 'Fri',
      'date': '11',
      'fullDate': 'Sep 11, 2026',
    },
    {
      'day': 'Sat',
      'date': '12',
      'fullDate': 'Sep 12, 2026',
    },
    {
      'day': 'Sun',
      'date': '13',
      'fullDate': 'Sep 13, 2026',
    },
  ];

  final List<Map<String, dynamic>> reservationData = [
    {
      'resource': 'Dell Latitude 5420',
      'category': 'Technology',
      'seeker': 'Digital Learning Hub',
      'time': '10:30 AM',
      'endTime': '12:30 PM',
      'quantity': 3,
      'status': 'Reserved',
      'location': 'VIT Campus',
      'color': Colors.indigo,
      'icon': Icons.laptop_mac_outlined,
      'day': 1,
    },
    {
      'resource': 'Study Table Set',
      'category': 'Furniture',
      'seeker': 'Student Support Center',
      'time': '2:00 PM',
      'endTime': '4:00 PM',
      'quantity': 5,
      'status': 'Reserved',
      'location': 'Katpadi',
      'color': Colors.orange,
      'icon': Icons.table_restaurant_outlined,
      'day': 2,
    },
    {
      'resource': 'Projector with Stand',
      'category': 'Electronics',
      'seeker': 'Community Workshop',
      'time': '4:30 PM',
      'endTime': '6:30 PM',
      'quantity': 1,
      'status': 'Reserved',
      'location': 'Vellore',
      'color': Colors.teal,
      'icon': Icons.videocam_outlined,
      'day': 3,
    },
    {
      'resource': 'Educational Books',
      'category': 'Education',
      'seeker': 'Community Learning Hub',
      'time': '11:00 AM',
      'endTime': '1:00 PM',
      'quantity': 24,
      'status': 'Available',
      'location': 'Sathuvachari',
      'color': Colors.green,
      'icon': Icons.menu_book_outlined,
      'day': 3,
    },
    {
      'resource': 'Sports Equipment',
      'category': 'Sports',
      'seeker': 'Youth Activity Center',
      'time': '9:00 AM',
      'endTime': '11:00 AM',
      'quantity': 2,
      'status': 'Conflict',
      'location': 'Gandhi Nagar',
      'color': Colors.red,
      'icon': Icons.sports_basketball_outlined,
      'day': 4,
    },
    {
      'resource': 'Dell Latitude 5420',
      'category': 'Technology',
      'seeker': 'Innovation Cell',
      'time': '3:00 PM',
      'endTime': '5:00 PM',
      'quantity': 2,
      'status': 'Available',
      'location': 'VIT Campus',
      'color': Colors.green,
      'icon': Icons.laptop_mac_outlined,
      'day': 4,
    },
  ];

  List<Map<String, dynamic>> get selectedDayReservations {
    return reservationData.where((reservation) {
      final matchesDay = reservation['day'] == selectedDay;

      final matchesCategory = selectedCategory == 'All' ||
          reservation['category'] == selectedCategory;

      final matchesResource = selectedResource == 'All Resources' ||
          reservation['resource'] == selectedResource;

      return matchesDay && matchesCategory && matchesResource;
    }).toList();
  }

  int get reservedCount => reservationData
      .where((reservation) => reservation['status'] == 'Reserved')
      .length;

  int get availableCount => reservationData
      .where((reservation) => reservation['status'] == 'Available')
      .length;

  int get conflictCount => reservationData
      .where((reservation) => reservation['status'] == 'Conflict')
      .length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Reservation Calendar',
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
                _buildTabs(),
                const SizedBox(height: 18),
                _buildSelectedTab(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateReservation,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Reserve'),
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
            scheme.primary.withValues(alpha: 0.68),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
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
                  Icons.calendar_month_outlined,
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
                  'Smart Calendar',
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
            'Resource Availability',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Find available resources, manage reservation slots and prevent schedule conflicts before they happen.',
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
                '$reservedCount',
                'Reserved',
              ),
              _heroMetric(
                '$availableCount',
                'Available',
              ),
              _heroMetric(
                '$conflictCount',
                'Conflicts',
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
      width: double.infinity,
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
            '42',
            'Available slots',
            Colors.green,
            Icons.event_available_outlined,
          ),
          _statItem(
            '18',
            'Reservations',
            Colors.indigo,
            Icons.event_note_outlined,
          ),
          _statItem(
            '3',
            'Conflicts',
            Colors.red,
            Icons.warning_amber_outlined,
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
        return _buildAvailabilityTab();
      case 2:
        return _buildReservationsTab();
      case 3:
        return _buildInsightsTab();
      default:
        return _buildCalendarTab();
    }
  }

  Widget _buildCalendarTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'September 2026',
          'Select a date to view reservation activity',
          Icons.calendar_today_outlined,
        ),
        const SizedBox(height: 13),
        _buildDaySelector(),
        const SizedBox(height: 20),
        _buildSelectedDateHeader(),
        const SizedBox(height: 12),
        _buildFilters(),
        const SizedBox(height: 15),
        if (selectedDayReservations.isEmpty)
          _buildEmptyState()
        else
          ...selectedDayReservations.map(_buildReservationCard),
        const SizedBox(height: 18),
        _buildSmartSlotSuggestion(),
      ],
    );
  }

  Widget _buildDaySelector() {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = days[index];
          final selected = selectedDay == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 62,
              padding: const EdgeInsets.symmetric(vertical: 10),
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
                    day['day'].toString(),
                    style: TextStyle(
                      color: selected
                          ? Colors.white.withValues(alpha: 0.75)
                          : Colors.grey.shade600,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    day['date'].toString(),
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.grey.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedDateHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            days[selectedDay]['fullDate'].toString(),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          '${selectedDayReservations.length} events',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            initialValue: selectedCategory,
            decoration: InputDecoration(
              labelText: 'Category',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedCategory = value;
              });
            },
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: DropdownButtonFormField<String>(
            initialValue: selectedResource,
            decoration: InputDecoration(
              labelText: 'Resource',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: resources.map((resource) {
              return DropdownMenuItem(
                value: resource,
                child: Text(
                  resource,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedResource = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReservationCard(
    Map<String, dynamic> reservation,
  ) {
    final color = reservation['color'] as Color;
    final status = reservation['status'].toString();

    return GestureDetector(
      onTap: () => _showReservationDetails(reservation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: status == 'Conflict'
                ? Colors.red.withValues(alpha: 0.22)
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Icon(
                    reservation['icon'] as IconData,
                    color: color,
                    size: 19,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    reservation['time'].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
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
                          reservation['resource'].toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _statusBadge(
                        status,
                        _statusColor(status),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    reservation['seeker'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reservation['time']} - ${reservation['endTime']}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reservation['quantity']}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          reservation['location'].toString(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 9,
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

  Widget _statusBadge(
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
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
      case 'Available':
        return Colors.green;
      case 'Reserved':
        return Colors.indigo;
      case 'Conflict':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSmartSlotSuggestion() {
    return Container(
      width: double.infinity,
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
                  'Smart Slot Suggestion',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'The best available pickup window today is 12:30 PM–2:00 PM with low reservation traffic.',
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

  Widget _buildAvailabilityTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Available Time Slots',
          'Choose a convenient pickup window',
          Icons.schedule_outlined,
        ),
        const SizedBox(height: 13),
        _timeSlot(
          '9:00 AM - 10:30 AM',
          '8 resources available',
          true,
        ),
        _timeSlot(
          '10:30 AM - 12:00 PM',
          '4 resources available',
          true,
        ),
        _timeSlot(
          '12:00 PM - 1:30 PM',
          '11 resources available',
          true,
        ),
        _timeSlot(
          '1:30 PM - 3:00 PM',
          '6 resources available',
          true,
        ),
        _timeSlot(
          '3:00 PM - 4:30 PM',
          '2 resources available',
          false,
        ),
        _timeSlot(
          '4:30 PM - 6:00 PM',
          '5 resources available',
          true,
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Availability Summary',
          'Resource capacity for today',
          Icons.inventory_2_outlined,
        ),
        const SizedBox(height: 12),
        _availabilitySummary(),
        const SizedBox(height: 20),
        _buildSmartAvailabilityCard(),
      ],
    );
  }

  Widget _timeSlot(
    String time,
    String availability,
    bool available,
  ) {
    final color = available ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: available
              ? Colors.grey.shade200
              : Colors.red.withValues(alpha: 0.18),
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
              available
                  ? Icons.event_available_outlined
                  : Icons.event_busy_outlined,
              color: color,
              size: 19,
            ),
          ),
          const SizedBox(width: 11),
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
                  availability,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          if (available)
            FilledButton(
              onPressed: () {
                _showSnackBar(
                  '$time selected',
                );
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Select',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            )
          else
            _statusBadge(
              'Busy',
              Colors.red,
            ),
        ],
      ),
    );
  }

  Widget _availabilitySummary() {
    final items = [
      ['Technology', '18', '82%', Colors.indigo],
      ['Education', '12', '91%', Colors.green],
      ['Furniture', '7', '64%', Colors.orange],
      ['Electronics', '5', '57%', Colors.teal],
    ];

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 9,
                height: 35,
                decoration: BoxDecoration(
                  color: item[3] as Color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  item[0].toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${item[1]} available',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 9,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                item[2].toString(),
                style: TextStyle(
                  color: item[3] as Color,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSmartAvailabilityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
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
              color: Colors.amber.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.amber.shade800,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Best Availability',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '12:00 PM–1:30 PM currently has the highest resource availability.',
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

  Widget _buildReservationsTab() {
    final reservations = reservationData
        .where((reservation) => reservation['status'] == 'Reserved')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Active Reservations',
          'Currently scheduled resource reservations',
          Icons.event_note_outlined,
        ),
        const SizedBox(height: 13),
        ...reservations.map(_buildReservationCard),
        const SizedBox(height: 18),
        _buildUpcomingReminder(),
      ],
    );
  }

  Widget _buildUpcomingReminder() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.notifications_active_outlined,
            color: Colors.orange,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming Reminder',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '3 reservations are scheduled within the next 24 hours. Pickup reminders can be sent automatically.',
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
          'Calendar Intelligence',
          'Smart patterns from reservation activity',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 13),
        _insightCard(
          Icons.schedule_rounded,
          'Peak pickup window',
          '2 PM–5 PM has the highest reservation activity across the network.',
          Colors.indigo,
        ),
        _insightCard(
          Icons.inventory_2_outlined,
          'Technology resources are highly requested',
          'Laptop availability is expected to decrease over the next few days.',
          Colors.orange,
        ),
        _insightCard(
          Icons.warning_amber_rounded,
          'Conflict risk detected',
          'Sports equipment has repeated overlapping reservation windows.',
          Colors.red,
        ),
        _insightCard(
          Icons.event_available_outlined,
          'Best low-traffic window',
          'Morning slots between 9 AM and 11 AM have the lowest reservation pressure.',
          Colors.green,
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Weekly Utilization',
          'Reservation capacity usage',
          Icons.bar_chart_outlined,
        ),
        const SizedBox(height: 12),
        _buildUtilizationChart(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Smart Recommendations',
          'Improve resource scheduling',
          Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: 12),
        _recommendation(
          'Open additional afternoon slots',
          'Demand is consistently high from 2 PM to 5 PM.',
          Icons.add_alarm_outlined,
        ),
        _recommendation(
          'Move flexible reservations',
          'Some reservations can be shifted to low-demand periods.',
          Icons.swap_horiz_rounded,
        ),
        _recommendation(
          'Review conflict-prone resources',
          'Three resources require schedule validation.',
          Icons.rule_outlined,
        ),
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
          color: color.withValues(alpha: 0.16),
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

  Widget _buildUtilizationChart() {
    final values = [54, 68, 61, 82, 76, 48, 42];
    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      height: 210,
      padding: const EdgeInsets.fromLTRB(
        15,
        18,
        15,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          final height = values[index] * 1.35;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${values[index]}%',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(
                            alpha: 0.28 +
                                values[index] / 100 * 0.45,
                          ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(9),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _recommendation(
    String title,
    String subtitle,
    IconData icon,
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
              color: Colors.amber.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.amber.shade800,
              size: 19,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
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
            Icons.event_available_outlined,
            size: 46,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 13),
          const Text(
            'No reservations found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'There are no matching reservations for this date and filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showReservationDetails(
    Map<String, dynamic> reservation,
  ) {
    final color = reservation['color'] as Color;

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
                      backgroundColor:
                          color.withValues(alpha: 0.10),
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
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _detailRow(
                  Icons.person_outline,
                  'Reserved for',
                  reservation['seeker'].toString(),
                ),
                _detailRow(
                  Icons.calendar_today_outlined,
                  'Date',
                  days[selectedDay]['fullDate'].toString(),
                ),
                _detailRow(
                  Icons.access_time_outlined,
                  'Time',
                  '${reservation['time']} - ${reservation['endTime']}',
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Quantity',
                  reservation['quantity'].toString(),
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Pickup',
                  reservation['location'].toString(),
                ),
                _detailRow(
                  Icons.circle_outlined,
                  'Status',
                  reservation['status'].toString(),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Reschedule options opened',
                          );
                        },
                        child: const Text('Reschedule'),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Reservation details confirmed',
                          );
                        },
                        child: const Text('Confirm'),
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
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateReservation() {
    String resource = 'Dell Latitude 5420';
    String duration = '2 hours';

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
                MediaQuery.of(context).viewInsets.bottom + 25,
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
                    const SizedBox(height: 18),
                    const Text(
                      'Create Reservation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 17),
                    DropdownButtonFormField<String>(
                      initialValue: resource,
                      decoration: InputDecoration(
                        labelText: 'Resource',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: resources.skip(1).map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            resource = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: duration,
                      decoration: InputDecoration(
                        labelText: 'Reservation duration',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: [
                        '1 hour',
                        '2 hours',
                        '4 hours',
                        '1 day',
                        '7 days',
                      ].map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            duration = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Pickup location',
                        hintText: 'Enter pickup location',
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Reservation request created',
                          );
                        },
                        icon: const Icon(
                          Icons.check_rounded,
                        ),
                        label: const Text(
                          'Create Reservation',
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
                  'Calendar Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.event_outlined,
                  'Reservation scheduled for tomorrow',
                  '10 minutes ago',
                ),
                _notificationItem(
                  Icons.warning_amber_rounded,
                  'A schedule conflict was detected',
                  '35 minutes ago',
                ),
                _notificationItem(
                  Icons.auto_awesome_outlined,
                  'New smart slot recommendation',
                  '1 hour ago',
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
            .withValues(alpha: 0.09),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
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

    _showSnackBar('Reservation calendar refreshed');
  }
}