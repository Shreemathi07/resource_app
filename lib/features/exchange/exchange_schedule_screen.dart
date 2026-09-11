import 'package:flutter/material.dart';

class ExchangeScheduleScreen extends StatefulWidget {
  const ExchangeScheduleScreen({super.key});

  @override
  State<ExchangeScheduleScreen> createState() =>
      _ExchangeScheduleScreenState();
}

class _ExchangeScheduleScreenState extends State<ExchangeScheduleScreen> {
  int selectedTab = 0;
  String selectedPeriod = 'Today';

  final List<String> tabs = [
    'Upcoming',
    'Today',
    'Calendar',
    'Completed',
  ];

  final List<String> periods = [
    'Today',
    'Tomorrow',
    'This Week',
  ];

  final List<Map<String, dynamic>> exchanges = [
    {
      'title': 'Textbook Handover',
      'resource': 'Data Structures Textbooks',
      'provider': 'Aarav Kumar',
      'receiver': 'Meera Nair',
      'date': 'Today',
      'time': '04:30 PM',
      'location': 'VIT Library Entrance',
      'status': 'Confirmed',
      'type': 'Resource Exchange',
      'duration': '20 min',
    },
    {
      'title': 'Laptop Accessories',
      'resource': 'Laptop Stand + Keyboard',
      'provider': 'Rahul Dev',
      'receiver': 'Priya S',
      'date': 'Today',
      'time': '06:00 PM',
      'location': 'Technology Tower Lobby',
      'status': 'Pending',
      'type': 'Resource Exchange',
      'duration': '15 min',
    },
    {
      'title': 'Lab Equipment Return',
      'resource': 'Arduino Starter Kit',
      'provider': 'VIT Innovation Club',
      'receiver': 'Arjun Kumar',
      'date': 'Tomorrow',
      'time': '10:30 AM',
      'location': 'Innovation Lab',
      'status': 'Confirmed',
      'type': 'Organization Exchange',
      'duration': '30 min',
    },
    {
      'title': 'Stationery Collection',
      'resource': 'Engineering Stationery Kit',
      'provider': 'Kavya R',
      'receiver': 'Nithin P',
      'date': 'Tomorrow',
      'time': '02:00 PM',
      'location': 'Student Activity Centre',
      'status': 'Pending',
      'type': 'Resource Exchange',
      'duration': '15 min',
    },
    {
      'title': 'Project Component Handover',
      'resource': 'Sensors and Jumper Wires',
      'provider': 'Tech Community',
      'receiver': 'Vignesh M',
      'date': 'This Week',
      'time': '05:15 PM',
      'location': 'Digital Learning Centre',
      'status': 'Confirmed',
      'type': 'Community Exchange',
      'duration': '25 min',
    },
  ];

