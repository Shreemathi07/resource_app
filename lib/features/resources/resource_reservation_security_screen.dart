import 'package:flutter/material.dart';

class ResourceReservationSecurityScreen extends StatefulWidget {
  const ResourceReservationSecurityScreen({super.key});

  @override
  State<ResourceReservationSecurityScreen> createState() =>
      _ResourceReservationSecurityScreenState();
}

class _ResourceReservationSecurityScreenState
    extends State<ResourceReservationSecurityScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Verification',
    'Security',
    'History',
  ];

  final List<String> filters = [
    'All',
    'Verified',
    'Pending',
    'Attention',
  ];

  final List<Map<String, dynamic>> verificationItems = [
    {
      'title': 'Participant Identity',
      'subtitle': 'Provider and seeker profiles',
      'value': '98%',
      'status': 'Verified',
      'icon': Icons.person_outline_rounded,
      'color': Colors.green,
    },
    {
      'title': 'Resource Identity',
      'subtitle': 'Resource ownership and records',
      'value': '96%',
      'status': 'Verified',
      'icon': Icons.inventory_2_outlined,
      'color': Colors.indigo,
    },
    {
      'title': 'Pickup Location',
      'subtitle': 'Approved exchange locations',
      'value': '94%',
      'status': 'Healthy',
      'icon': Icons.location_on_outlined,
      'color': Colors.teal,
    },
    {
      'title': 'Schedule Integrity',
      'subtitle': 'Reservation time validation',
      'value': '97%',
      'status': 'Verified',
      'icon': Icons.schedule_outlined,
      'color': Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> securityAlerts = [
    {
      'title': 'Unverified pickup location',
      'description':
          'One upcoming reservation has a pickup point that requires confirmation.',
      'priority': 'High',
      'time': '14 min ago',
      'icon': Icons.location_off_outlined,
      'color': Colors.red,
    },
    {
      'title': 'Repeated schedule changes',
      'description':
          'A reservation has been modified multiple times within a short period.',
      'priority': 'Medium',
      'time': '1 hr ago',
      'icon': Icons.event_repeat_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Verification completed',
      'description':
          'A previously pending resource verification was successfully completed.',
      'priority': 'Low',
      'time': '3 hrs ago',
      'icon': Icons.verified_outlined,
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> securityHistory = [
    {
      'action': 'Participant verified',
      'resource': 'Dell Latitude 5420',
      'actor': 'VIT Resource Center',
      'time': 'Today, 11:12 AM',
      'status': 'Verified',
      'icon': Icons.verified_user_outlined,
      'color': Colors.green,
    },
    {
      'action': 'Pickup location confirmed',
      'resource': 'Educational Books',
      'actor': 'Digital Learning Hub',
      'time': 'Today, 9:42 AM',
      'status': 'Confirmed',
      'icon': Icons.location_on_outlined,
      'color': Colors.indigo,
    },
    {
      'action': 'Security review completed',
      'resource': 'Projector with Stand',
      'actor': 'ResourceX System',
      'time': 'Yesterday, 5:18 PM',
      'status': 'Passed',
      'icon': Icons.shield_outlined,
      'color': Colors.teal,
    },
    {
      'action': 'Schedule conflict reviewed',
      'resource': 'Study Table Set',
      'actor': 'Resource Coordinator',
      'time': 'Yesterday, 2:36 PM',
      'status': 'Resolved',
      'icon': Icons.calendar_month_outlined,
      'color': Colors.orange,
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    return securityHistory.where((item) {
      final matchesFilter = selectedFilter == 'All' ||
          (selectedFilter == 'Verified' &&
              (item['status'] == 'Verified' || item['status'] == 'Passed')) ||
          (selectedFilter == 'Pending' && item['status'] == 'Pending') ||
          (selectedFilter == 'Attention' && item['status'] == 'Attention');

      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          item['action'].toString().toLowerCase().contains(query) ||
          item['resource'].toString().toLowerCase().contains(query) ||
          item['actor'].toString().toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
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
          'Reservation Security',
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
                _buildSecurityStats(),
                const SizedBox(height: 18),
                _buildSearch(),
                const SizedBox(height: 12),
                _buildFilters(),
                const SizedBox(height: 16),
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
            Colors.deepPurple.shade600,
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
                  Icons.lock_outline_rounded,
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
                  'Protected',
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
            'Reservation Security Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Verify participants, resources, schedules and pickup locations before every reservation exchange.',
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
                '96%',
                'Security',
              ),
              _heroMetric(
                '98%',
                'Verified',
              ),
              _heroMetric(
                '0',
                'Critical',
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
              fontSize: 20,
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

  Widget _buildSecurityStats() {
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
            '96%',
            'Security',
            Icons.shield_outlined,
            Colors.indigo,
          ),
          _statItem(
            '248',
            'Verified',
            Icons.verified_outlined,
            Colors.green,
          ),
          _statItem(
            '7',
            'Reviews',
            Icons.fact_check_outlined,
            Colors.orange,
          ),
          _statItem(
            '2',
            'Alerts',
            Icons.warning_amber_outlined,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _statItem(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 18,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 7,
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
        hintText: 'Search security record or resource',
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
      height: 39,
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
        return _buildVerification();
      case 2:
        return _buildSecurity();
      case 3:
        return _buildHistory();
      default:
        return _buildOverview();
    }
  }

  Widget _buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Security Health',
          'Current reservation protection status',
          Icons.shield_outlined,
        ),
        const SizedBox(height: 14),
        _buildSecurityHealthCard(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Security Signals',
          'Live protection indicators',
          Icons.radar_outlined,
        ),
        const SizedBox(height: 12),
        _signalCard(
          'Participant verification',
          'Active reservation participants have verified profiles.',
          0.98,
          Colors.green,
          Icons.person_search_outlined,
        ),
        _signalCard(
          'Resource verification',
          'Resources are matched against their verification records.',
          0.96,
          Colors.indigo,
          Icons.inventory_2_outlined,
        ),
        _signalCard(
          'Location security',
          'Most reservations use approved pickup locations.',
          0.94,
          Colors.teal,
          Icons.location_on_outlined,
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Needs Attention',
          'Security events requiring review',
          Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 12),
        ...securityAlerts.take(2).map(_buildAlertCard),
      ],
    );
  }

  Widget _buildSecurityHealthCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 92,
                    height: 92,
                    child: CircularProgressIndicator(
                      value: 0.96,
                      strokeWidth: 9,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.indigo,
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '96',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Score',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strong Security',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Most reservation security checks are complete. A few upcoming records need additional attention.',
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
          const SizedBox(height: 18),
          Row(
            children: [
              _healthMetric(
                '98%',
                'Identity',
                Colors.green,
              ),
              _healthMetric(
                '96%',
                'Resources',
                Colors.indigo,
              ),
              _healthMetric(
                '94%',
                'Locations',
                Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthMetric(
    String value,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Verification Center',
          'Reservation security verification checks',
          Icons.verified_user_outlined,
        ),
        const SizedBox(height: 14),
        ...verificationItems.map(_buildVerificationCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Pre-Reservation Checklist',
          'Complete these checks before confirmation',
          Icons.checklist_outlined,
        ),
        const SizedBox(height: 12),
        _checkItem(
          'Provider profile is verified',
          true,
        ),
        _checkItem(
          'Seeker profile is verified',
          true,
        ),
        _checkItem(
          'Resource record is complete',
          true,
        ),
        _checkItem(
          'Resource is currently available',
          true,
        ),
        _checkItem(
          'Pickup location is approved',
          true,
        ),
        _checkItem(
          'Reservation time does not conflict',
          false,
        ),
        const SizedBox(height: 18),
        _buildVerificationAction(),
      ],
    );
  }

  Widget _buildVerificationCard(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;
    final percentage =
        int.parse(item['value'].toString().replaceAll('%', '')) / 100;

    return GestureDetector(
      onTap: () => _showVerificationDetails(item),
      child: Container(
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
                    item['title'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 11),
            Column(
              children: [
                Text(
                  item['value'].toString(),
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['status'].toString(),
                  style: TextStyle(
                    color: color,
                    fontSize: 7,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkItem(
    String title,
    bool completed,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: completed ? Colors.green : Colors.orange,
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: completed
                    ? Colors.grey.shade800
                    : Colors.orange.shade800,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (!completed)
            TextButton(
              onPressed: () {
                _showSnackBar(
                  'Verification check opened',
                );
              },
              child: const Text(
                'Review',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVerificationAction() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.fingerprint_rounded,
            color: Colors.indigo,
            size: 27,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Run Security Verification',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Run all available checks for an upcoming reservation.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showSnackBar(
                'Security verification started',
              );
            },
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Security Monitoring',
          'Automated reservation protection',
          Icons.security_outlined,
        ),
        const SizedBox(height: 14),
        _buildSecurityMonitor(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Security Alerts',
          'Potential risks detected by the system',
          Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 12),
        ...securityAlerts.map(_buildAlertCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Smart Protection',
          'Intelligent security recommendations',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _recommendationCard(
          'Confirm pickup locations early',
          'Reservations with new pickup locations should be confirmed before the exchange date.',
          Icons.location_on_outlined,
          Colors.indigo,
        ),
        _recommendationCard(
          'Review repeated changes',
          'Multiple schedule changes can indicate coordination issues and should be reviewed.',
          Icons.event_repeat_outlined,
          Colors.orange,
        ),
        _recommendationCard(
          'Keep verification records current',
          'Regular verification improves trust and reduces reservation conflicts.',
          Icons.verified_outlined,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildSecurityMonitor() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.monitor_heart_outlined,
                color: Colors.indigo,
                size: 24,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Live Security Monitoring',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              _statusBadge(
                'ACTIVE',
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 17),
          _monitorRow(
            'Identity checks',
            '248 / 252',
            0.98,
            Colors.green,
          ),
          _monitorRow(
            'Resource checks',
            '241 / 252',
            0.96,
            Colors.indigo,
          ),
          _monitorRow(
            'Schedule checks',
            '244 / 252',
            0.97,
            Colors.orange,
          ),
          _monitorRow(
            'Location checks',
            '237 / 252',
            0.94,
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _monitorRow(
    String title,
    String value,
    double progress,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                value,
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
              value: progress,
              minHeight: 6,
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

  Widget _recommendationCard(
    String title,
    String description,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
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

  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Security History',
          '${filteredHistory.length} security records',
          Icons.history_rounded,
        ),
        const SizedBox(height: 14),
        if (filteredHistory.isEmpty)
          _buildEmptyState()
        else
          ...filteredHistory.map(_buildHistoryCard),
        const SizedBox(height: 18),
        _buildSecurityReportCard(),
      ],
    );
  }

  Widget _buildHistoryCard(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;

    return GestureDetector(
      onTap: () => _showHistoryDetails(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
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
                item['icon'] as IconData,
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
                    item['action'].toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['resource'].toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${item['actor']} • ${item['time']}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
            _statusBadge(
              item['status'].toString(),
              color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityReportCard() {
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
              Icons.description_outlined,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security Verification Report',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Generate a summary of reservation verification and security activity.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showReportOptions,
            icon: const Icon(
              Icons.chevron_right_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(
    Map<String, dynamic> alert,
  ) {
    final color = alert['color'] as Color;

    return GestureDetector(
      onTap: () => _showAlertDetails(alert),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
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
                alert['icon'] as IconData,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert['title'].toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      _statusBadge(
                        alert['priority'].toString(),
                        color,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    alert['description'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    alert['time'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 8,
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
          fontSize: 7,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _signalCard(
    String title,
    String description,
    double progress,
    Color color,
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
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      color,
                    ),
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
            Icons.search_off_rounded,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          const Text(
            'No security records found',
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

  void _showVerificationDetails(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;

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
              _sheetHandle(),
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
                      item['title'].toString(),
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                item['subtitle'].toString(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.analytics_outlined,
                'Verification score',
                item['value'].toString(),
              ),
              _detailRow(
                Icons.verified_outlined,
                'Current status',
                item['status'].toString(),
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar(
                    '${item['title']} verification started',
                  );
                },
                icon: const Icon(
                  Icons.fact_check_outlined,
                ),
                label: const Text(
                  'Run Verification',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHistoryDetails(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;

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
              _sheetHandle(),
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
                      item['action'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.inventory_2_outlined,
                'Resource',
                item['resource'].toString(),
              ),
              _detailRow(
                Icons.person_outline,
                'Actor',
                item['actor'].toString(),
              ),
              _detailRow(
                Icons.schedule_outlined,
                'Time',
                item['time'].toString(),
              ),
              _detailRow(
                Icons.verified_outlined,
                'Status',
                item['status'].toString(),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.green,
                      size: 18,
                    ),
                    SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'This security event is stored as part of the reservation verification history.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 9,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar(
                    'Security record marked for review',
                  );
                },
                child: const Text(
                  'Mark for Review',
                ),
              ),
            ],
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

  void _showAlertDetails(
    Map<String, dynamic> alert,
  ) {
    final color = alert['color'] as Color;

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
              _sheetHandle(),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: color.withValues(alpha: 0.10),
                    child: Icon(
                      alert['icon'] as IconData,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      alert['title'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              Text(
                alert['description'].toString(),
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 11,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              _detailRow(
                Icons.flag_outlined,
                'Priority',
                alert['priority'].toString(),
              ),
              _detailRow(
                Icons.schedule_outlined,
                'Detected',
                alert['time'].toString(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Alert dismissed',
                        );
                      },
                      child: const Text(
                        'Dismiss',
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Security review started',
                        );
                      },
                      child: const Text(
                        'Review',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetHandle() {
    return Center(
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showReportOptions() {
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
              _sheetHandle(),
              const SizedBox(height: 18),
              const Text(
                'Security Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 15),
              _reportOption(
                sheetContext,
                Icons.picture_as_pdf_outlined,
                'PDF Security Report',
                'Generate a formatted security summary.',
                Colors.red,
              ),
              _reportOption(
                sheetContext,
                Icons.table_chart_outlined,
                'CSV Verification Data',
                'Export verification records for analysis.',
                Colors.green,
              ),
              _reportOption(
                sheetContext,
                Icons.share_outlined,
                'Share Security Summary',
                'Share key security indicators.',
                Colors.indigo,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _reportOption(
    BuildContext sheetContext,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(sheetContext);
        _showSnackBar(
          '$title selected',
        );
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
                  'Security Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.location_off_outlined,
                  'Pickup location requires verification',
                  '14 minutes ago',
                  Colors.red,
                ),
                _notificationItem(
                  Icons.verified_outlined,
                  'Resource verification completed',
                  '1 hour ago',
                  Colors.green,
                ),
                _notificationItem(
                  Icons.shield_outlined,
                  'Security score updated',
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
      'Reservation security refreshed',
    );
  }
}