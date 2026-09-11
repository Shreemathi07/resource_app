import 'package:flutter/material.dart';

class ResourceReservationAuditScreen extends StatefulWidget {
  const ResourceReservationAuditScreen({super.key});

  @override
  State<ResourceReservationAuditScreen> createState() =>
      _ResourceReservationAuditScreenState();
}

class _ResourceReservationAuditScreenState
    extends State<ResourceReservationAuditScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Audit Trail',
    'Compliance',
    'Alerts',
  ];

  final List<String> filters = [
    'All',
    'Reservations',
    'Approvals',
    'Changes',
    'Issues',
  ];

  final List<Map<String, dynamic>> auditRecords = [
    {
      'action': 'Reservation Approved',
      'resource': 'Dell Latitude 5420',
      'actor': 'VIT Resource Center',
      'type': 'Approvals',
      'time': 'Today, 10:42 AM',
      'reference': 'RSV-2048',
      'status': 'Verified',
      'icon': Icons.check_circle_outline,
      'color': Colors.green,
    },
    {
      'action': 'Reservation Created',
      'resource': 'Educational Books',
      'actor': 'Digital Learning Hub',
      'type': 'Reservations',
      'time': 'Today, 9:18 AM',
      'reference': 'RSV-2047',
      'status': 'Verified',
      'icon': Icons.add_circle_outline,
      'color': Colors.indigo,
    },
    {
      'action': 'Pickup Time Changed',
      'resource': 'Projector with Stand',
      'actor': 'Innovation Cell',
      'type': 'Changes',
      'time': 'Yesterday, 4:32 PM',
      'reference': 'RSV-2041',
      'status': 'Reviewed',
      'icon': Icons.edit_calendar_outlined,
      'color': Colors.orange,
    },
    {
      'action': 'Reservation Conflict Detected',
      'resource': 'Study Table Set',
      'actor': 'ResourceX System',
      'type': 'Issues',
      'time': 'Yesterday, 1:26 PM',
      'reference': 'RSV-2037',
      'status': 'Resolved',
      'icon': Icons.warning_amber_outlined,
      'color': Colors.red,
    },
    {
      'action': 'Reservation Completed',
      'resource': 'Sports Equipment',
      'actor': 'VIT Sports Club',
      'type': 'Reservations',
      'time': 'Sep 5, 2026, 6:15 PM',
      'reference': 'RSV-2029',
      'status': 'Verified',
      'icon': Icons.task_alt_outlined,
      'color': Colors.teal,
    },
    {
      'action': 'Approval Rejected',
      'resource': 'HP ProBook 440',
      'actor': 'Digital Skills Lab',
      'type': 'Approvals',
      'time': 'Sep 5, 2026, 2:08 PM',
      'reference': 'RSV-2025',
      'status': 'Reviewed',
      'icon': Icons.block_outlined,
      'color': Colors.deepPurple,
    },
  ];

  final List<Map<String, dynamic>> complianceItems = [
    {
      'title': 'Identity Verification',
      'description': 'Reservation participants have verified profiles.',
      'value': '98%',
      'status': 'Compliant',
      'icon': Icons.verified_user_outlined,
      'color': Colors.green,
    },
    {
      'title': 'Resource Verification',
      'description': 'Reserved resources have valid verification records.',
      'value': '95%',
      'status': 'Compliant',
      'icon': Icons.inventory_2_outlined,
      'color': Colors.indigo,
    },
    {
      'title': 'Schedule Compliance',
      'description': 'Reservations follow approved time windows.',
      'value': '93%',
      'status': 'Healthy',
      'icon': Icons.schedule_outlined,
      'color': Colors.teal,
    },
    {
      'title': 'Handover Verification',
      'description': 'Completed reservations include handover confirmation.',
      'value': '91%',
      'status': 'Healthy',
      'icon': Icons.handshake_outlined,
      'color': Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> alerts = [
    {
      'title': 'Multiple schedule changes',
      'description':
          'Three reservations were rescheduled more than once this week.',
      'priority': 'Medium',
      'time': '18 min ago',
      'icon': Icons.event_repeat_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Unverified resource record',
      'description':
          'One resource requires verification before the next reservation.',
      'priority': 'High',
      'time': '42 min ago',
      'icon': Icons.gpp_maybe_outlined,
      'color': Colors.red,
    },
    {
      'title': 'Repeated cancellation pattern',
      'description':
          'A reservation pattern shows repeated cancellations during peak hours.',
      'priority': 'Low',
      'time': '2 hrs ago',
      'icon': Icons.analytics_outlined,
      'color': Colors.indigo,
    },
  ];

  List<Map<String, dynamic>> get filteredRecords {
    return auditRecords.where((record) {
      final matchesFilter =
          selectedFilter == 'All' || record['type'] == selectedFilter;

      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          record['action'].toString().toLowerCase().contains(query) ||
          record['resource'].toString().toLowerCase().contains(query) ||
          record['actor'].toString().toLowerCase().contains(query) ||
          record['reference'].toString().toLowerCase().contains(query);

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
          'Reservation Audit',
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
                _buildAuditStats(),
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
                  Icons.security_outlined,
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
                  'Secure Records',
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
            'Reservation Audit Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track reservation actions, verify compliance and identify unusual activity across the ResourceX network.',
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
                '98%',
                'Compliance',
              ),
              _heroMetric(
                '1,284',
                'Audit events',
              ),
              _heroMetric(
                '99.2%',
                'Verified',
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

  Widget _buildAuditStats() {
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
            '1,284',
            'Audit events',
            Icons.history_rounded,
            Colors.indigo,
          ),
          _statItem(
            '14',
            'Alerts',
            Icons.warning_amber_outlined,
            Colors.orange,
          ),
          _statItem(
            '98%',
            'Compliant',
            Icons.verified_outlined,
            Colors.green,
          ),
          _statItem(
            '3',
            'Open issues',
            Icons.report_problem_outlined,
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
        hintText: 'Search audit event, resource or reference',
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
        return _buildAuditTrail();
      case 2:
        return _buildCompliance();
      case 3:
        return _buildAlerts();
      default:
        return _buildOverview();
    }
  }

  Widget _buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Audit Health',
          'Current reservation security status',
          Icons.shield_outlined,
        ),
        const SizedBox(height: 14),
        _buildHealthCard(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Recent Activity',
          'Latest reservation events',
          Icons.history_rounded,
        ),
        const SizedBox(height: 12),
        ...auditRecords.take(4).map(_buildAuditCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Security Signals',
          'Automated audit monitoring',
          Icons.radar_outlined,
        ),
        const SizedBox(height: 12),
        _signalCard(
          'Identity verification',
          'All active reservation participants are verified.',
          0.98,
          Colors.green,
          Icons.verified_user_outlined,
        ),
        _signalCard(
          'Schedule integrity',
          'Reservation schedules are within approved limits.',
          0.93,
          Colors.indigo,
          Icons.calendar_month_outlined,
        ),
        _signalCard(
          'Resource compliance',
          'Most resources have complete verification records.',
          0.95,
          Colors.teal,
          Icons.inventory_2_outlined,
        ),
      ],
    );
  }

  Widget _buildHealthCard() {
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
                    width: 90,
                    height: 90,
                    child: CircularProgressIndicator(
                      value: 0.98,
                      strokeWidth: 9,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '98',
                        style: TextStyle(
                          color: Colors.green,
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
                      'Excellent Audit Health',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Reservation activity is highly compliant with no critical unresolved violations.',
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
          const SizedBox(height: 17),
          Row(
            children: [
              _healthMetric(
                '99.2%',
                'Verified',
                Colors.green,
              ),
              _healthMetric(
                '97%',
                'Traceable',
                Colors.indigo,
              ),
              _healthMetric(
                '94%',
                'Reviewed',
                Colors.orange,
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

  Widget _buildAuditTrail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Complete Audit Trail',
          '${filteredRecords.length} matching events',
          Icons.manage_search_rounded,
        ),
        const SizedBox(height: 14),
        if (filteredRecords.isEmpty)
          _buildEmptyState()
        else
          ...filteredRecords.map(_buildAuditCard),
        const SizedBox(height: 18),
        _buildExportCard(),
      ],
    );
  }

  Widget _buildAuditCard(
    Map<String, dynamic> record,
  ) {
    final color = record['color'] as Color;
    final status = record['status'].toString();

    return GestureDetector(
      onTap: () => _showAuditDetails(record),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                record['icon'] as IconData,
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
                          record['action'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
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
                    record['resource'].toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                  _auditInfo(
                    Icons.person_outline,
                    record['actor'].toString(),
                  ),
                  _auditInfo(
                    Icons.schedule_outlined,
                    record['time'].toString(),
                  ),
                  _auditInfo(
                    Icons.tag_outlined,
                    record['reference'].toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _auditInfo(
    IconData icon,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 8,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
          fontSize: 7,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Verified':
        return Colors.green;
      case 'Reviewed':
        return Colors.orange;
      case 'Resolved':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  Widget _buildCompliance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Compliance Center',
          'Reservation policy and verification status',
          Icons.verified_user_outlined,
        ),
        const SizedBox(height: 14),
        ...complianceItems.map(_buildComplianceCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Compliance Checklist',
          'Important controls for reservations',
          Icons.checklist_outlined,
        ),
        const SizedBox(height: 12),
        _checklistItem(
          'Participant identity verified',
          true,
        ),
        _checklistItem(
          'Resource availability confirmed',
          true,
        ),
        _checklistItem(
          'Reservation time approved',
          true,
        ),
        _checklistItem(
          'Pickup location recorded',
          true,
        ),
        _checklistItem(
          'Handover confirmation recorded',
          true,
        ),
        _checklistItem(
          'Issue resolution completed',
          false,
        ),
        const SizedBox(height: 18),
        _buildPolicyCard(),
      ],
    );
  }

  Widget _buildComplianceCard(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.13),
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
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: int.parse(
                          item['value'].toString().replaceAll('%', ''),
                        ) /
                        100,
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
    );
  }

  Widget _checklistItem(
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
        ],
      ),
    );
  }

  Widget _buildPolicyCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.policy_outlined,
            color: Colors.indigo,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reservation Policy Status',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Current reservation workflows are operating within the configured ResourceX safety and verification policies.',
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

  Widget _buildAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Audit Alerts',
          'Events requiring attention',
          Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 14),
        ...alerts.map(_buildAlertCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Smart Detection',
          'Automated anomaly monitoring',
          Icons.radar_outlined,
        ),
        const SizedBox(height: 12),
        _signalCard(
          'Unusual cancellation activity',
          'No critical anomaly detected in the current period.',
          0.88,
          Colors.green,
          Icons.analytics_outlined,
        ),
        _signalCard(
          'Repeated schedule modifications',
          'A small number of reservations need manual review.',
          0.72,
          Colors.orange,
          Icons.event_repeat_outlined,
        ),
        _signalCard(
          'Verification integrity',
          'No suspicious verification pattern detected.',
          0.96,
          Colors.indigo,
          Icons.fingerprint_outlined,
        ),
        const SizedBox(height: 18),
        _buildAlertSettings(),
      ],
    );
  }

  Widget _buildAlertCard(
    Map<String, dynamic> alert,
  ) {
    final color = alert['color'] as Color;

    return GestureDetector(
      onTap: () => _showAlertDetails(alert),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.14),
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
                size: 21,
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
                            fontSize: 12,
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
                  const SizedBox(height: 8),
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

  Widget _buildAlertSettings() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Audit Alert Settings',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 11),
          _settingRow(
            'Compliance warnings',
            'Receive alerts for policy exceptions.',
            true,
          ),
          _settingRow(
            'Schedule conflicts',
            'Notify when reservations overlap.',
            true,
          ),
          _settingRow(
            'Verification alerts',
            'Monitor missing verification records.',
            true,
          ),
          _settingRow(
            'Weekly audit summary',
            'Receive a weekly audit overview.',
            false,
          ),
        ],
      ),
    );
  }

  Widget _settingRow(
    String title,
    String subtitle,
    bool enabled,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 8,
        ),
      ),
      trailing: Switch(
        value: enabled,
        onChanged: (_) {
          _showSnackBar(
            '$title setting updated',
          );
        },
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
            'No audit records found',
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
                  'Export Audit Records',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Generate a secure audit report for reservation activity.',
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

  void _showAuditDetails(
    Map<String, dynamic> record,
  ) {
    final color = record['color'] as Color;

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
                _sheetHandle(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: color.withValues(alpha: 0.10),
                      child: Icon(
                        record['icon'] as IconData,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        record['action'].toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Resource',
                  record['resource'].toString(),
                ),
                _detailRow(
                  Icons.person_outline,
                  'Actor',
                  record['actor'].toString(),
                ),
                _detailRow(
                  Icons.schedule_outlined,
                  'Timestamp',
                  record['time'].toString(),
                ),
                _detailRow(
                  Icons.tag_outlined,
                  'Reference',
                  record['reference'].toString(),
                ),
                _detailRow(
                  Icons.verified_outlined,
                  'Audit status',
                  record['status'].toString(),
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
                          'This audit event is recorded as part of the reservation activity history.',
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
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showSnackBar(
                      'Audit event marked for review',
                    );
                  },
                  icon: const Icon(
                    Icons.fact_check_outlined,
                  ),
                  label: const Text(
                    'Mark for Review',
                  ),
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
              const SizedBox(height: 18),
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
              const SizedBox(height: 10),
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
                          'Alert added to review queue',
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
              _sheetHandle(),
              const SizedBox(height: 18),
              const Text(
                'Export Audit Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              _exportOption(
                sheetContext,
                Icons.picture_as_pdf_outlined,
                'PDF Audit Report',
                'Create a formatted compliance report.',
                Colors.red,
              ),
              _exportOption(
                sheetContext,
                Icons.table_chart_outlined,
                'CSV Audit Data',
                'Export audit events for analysis.',
                Colors.green,
              ),
              _exportOption(
                sheetContext,
                Icons.share_outlined,
                'Share Audit Summary',
                'Share key compliance information.',
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
                  'Audit Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.warning_amber_outlined,
                  'A reservation conflict needs review',
                  '18 minutes ago',
                  Colors.orange,
                ),
                _notificationItem(
                  Icons.verified_outlined,
                  'Compliance score updated',
                  '1 hour ago',
                  Colors.green,
                ),
                _notificationItem(
                  Icons.analytics_outlined,
                  'Weekly audit summary is ready',
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
      'Reservation audit refreshed',
    );
  }
}