  final List<Map<String, String>> completed = [
    {
      'title': 'Calculus Books',
      'date': 'Sep 05',
      'time': '04:00 PM',
      'status': 'Completed',
      'rating': '5.0',
    },
    {
      'title': 'USB Hub',
      'date': 'Sep 04',
      'time': '06:15 PM',
      'status': 'Completed',
      'rating': '4.8',
    },
    {
      'title': 'Lab Coat',
      'date': 'Sep 02',
      'time': '11:30 AM',
      'status': 'Completed',
      'rating': '4.9',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Exchange Schedule',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          IconButton(
            onPressed: showCalendarOptions,
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshSchedule,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          children: [
            buildHero(),
            const SizedBox(height: 18),
            buildQuickStats(),
            const SizedBox(height: 20),
            buildTabs(),
            const SizedBox(height: 16),
            buildContent(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showCreateSchedule,
        backgroundColor: const Color(0xFF18202A),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Schedule Exchange',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget buildHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF18202A),
            Color(0xFF364557),
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
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.event_available_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Smart Exchange Calendar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Next handover',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Textbook Handover',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Today • 04:30 PM • VIT Library Entrance',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.72,
                    minHeight: 7,
                    backgroundColor: Color(0x334A5564),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFB8F2D0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                '72%',
                style: TextStyle(
                  color: Color(0xFFB8F2D0),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Text(
            'Preparation complete',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: quickStat(
            '4',
            'Upcoming',
            Icons.event_note_rounded,
            const Color(0xFF3867D6),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: quickStat(
            '2',
            'Today',
            Icons.today_rounded,
            const Color(0xFF23844D),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: quickStat(
            '18',
            'Completed',
            Icons.task_alt_rounded,
            const Color(0xFF8A5A00),
          ),
        ),
      ],
    );
  }

  Widget quickStat(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 22,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF7A8491),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabs() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF3),
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: selected
                          ? const Color(0xFF18202A)
                          : const Color(0xFF7A8491),
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

  Widget buildContent() {
    switch (selectedTab) {
      case 1:
        return buildToday();
      case 2:
        return buildCalendar();
      case 3:
        return buildCompleted();
      default:
        return buildUpcoming();
    }
  }

  Widget buildUpcoming() {
    final upcoming = exchanges.where((item) {
      return item['date'] == 'Today' ||
          item['date'] == 'Tomorrow' ||
          item['date'] == 'This Week';
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPeriodSelector(),
        const SizedBox(height: 20),
        sectionTitle(
          'Upcoming handovers',
          '${upcoming.length} scheduled exchanges',
        ),
        const SizedBox(height: 12),
        ...upcoming.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: exchangeCard(item),
          ),
        ),
        const SizedBox(height: 10),
        buildSmartSuggestion(),
      ],
    );
  }

  Widget buildPeriodSelector() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final period = periods[index];
          final selected = selectedPeriod == period;

          return ChoiceChip(
            label: Text(period),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedPeriod = period;
              });
            },
            selectedColor: const Color(0xFF18202A),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: selected
                  ? Colors.white
                  : const Color(0xFF687382),
            ),
          );
        },
      ),
    );
  }

  Widget buildToday() {
    final today = exchanges.where(
      (item) => item['date'] == 'Today',
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Today',
          '${today.length} exchanges scheduled',
        ),
        const SizedBox(height: 12),
        if (today.isEmpty)
          emptyState(
            Icons.event_busy_rounded,
            'No exchanges today',
            'Your schedule is clear for today.',
          )
        else
          ...today.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: exchangeCard(item),
            ),
          ),
        const SizedBox(height: 14),
        buildReminderCard(),
      ],
    );
  }

  Widget buildCalendar() {
    final days = [
      {
        'day': 'MON',
        'date': '07',
        'count': '2',
        'active': true,
      },
      {
        'day': 'TUE',
        'date': '08',
        'count': '2',
        'active': false,
      },
      {
        'day': 'WED',
        'date': '09',
        'count': '1',
        'active': false,
      },
      {
        'day': 'THU',
        'date': '10',
        'count': '3',
        'active': false,
      },
      {
        'day': 'FRI',
        'date': '11',
        'count': '2',
        'active': false,
      },
      {
        'day': 'SAT',
        'date': '12',
        'count': '1',
        'active': false,
      },
      {
        'day': 'SUN',
        'date': '13',
        'count': '0',
        'active': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'September 2026',
          'Exchange activity by day',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE5E9EF),
            ),
          ),
          child: Row(
            children: days.map(
              (day) {
                final active = day['active'] as bool;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showCalendarDay(
                        day['day'].toString(),
                        day['date'].toString(),
                        day['count'].toString(),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFF18202A)
                            : const Color(0xFFF6F8FB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            day['day'].toString(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              color: active
                                  ? Colors.white70
                                  : const Color(0xFF7A8491),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            day['date'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: active
                                  ? Colors.white
                                  : const Color(0xFF18202A),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            day['count'].toString(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: active
                                  ? const Color(0xFFB8F2D0)
                                  : const Color(0xFF3867D6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Schedule overview',
          'Next available time windows',
        ),
        const SizedBox(height: 12),
        timeSlot(
          '04:00 PM - 05:00 PM',
          '2 exchanges',
          true,
        ),
        const SizedBox(height: 10),
        timeSlot(
          '05:00 PM - 06:00 PM',
          '1 exchange',
          false,
        ),
        const SizedBox(height: 10),
        timeSlot(
          '06:00 PM - 07:00 PM',
          '2 exchanges',
          false,
        ),
        const SizedBox(height: 20),
        buildSmartSchedulingCard(),
      ],
    );
  }

  Widget timeSlot(
    String time,
    String exchangesCount,
    bool highlighted,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted
            ? const Color(0xFFF0F5FF)
            : Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: highlighted
              ? const Color(0xFFDCE7FF)
              : const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            color: highlighted
                ? const Color(0xFF3867D6)
                : const Color(0xFF7A8491),
            size: 21,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: Color(0xFF18202A),
              ),
            ),
          ),
          Text(
            exchangesCount,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF7A8491),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompleted() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Completed exchanges',
          'Recently finished handovers',
        ),
        const SizedBox(height: 12),
        ...completed.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: completedCard(item),
          ),
        ),
        const SizedBox(height: 18),
        buildCompletionSummary(),
      ],
    );
  }

  Widget completedCard(Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8EF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xFF23844D),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item['date']} • ${item['time']}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFB27600),
                size: 15,
              ),
              const SizedBox(width: 3),
              Text(
                item['rating']!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCompletionSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Scheduling performance',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Text(
                'Excellent',
                style: TextStyle(
                  color: Color(0xFF23844D),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          summaryRow(
            'On-time handovers',
            '94%',
            0.94,
          ),
          const SizedBox(height: 13),
          summaryRow(
            'Confirmed before handover',
            '98%',
            0.98,
          ),
          const SizedBox(height: 13),
          summaryRow(
            'Reminder effectiveness',
            '91%',
            0.91,
          ),
        ],
      ),
    );
  }

  Widget summaryRow(
    String title,
    String value,
    double progress,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF596573),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFF18202A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: const Color(0xFFECEFF3),
          ),
        ),
      ],
    );
  }

  Widget exchangeCard(Map<String, dynamic> item) {
    final confirmed = item['status'] == 'Confirmed';

    return InkWell(
      onTap: () => showExchangeDetails(item),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3F6),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.swap_horizontal_circle_outlined,
                    color: Color(0xFF3867D6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                    ],
                  ),
                ),
                statusBadge(
                  item['status'].toString(),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: Color(0xFF7A8491),
                ),
                const SizedBox(width: 5),
                Text(
                  item['date'].toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF596573),
                  ),
                ),
                const SizedBox(width: 13),
                const Icon(
                  Icons.access_time_rounded,
                  size: 15,
                  color: Color(0xFF7A8491),
                ),
                const SizedBox(width: 5),
                Text(
                  item['time'].toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF596573),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: Color(0xFF7A8491),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item['location'].toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: const Color(0xFFE8F0FF),
                  child: Text(
                    item['provider']
                        .toString()
                        .substring(0, 1),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF3867D6),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    item['provider'].toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF596573),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (confirmed)
                  TextButton.icon(
                    onPressed: () => confirmHandover(item),
                    icon: const Icon(
                      Icons.check_rounded,
                      size: 15,
                    ),
                    label: const Text('Confirm'),
                  )
                else
                  TextButton(
                    onPressed: () => showReschedule(item),
                    child: const Text(
                      'Manage',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
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

  Widget statusBadge(String status) {
    final confirmed = status == 'Confirmed';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: confirmed
            ? const Color(0xFFE8F8EF)
            : const Color(0xFFFFF3DD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: confirmed
              ? const Color(0xFF23844D)
              : const Color(0xFFB27600),
        ),
      ),
    );
  }

  Widget buildSmartSuggestion() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF3867D6),
            size: 23,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart scheduling suggestion',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Your 6 PM slot has the lowest crowd level today. Consider scheduling future handovers around this time.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReminderCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E9),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFFFE5AA),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_active_outlined,
            color: Color(0xFFB27600),
            size: 24,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reminder active',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'You will receive a reminder 30 minutes before your next handover.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmartSchedulingCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFEFF5FF),
            Color(0xFFF7F9FC),
          ],
        ),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.psychology_alt_outlined,
            color: Color(0xFF3867D6),
            size: 25,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI scheduling insight',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Based on previous activity, 4:30 PM - 6:30 PM is currently the most reliable exchange window.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF18202A),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF7A8491),
          ),
        ),
      ],
    );
  }

  Widget emptyState(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 44,
            color: const Color(0xFF9AA3AE),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  void showExchangeDetails(Map<String, dynamic> item) {
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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              14,
              20,
              20,
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
                        color: const Color(0xFFD8DDE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['title'].toString(),
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF18202A),
                          ),
                        ),
                      ),
                      statusBadge(
                        item['status'].toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['resource'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                  const SizedBox(height: 20),
                  detailRow(
                    Icons.calendar_today_outlined,
                    'Date',
                    item['date'].toString(),
                  ),
                  detailRow(
                    Icons.access_time_rounded,
                    'Time',
                    item['time'].toString(),
                  ),
                  detailRow(
                    Icons.location_on_outlined,
                    'Location',
                    item['location'].toString(),
                  ),
                  detailRow(
                    Icons.timer_outlined,
                    'Duration',
                    item['duration'].toString(),
                  ),
                  detailRow(
                    Icons.category_outlined,
                    'Type',
                    item['type'].toString(),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Participants',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  participantRow(
                    item['provider'].toString(),
                    'Provider',
                  ),
                  participantRow(
                    item['receiver'].toString(),
                    'Seeker',
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            showReschedule(item);
                          },
                          icon: const Icon(
                            Icons.edit_calendar_outlined,
                          ),
                          label: const Text('Reschedule'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            confirmHandover(item);
                          },
                          icon: const Icon(
                            Icons.check_rounded,
                          ),
                          label: const Text('Confirm'),
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

  Widget detailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF7A8491),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF7A8491),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF18202A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget participantRow(
    String name,
    String role,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xFFE8F0FF),
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(
                color: Color(0xFF3867D6),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF18202A),
              ),
            ),
          ),
          Text(
            role,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  void showReschedule(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        final times = [
          '03:30 PM',
          '04:30 PM',
          '05:30 PM',
          '06:30 PM',
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reschedule exchange',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['title'].toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Suggested time slots',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 10),
                ...times.map(
                  (time) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.schedule_outlined,
                      color: Color(0xFF3867D6),
                    ),
                    title: Text(
                      time,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: const Text(
                      'Good availability',
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Exchange rescheduled to $time.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
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

  void confirmHandover(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item['title']} confirmed successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showCalendarDay(
    String day,
    String date,
    String count,
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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xFF3867D6),
                  size: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  '$day, September $date',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$count exchange(s) scheduled',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('View Schedule'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCreateSchedule() {
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
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              15,
              20,
              MediaQuery.of(sheetContext).viewInsets.bottom + 20,
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
                        color: const Color(0xFFD8DDE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Schedule an exchange',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create a handover slot for your next resource exchange.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Exchange title',
                      prefixIcon: const Icon(
                        Icons.swap_horiz_rounded,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF6F8FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Resource',
                      prefixIcon: const Icon(
                        Icons.inventory_2_outlined,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF6F8FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Date',
                            prefixIcon: const Icon(
                              Icons.calendar_today_outlined,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF6F8FB),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Time',
                            prefixIcon: const Icon(
                              Icons.schedule_outlined,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF6F8FB),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Handover location',
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF6F8FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Exchange scheduled successfully.',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.event_available_rounded,
                      ),
                      label: const Text(
                        'Create Schedule',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showNotifications() {
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
              children: [
                const Text(
                  'Schedule Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 14),
                const ListTile(
                  leading: Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: Text('Upcoming handover'),
                  subtitle: Text(
                    'Textbook Handover starts in 2 hours.',
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.schedule_rounded,
                    color: Color(0xFFB27600),
                  ),
                  title: Text('Confirmation required'),
                  subtitle: Text(
                    'Laptop Accessories exchange is pending.',
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCalendarOptions() {
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
              children: [
                const Text(
                  'Calendar Options',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                  title: const Text('Monthly calendar'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() {
                      selectedTab = 2;
                    });
                  },
                ),
                const ListTile(
                  leading: Icon(
                    Icons.notifications_active_outlined,
                  ),
                  title: Text('Reminder settings'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.sync_rounded,
                  ),
                  title: Text('Sync schedule'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshSchedule() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Exchange schedule updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}