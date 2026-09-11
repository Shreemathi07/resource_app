import 'package:flutter/material.dart';

class ResourceReservationApprovalScreen extends StatefulWidget {
  const ResourceReservationApprovalScreen({super.key});

  @override
  State<ResourceReservationApprovalScreen> createState() =>
      _ResourceReservationApprovalScreenState();
}

class _ResourceReservationApprovalScreenState
    extends State<ResourceReservationApprovalScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Requests',
    'Conflicts',
    'History',
  ];

  final List<String> filters = [
    'All',
    'Pending',
    'Urgent',
    'Approved',
    'Rejected',
  ];

  final List<Map<String, dynamic>> requests = [
    {
      'resource': 'Dell Latitude 5420',
      'category': 'Technology',
      'seeker': 'Digital Learning Hub',
      'provider': 'VIT Digital Resource Club',
      'location': 'Vellore Campus',
      'date': 'Sep 8, 2026',
      'time': '10:30 AM',
      'quantity': 3,
      'duration': '7 days',
      'priority': 'High',
      'status': 'Pending',
      'reason': 'Required for a community digital learning program.',
      'score': 96,
      'icon': Icons.laptop_mac_outlined,
    },
    {
      'resource': 'Study Table Set',
      'category': 'Furniture',
      'seeker': 'Student Support Center',
      'provider': 'Campus Community',
      'location': 'Katpadi',
      'date': 'Sep 9, 2026',
      'time': '2:00 PM',
      'quantity': 5,
      'duration': '14 days',
      'priority': 'Urgent',
      'status': 'Pending',
      'reason': 'Needed for newly opened community study space.',
      'score': 92,
      'icon': Icons.table_restaurant_outlined,
    },
    {
      'resource': 'Projector with Stand',
      'category': 'Electronics',
      'seeker': 'Community Workshop',
      'provider': 'Innovation Cell',
      'location': 'Vellore',
      'date': 'Sep 11, 2026',
      'time': '4:30 PM',
      'quantity': 1,
      'duration': '2 days',
      'priority': 'Medium',
      'status': 'Pending',
      'reason': 'Scheduled for a free skills workshop.',
      'score': 88,
      'icon': Icons.videocam_outlined,
    },
    {
      'resource': 'Educational Book Bundle',
      'category': 'Education',
      'seeker': 'Community Learning Hub',
      'provider': 'Knowledge Share Group',
      'location': 'Sathuvachari',
      'date': 'Sep 10, 2026',
      'time': '11:00 AM',
      'quantity': 24,
      'duration': '30 days',
      'priority': 'High',
      'status': 'Approved',
      'reason': 'Supporting a community learning initiative.',
      'score': 94,
      'icon': Icons.menu_book_outlined,
    },
    {
      'resource': 'Sports Equipment Kit',
      'category': 'Sports',
      'seeker': 'Youth Activity Center',
      'provider': 'Campus Sports Club',
      'location': 'Gandhi Nagar',
      'date': 'Sep 5, 2026',
      'time': '9:00 AM',
      'quantity': 2,
      'duration': '5 days',
      'priority': 'Medium',
      'status': 'Rejected',
      'reason': 'Requested dates overlap with another confirmed reservation.',
      'score': 61,
      'icon': Icons.sports_basketball_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return requests.where((request) {
      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          request['resource'].toString().toLowerCase().contains(query) ||
          request['seeker'].toString().toLowerCase().contains(query) ||
          request['provider'].toString().toLowerCase().contains(query) ||
          request['category'].toString().toLowerCase().contains(query);

      final matchesFilter =
          selectedFilter == 'All' || request['status'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get pendingCount =>
      requests.where((request) => request['status'] == 'Pending').length;

  int get urgentCount =>
      requests.where((request) => request['priority'] == 'Urgent').length;

  int get approvedCount =>
      requests.where((request) => request['status'] == 'Approved').length;

  int get rejectedCount =>
      requests.where((request) => request['status'] == 'Rejected').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Reservation Approvals',
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroCard(),
                const SizedBox(height: 18),
                _buildSearchBar(),
                const SizedBox(height: 14),
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
            scheme.primary.withValues(alpha: 0.70),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
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
                  Icons.fact_check_outlined,
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
                  'Smart Approval',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Reservation Approval Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review reservation requests, detect scheduling conflicts and make faster community resource decisions.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('$pendingCount', 'Pending'),
              _heroMetric('$urgentCount', 'Urgent'),
              _heroMetric('94%', 'Accuracy'),
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
              color: Colors.white.withValues(alpha: 0.72),
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
        hintText: 'Search requests, resources or seekers...',
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
      ),
    );
  }

  Widget _buildStats() {
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
      child: Row(
        children: [
          _statItem(
            '$pendingCount',
            'Pending',
            Colors.orange,
          ),
          _statItem(
            '$urgentCount',
            'Urgent',
            Colors.red,
          ),
          _statItem(
            '$approvedCount',
            'Approved',
            Colors.green,
          ),
          _statItem(
            '$rejectedCount',
            'Rejected',
            Colors.grey,
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
              fontSize: 18,
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
        return _buildRequestsTab();
      case 2:
        return _buildConflictsTab();
      case 3:
        return _buildHistoryTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    final pendingRequests =
        requests.where((request) => request['status'] == 'Pending').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Needs Your Attention',
          'Requests waiting for approval',
          Icons.priority_high_rounded,
        ),
        const SizedBox(height: 12),
        if (pendingRequests.isEmpty)
          _buildEmptyState(
            Icons.task_alt_rounded,
            'All requests reviewed',
            'There are no pending reservation requests.',
          )
        else
          ...pendingRequests.map(_buildRequestCard),
        const SizedBox(height: 18),
        _buildSmartApprovalCard(),
        const SizedBox(height: 18),
        _buildApprovalPerformance(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    final items = filteredRequests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Reservation Queue',
          'Review and manage incoming requests',
          Icons.inbox_outlined,
        ),
        const SizedBox(height: 12),
        _buildFilterChips(),
        const SizedBox(height: 14),
        if (items.isEmpty)
          _buildEmptyState(
            Icons.inbox_outlined,
            'No matching requests',
            'Try changing your search or filter.',
          )
        else
          ...items.map(_buildRequestCard),
      ],
    );
  }

  Widget _buildConflictsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Schedule Conflicts',
          'Potential reservation overlaps',
          Icons.warning_amber_rounded,
        ),
        const SizedBox(height: 12),
        _buildConflictCard(
          'Sports Equipment Kit',
          'Sep 5, 2026',
          'Two reservations overlap by 2 hours.',
          'High',
          Colors.red,
        ),
        _buildConflictCard(
          'Dell Latitude 5420',
          'Sep 8, 2026',
          'Requested quantity is close to available capacity.',
          'Medium',
          Colors.orange,
        ),
        _buildConflictCard(
          'Projector with Stand',
          'Sep 11, 2026',
          'Pickup window overlaps with another scheduled exchange.',
          'Medium',
          Colors.orange,
        ),
        const SizedBox(height: 18),
        _buildConflictSummary(),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final history = requests
        .where((request) =>
            request['status'] == 'Approved' ||
            request['status'] == 'Rejected')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Approval History',
          'Recently reviewed reservation requests',
          Icons.history_rounded,
        ),
        const SizedBox(height: 12),
        ...history.map(_buildHistoryCard),
        const SizedBox(height: 18),
        _buildResponseTimeCard(),
      ],
    );
  }

  Widget _buildRequestCard(
    Map<String, dynamic> request,
  ) {
    final status = request['status'].toString();
    final priority = request['priority'].toString();
    final priorityColor = _priorityColor(priority);
    final statusColor = _statusColor(status);

    return GestureDetector(
      onTap: () => _showRequestDetails(request),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: priority == 'Urgent'
                ? Colors.red.withValues(alpha: 0.20)
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
                    color: priorityColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    request['icon'] as IconData,
                    color: priorityColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request['seeker'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _smallBadge(
                            priority,
                            priorityColor,
                          ),
                          const SizedBox(width: 6),
                          _smallBadge(
                            status,
                            statusColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '${request['score']}%',
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  _infoItem(
                    Icons.calendar_today_outlined,
                    request['date'].toString(),
                  ),
                  _infoItem(
                    Icons.access_time_outlined,
                    request['time'].toString(),
                  ),
                  _infoItem(
                    Icons.inventory_2_outlined,
                    '${request['quantity']}',
                  ),
                ],
              ),
            ),
            if (status == 'Pending') ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _rejectRequest(request),
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => _approveRequest(request),
                      child: const Text('Approve'),
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

  Widget _smallBadge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
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

  Widget _infoItem(
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

  Widget _buildSmartApprovalCard() {
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
                  'Smart Approval Recommendation',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'The top pending request has a 96% approval confidence based on resource availability, seeker verification, urgency and schedule compatibility.',
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

  Widget _buildApprovalPerformance() {
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
            'Approval Performance',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _progressRow('Approval accuracy', 0.94, '94%'),
          _progressRow('Response within 2 hrs', 0.89, '89%'),
          _progressRow('Conflict detection', 0.96, '96%'),
          _progressRow('Successful reservations', 0.93, '93%'),
        ],
      ),
    );
  }

  Widget _progressRow(
    String label,
    double value,
    String percentage,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
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
          const SizedBox(width: 9),
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

  Widget _buildConflictCard(
    String resource,
    String date,
    String message,
    String level,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
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
              Icons.warning_amber_rounded,
              color: color,
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
                        resource,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    _smallBadge(level, color),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConflictSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.14),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: Colors.orange,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Smart detection found 3 potential scheduling conflicts. Review them before approving new requests.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(
    Map<String, dynamic> request,
  ) {
    final status = request['status'].toString();
    final color = _statusColor(status);

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
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.10),
            child: Icon(
              status == 'Approved'
                  ? Icons.check_rounded
                  : Icons.close_rounded,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request['resource'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request['seeker'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request['date'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          _smallBadge(status, color),
        ],
      ),
    );
  }

  Widget _buildResponseTimeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.speed_rounded,
            color: Colors.indigo,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Average Response Time',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '1h 42m',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '18% faster than the previous period',
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

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Urgent':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showRequestDetails(
    Map<String, dynamic> request,
  ) {
    final priority = request['priority'].toString();
    final status = request['status'].toString();

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
                      backgroundColor: _priorityColor(priority)
                          .withValues(alpha: 0.10),
                      child: Icon(
                        request['icon'] as IconData,
                        color: _priorityColor(priority),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        request['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _smallBadge(
                      priority,
                      _priorityColor(priority),
                    ),
                    const SizedBox(width: 7),
                    _smallBadge(
                      status,
                      _statusColor(status),
                    ),
                    const Spacer(),
                    Text(
                      '${request['score']}% confidence',
                      style: TextStyle(
                        color: _priorityColor(priority),
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  request['category'].toString(),
                ),
                _detailRow(
                  Icons.person_search_outlined,
                  'Seeker',
                  request['seeker'].toString(),
                ),
                _detailRow(
                  Icons.business_outlined,
                  'Provider',
                  request['provider'].toString(),
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  request['location'].toString(),
                ),
                _detailRow(
                  Icons.calendar_today_outlined,
                  'Date',
                  request['date'].toString(),
                ),
                _detailRow(
                  Icons.access_time_outlined,
                  'Time',
                  request['time'].toString(),
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Quantity',
                  request['quantity'].toString(),
                ),
                _detailRow(
                  Icons.timer_outlined,
                  'Duration',
                  request['duration'].toString(),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reservation Reason',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        request['reason'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                if (status == 'Pending')
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            _rejectRequest(request);
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                          ),
                          label: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            _approveRequest(request);
                          },
                          icon: const Icon(
                            Icons.check_rounded,
                          ),
                          label: const Text('Approve'),
                        ),
                      ),
                    ],
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                      },
                      child: const Text('Close'),
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

  void _approveRequest(
    Map<String, dynamic> request,
  ) {
    setState(() {
      request['status'] = 'Approved';
    });

    _showSnackBar(
      '${request['resource']} reservation approved',
    );
  }

  void _rejectRequest(
    Map<String, dynamic> request,
  ) {
    _showRejectSheet(request);
  }

  void _showRejectSheet(
    Map<String, dynamic> request,
  ) {
    final controller = TextEditingController();

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
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).viewInsets.bottom + 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reject Reservation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                request['resource'].toString(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Reason for rejection',
                  hintText: 'Enter a clear reason...',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      request['status'] = 'Rejected';
                      request['reason'] = controller.text.isEmpty
                          ? 'Reservation could not be approved at this time.'
                          : controller.text;
                    });

                    Navigator.pop(sheetContext);

                    _showSnackBar(
                      '${request['resource']} reservation rejected',
                    );
                  },
                  child: const Text(
                    'Confirm Rejection',
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
    ).whenComplete(controller.dispose);
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
                  'Filter Requests',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ...filters.map(
                  (filter) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(filter),
                    leading: Icon(
                      filter == 'Urgent'
                          ? Icons.priority_high_rounded
                          : filter == 'Pending'
                              ? Icons.hourglass_empty_rounded
                              : filter == 'Approved'
                                  ? Icons.check_circle_outline
                                  : filter == 'Rejected'
                                      ? Icons.cancel_outlined
                                      : Icons.all_inbox_outlined,
                    ),
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
                  'Approval Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.priority_high_rounded,
                  'Urgent reservation needs review',
                  '5 min ago',
                ),
                _notificationItem(
                  Icons.warning_amber_rounded,
                  'A schedule conflict was detected',
                  '25 min ago',
                ),
                _notificationItem(
                  Icons.auto_awesome_outlined,
                  'Smart approval recommendation updated',
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
          fontSize: 10,
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

    _showSnackBar('Approval data refreshed');
  }
}