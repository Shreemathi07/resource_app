import 'package:flutter/material.dart';

class RequirementDeliveryCoordinationScreen extends StatefulWidget {
  const RequirementDeliveryCoordinationScreen({super.key});

  @override
  State<RequirementDeliveryCoordinationScreen> createState() =>
      _RequirementDeliveryCoordinationScreenState();
}

class _RequirementDeliveryCoordinationScreenState
    extends State<RequirementDeliveryCoordinationScreen> {
  int selectedTab = 0;
  String selectedDelivery = 'Laptop Support – VIT Campus';
  String selectedMode = 'All';

  final List<Map<String, dynamic>> deliveries = [
    {
      'title': 'Laptop Support – VIT Campus',
      'category': 'Electronics',
      'status': 'Ready',
      'progress': 0.86,
      'quantity': '43 / 50',
      'date': '18 Sep 2026',
      'time': '10:30 AM',
      'location': 'VIT Main Gate',
      'provider': 'VIT Tech Community',
      'seeker': 'Student Support Team',
      'mode': 'Vehicle',
      'color': Colors.indigo,
    },
    {
      'title': 'Community Meal Support',
      'category': 'Food',
      'status': 'Preparing',
      'progress': 0.64,
      'quantity': '320 / 500',
      'date': '12 Sep 2026',
      'time': '1:00 PM',
      'location': 'Katpadi Community Hall',
      'provider': 'Community Kitchen',
      'seeker': 'Local Support Group',
      'mode': 'Vehicle',
      'color': Colors.orange,
    },
    {
      'title': 'Study Material Distribution',
      'category': 'Education',
      'status': 'Scheduled',
      'progress': 0.94,
      'quantity': '188 / 200',
      'date': '10 Sep 2026',
      'time': '3:30 PM',
      'location': 'Vellore Learning Hub',
      'provider': 'Learning Circle',
      'seeker': 'Student Network',
      'mode': 'Walk',
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> coordinationTasks = [
    {
      'title': 'Confirm pickup location',
      'owner': 'Provider',
      'priority': 'High',
      'done': true,
    },
    {
      'title': 'Confirm receiver availability',
      'owner': 'Seeker',
      'priority': 'High',
      'done': true,
    },
    {
      'title': 'Prepare resources for transport',
      'owner': 'Provider',
      'priority': 'Medium',
      'done': false,
    },
    {
      'title': 'Share delivery instructions',
      'owner': 'Coordinator',
      'priority': 'Medium',
      'done': false,
    },
    {
      'title': 'Confirm final handover slot',
      'owner': 'Both Parties',
      'priority': 'Low',
      'done': false,
    },
  ];

  final List<Map<String, dynamic>> timeline = [
    {
      'title': 'Delivery slot reserved',
      'subtitle': 'VIT Main Gate selected as the handover point',
      'time': '18 min ago',
      'icon': Icons.event_available_rounded,
    },
    {
      'title': 'Receiver confirmed',
      'subtitle': 'Student Support Team confirmed availability',
      'time': '42 min ago',
      'icon': Icons.person_pin_circle_outlined,
    },
    {
      'title': 'Pickup preparation started',
      'subtitle': 'Provider began preparing 43 verified resources',
      'time': '1 hr ago',
      'icon': Icons.inventory_2_outlined,
    },
    {
      'title': 'Route recommendation created',
      'subtitle': 'Smart logistics selected the fastest route',
      'time': '2 hrs ago',
      'icon': Icons.route_rounded,
    },
  ];

  final List<Map<String, dynamic>> reminders = [
    {
      'title': 'Pickup reminder',
      'subtitle': 'Confirm the pickup 2 hours before departure.',
      'icon': Icons.alarm_rounded,
    },
    {
      'title': 'Receiver reminder',
      'subtitle': 'Notify the receiver when the provider starts moving.',
      'icon': Icons.notifications_active_outlined,
    },
    {
      'title': 'Handover reminder',
      'subtitle': 'Keep the digital receipt ready before handover.',
      'icon': Icons.receipt_long_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Delivery Coordination',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF172033),
            ),
          ),
          IconButton(
            onPressed: _showInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF172033),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
            children: [
              _buildHero(),
              const SizedBox(height: 18),
              _buildDeliverySelector(),
              const SizedBox(height: 18),
              _buildTabs(),
              const SizedBox(height: 18),
              if (selectedTab == 0) ...[
                _buildCoordinationOverview(),
                const SizedBox(height: 18),
                _buildDeliveryStatus(),
                const SizedBox(height: 18),
                _buildPickupReceiver(),
                const SizedBox(height: 18),
                _buildSmartLogistics(),
                const SizedBox(height: 18),
                _buildReminderPreview(),
              ],
              if (selectedTab == 1) ...[
                _buildTaskSection(),
                const SizedBox(height: 18),
                _buildPreparationChecklist(),
                const SizedBox(height: 18),
                _buildDeliveryInstructions(),
              ],
              if (selectedTab == 2) ...[
                _buildTimeline(),
                const SizedBox(height: 18),
                _buildCoordinationHistory(),
              ],
              if (selectedTab == 3) ...[
                _buildDeliveryPerformance(),
                const SizedBox(height: 18),
                _buildCoordinationInsights(),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showScheduleDelivery,
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.local_shipping_outlined),
        label: const Text('Schedule Delivery'),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF312E81),
            Color(0xFF4F46E5),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.20),
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
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.local_shipping_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              _heroPill('On Schedule'),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Smart Delivery Coordination',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coordinate pickup, transport, receiver readiness and final handover from one place.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('43', 'Ready'),
              _heroDivider(),
              _heroMetric('10:30', 'Pickup'),
              _heroDivider(),
              _heroMetric('4.8', 'Reliability'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.68),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroDivider() {
    return Container(
      width: 1,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white.withValues(alpha: 0.16),
    );
  }

  Widget _heroPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildDeliverySelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              color: Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Active delivery',
                  style: TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedDelivery,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showDeliverySelector,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = [
      'Overview',
      'Preparation',
      'Activity',
      'Performance',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(tabs[index]),
              selected: selectedTab == index,
              onSelected: (_) {
                setState(() {
                  selectedTab = index;
                });
              },
              selectedColor: const Color(0xFF4F46E5),
              backgroundColor: Colors.white,
              side: BorderSide.none,
              labelStyle: TextStyle(
                color: selectedTab == index
                    ? Colors.white
                    : const Color(0xFF596273),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoordinationOverview() {
    return _sectionCard(
      title: 'Coordination Overview',
      icon: Icons.dashboard_customize_outlined,
      child: Column(
        children: [
          Row(
            children: [
              _overviewBox(
                '86%',
                'Delivery Ready',
                Icons.task_alt_rounded,
              ),
              const SizedBox(width: 10),
              _overviewBox(
                '2',
                'People Confirmed',
                Icons.people_outline_rounded,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _overviewBox(
                '6.2 km',
                'Route Distance',
                Icons.route_outlined,
              ),
              const SizedBox(width: 10),
              _overviewBox(
                '24 min',
                'Estimated Time',
                Icons.timer_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewBox(
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE8EAF0)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 21,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF7B8496),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryStatus() {
    return _sectionCard(
      title: 'Delivery Status',
      icon: Icons.track_changes_rounded,
      child: Column(
        children: [
          Row(
            children: [
              _statusStep(
                'Prepared',
                true,
                Icons.inventory_2_outlined,
              ),
              _statusLine(true),
              _statusStep(
                'Pickup',
                true,
                Icons.location_on_outlined,
              ),
              _statusLine(false),
              _statusStep(
                'Transit',
                false,
                Icons.directions_car_outlined,
              ),
              _statusLine(false),
              _statusStep(
                'Handover',
                false,
                Icons.handshake_outlined,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.86,
              minHeight: 8,
              backgroundColor: Color(0xFFE9EBF2),
              valueColor: AlwaysStoppedAnimation(
                Color(0xFF4F46E5),
              ),
            ),
          ),
          const SizedBox(height: 9),
          const Row(
            children: [
              Text(
                '86% ready for delivery',
                style: TextStyle(
                  color: Color(0xFF4F46E5),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(),
              Text(
                'Next: Transit',
                style: TextStyle(
                  color: Color(0xFF7B8496),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusStep(
    String title,
    bool active,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFF1F3F7),
            ),
            child: Icon(
              icon,
              size: 19,
              color: active
                  ? const Color(0xFF16A34A)
                  : const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active
                  ? const Color(0xFF172033)
                  : const Color(0xFF8A92A1),
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusLine(bool active) {
    return Container(
      width: 18,
      height: 2,
      margin: const EdgeInsets.only(bottom: 22),
      color: active
          ? const Color(0xFF86EFAC)
          : const Color(0xFFE5E7EB),
    );
  }

  Widget _buildPickupReceiver() {
    return _sectionCard(
      title: 'Pickup & Receiver',
      icon: Icons.people_alt_outlined,
      child: Column(
        children: [
          _personCard(
            'Provider',
            'VIT Tech Community',
            'Pickup: VIT Resource Center',
            Icons.business_center_outlined,
            const Color(0xFF4F46E5),
          ),
          const SizedBox(height: 10),
          _personCard(
            'Receiver',
            'Student Support Team',
            'Handover: VIT Main Gate',
            Icons.person_outline_rounded,
            const Color(0xFF16A34A),
          ),
        ],
      ),
    );
  }

  Widget _personCard(
    String role,
    String name,
    String location,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: iconColor.withValues(alpha: 0.10),
            child: Icon(
              icon,
              color: iconColor,
              size: 21,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showMessage('$role details opened'),
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartLogistics() {
    return _sectionCard(
      title: 'Smart Logistics Recommendation',
      icon: Icons.auto_awesome_rounded,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF5F3FF),
              Color(0xFFEEF2FF),
            ],
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons.route_rounded,
                    color: Color(0xFF4F46E5),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Recommended delivery route',
                    style: TextStyle(
                      color: Color(0xFF312E81),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                _smallBadge('Fastest'),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Use the north campus route to reduce estimated travel time by 8 minutes.',
              style: TextStyle(
                color: Color(0xFF625F78),
                fontSize: 11,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                _routeMetric('6.2 km', 'Distance'),
                _routeMetric('24 min', 'ETA'),
                _routeMetric('3', 'Stops'),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showRoute,
                icon: const Icon(Icons.map_outlined),
                label: const Text('View Route'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _routeMetric(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7B8496),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Fastest',
        style: TextStyle(
          color: Color(0xFF15803D),
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildReminderPreview() {
    return _sectionCard(
      title: 'Upcoming Reminders',
      icon: Icons.notifications_active_outlined,
      child: Column(
        children: reminders.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFF4F46E5),
                    size: 19,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF172033),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTaskSection() {
    final filteredTasks = selectedMode == 'All'
        ? coordinationTasks
        : coordinationTasks
            .where(
              (task) => task['priority'] == selectedMode,
            )
            .toList();

    return _sectionCard(
      title: 'Coordination Tasks',
      icon: Icons.checklist_rounded,
      action: PopupMenuButton<String>(
        onSelected: (value) {
          setState(() {
            selectedMode = value;
          });
        },
        itemBuilder: (_) => const [
          PopupMenuItem(
            value: 'All',
            child: Text('All Tasks'),
          ),
          PopupMenuItem(
            value: 'High',
            child: Text('High Priority'),
          ),
          PopupMenuItem(
            value: 'Medium',
            child: Text('Medium Priority'),
          ),
          PopupMenuItem(
            value: 'Low',
            child: Text('Low Priority'),
          ),
        ],
        child: const Icon(Icons.filter_list_rounded),
      ),
      child: Column(
        children: filteredTasks.map((task) {
          final done = task['done'] as bool;
          final priority = task['priority'] as String;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFE8EAF0),
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: done,
                  activeColor: const Color(0xFF4F46E5),
                  onChanged: (_) {
                    setState(() {
                      task['done'] = !done;
                    });
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['title'] as String,
                        style: TextStyle(
                          color: const Color(0xFF172033),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          decoration:
                              done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task['owner'] as String,
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                _priorityBadge(priority),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _priorityBadge(String priority) {
    Color textColor;
    Color background;

    if (priority == 'High') {
      textColor = const Color(0xFFB91C1C);
      background = const Color(0xFFFEE2E2);
    } else if (priority == 'Medium') {
      textColor = const Color(0xFFB45309);
      background = const Color(0xFFFEF3C7);
    } else {
      textColor = const Color(0xFF475569);
      background = const Color(0xFFF1F5F9);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildPreparationChecklist() {
    return _sectionCard(
      title: 'Delivery Readiness Checklist',
      icon: Icons.fact_check_outlined,
      child: Column(
        children: [
          _checkItem('Resources packed safely', true),
          _checkItem('Quantity verified', true),
          _checkItem('Pickup point confirmed', true),
          _checkItem('Transport arranged', false),
          _checkItem('Receiver notified', true),
          _checkItem('Digital receipt prepared', false),
          _checkItem('Handover instructions shared', false),
        ],
      ),
    );
  }

  Widget _checkItem(String title, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            done
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: done
                ? const Color(0xFF16A34A)
                : const Color(0xFFB8BFCC),
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: done
                    ? const Color(0xFF596273)
                    : const Color(0xFF172033),
                fontSize: 12,
                fontWeight: done ? FontWeight.w500 : FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInstructions() {
    return _sectionCard(
      title: 'Delivery Instructions',
      icon: Icons.description_outlined,
      child: Column(
        children: [
          _instructionRow(
            'Pickup point',
            'VIT Resource Center',
            Icons.location_on_outlined,
          ),
          _instructionRow(
            'Handover point',
            'VIT Main Gate',
            Icons.flag_outlined,
          ),
          _instructionRow(
            'Preferred transport',
            'Campus vehicle',
            Icons.directions_car_outlined,
          ),
          _instructionRow(
            'Contact method',
            'In-app messaging',
            Icons.chat_bubble_outline_rounded,
          ),
          _instructionRow(
            'Handover proof',
            'Digital receipt',
            Icons.receipt_long_outlined,
          ),
        ],
      ),
    );
  }

  Widget _instructionRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF4F46E5),
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF7B8496),
                fontSize: 10,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return _sectionCard(
      title: 'Coordination Activity',
      icon: Icons.timeline_rounded,
      child: Column(
        children: timeline.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFF4F46E5),
                    size: 19,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF172033),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 10,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['time'] as String,
                        style: const TextStyle(
                          color: Color(0xFFA0A7B4),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCoordinationHistory() {
    return _sectionCard(
      title: 'Delivery History',
      icon: Icons.history_rounded,
      child: Column(
        children: [
          _historyRow(
            'Delivery scheduled',
            '08 Sep 2026',
            'Confirmed',
          ),
          _historyRow(
            'Resources verified',
            '08 Sep 2026',
            'Completed',
          ),
          _historyRow(
            'Pickup location confirmed',
            '07 Sep 2026',
            'Completed',
          ),
          _historyRow(
            'Receiver availability confirmed',
            '07 Sep 2026',
            'Completed',
          ),
        ],
      ),
    );
  }

  Widget _historyRow(
    String title,
    String date,
    String status,
  ) {
    final completed = status == 'Completed' || status == 'Confirmed';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.timelapse_rounded,
            color: completed
                ? const Color(0xFF16A34A)
                : const Color(0xFFF59E0B),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: Color(0xFF7B8496),
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                status,
                style: TextStyle(
                  color: completed
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFF59E0B),
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPerformance() {
    return _sectionCard(
      title: 'Delivery Performance',
      icon: Icons.insights_rounded,
      child: Column(
        children: [
          Row(
            children: [
              _performanceBox('94%', 'On-Time'),
              const SizedBox(width: 10),
              _performanceBox('4.8/5', 'Reliability'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _performanceBox('24 min', 'Avg Transit'),
              const SizedBox(width: 10),
              _performanceBox('97%', 'Handover Rate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _performanceBox(
    String value,
    String label,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE8EAF0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF4F46E5),
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF7B8496),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoordinationInsights() {
    return _sectionCard(
      title: 'Smart Coordination Insights',
      icon: Icons.psychology_alt_outlined,
      child: Column(
        children: [
          _insight(
            Icons.check_circle_outline_rounded,
            'Delivery is ready',
            'Most preparation tasks are complete and the pickup slot is confirmed.',
          ),
          _insight(
            Icons.schedule_rounded,
            'Transit window looks efficient',
            'The recommended route keeps estimated travel below 30 minutes.',
          ),
          _insight(
            Icons.warning_amber_rounded,
            'Transport confirmation pending',
            'Assign the campus vehicle before the pickup window begins.',
          ),
          _insight(
            Icons.notifications_active_outlined,
            'Receiver reminders enabled',
            'Automatic reminders can reduce missed handover attempts.',
          ),
        ],
      ),
    );
  }

  Widget _insight(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF4F46E5),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF312E81),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF625F78),
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

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    Widget? action,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF4F46E5),
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ? action,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.035),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  void _showDeliverySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Delivery',
                  style: TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ...deliveries.map(
                  (delivery) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEEF2FF),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: delivery['color'] as Color,
                      ),
                    ),
                    title: Text(
                      delivery['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${delivery['date']} • ${delivery['time']}',
                    ),
                    trailing: selectedDelivery == delivery['title']
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF4F46E5),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        selectedDelivery = delivery['title'] as String;
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

  void _showScheduleDelivery() {
    final locationController = TextEditingController();
    final notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Schedule Delivery',
                  style: TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Set a pickup and handover window for the requirement.',
                  style: TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Handover location',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'Vehicle',
                  decoration: InputDecoration(
                    labelText: 'Transport mode',
                    prefixIcon: const Icon(
                      Icons.directions_car_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Walk',
                      child: Text('Walk'),
                    ),
                    DropdownMenuItem(
                      value: 'Cycle',
                      child: Text('Cycle'),
                    ),
                    DropdownMenuItem(
                      value: 'Vehicle',
                      child: Text('Vehicle'),
                    ),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Delivery notes',
                    prefixIcon: const Icon(
                      Icons.notes_outlined,
                    ),
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
                      _showMessage('Delivery schedule created');
                    },
                    icon: const Icon(
                      Icons.event_available_rounded,
                    ),
                    label: const Text('Confirm Schedule'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRoute() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recommended Route',
                  style: TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                _routeDetail(
                  Icons.location_on_outlined,
                  'VIT Resource Center',
                  'Pickup',
                ),
                _routeDetail(
                  Icons.route_outlined,
                  'North Campus Road',
                  'Recommended route',
                ),
                _routeDetail(
                  Icons.flag_outlined,
                  'VIT Main Gate',
                  'Handover',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _routeMetric('6.2 km', 'Distance'),
                    _routeMetric('24 min', 'ETA'),
                    _routeMetric('8 min', 'Saved'),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _showMessage('Navigation route selected');
                    },
                    icon: const Icon(Icons.navigation_rounded),
                    label: const Text('Use This Route'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _routeDetail(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor: const Color(0xFFEEF2FF),
            child: Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 18,
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
                    color: Color(0xFF172033),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.indigo,
                  ),
                  title: Text('Delivery slot confirmed'),
                  subtitle: Text('Pickup is scheduled for 10:30 AM'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.green,
                  ),
                  title: Text('Receiver confirmed'),
                  subtitle: Text('Student Support Team is available'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  title: Text('Transport pending'),
                  subtitle: Text('Assign a vehicle before pickup'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delivery Coordination'),
          content: const Text(
            'Coordinate pickup, transport, receiver readiness, delivery instructions and handover preparation for confirmed ResourceX requirements.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        );
      },
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

  Future<void> _refresh() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    _showMessage('Delivery coordination refreshed');
  }
}