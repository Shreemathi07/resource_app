import 'package:flutter/material.dart';

class ExchangeReputationDisputeScreen extends StatefulWidget {
  const ExchangeReputationDisputeScreen({super.key});

  @override
  State<ExchangeReputationDisputeScreen> createState() =>
      _ExchangeReputationDisputeScreenState();
}

class _ExchangeReputationDisputeScreenState
    extends State<ExchangeReputationDisputeScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchText = '';

  final List<String> tabs = [
    'Overview',
    'Disputes',
    'Resolutions',
    'History',
  ];

  final List<String> filters = [
    'All',
    'Pending',
    'Escalated',
    'Resolved',
  ];

  final List<Map<String, dynamic>> disputes = [
    {
      'id': 'DSP-1048',
      'title': 'Quantity mismatch',
      'resource': 'Study Materials',
      'member': 'Arjun Kumar',
      'status': 'Pending',
      'priority': 'Medium',
      'date': 'Today, 10:42 AM',
      'deadline': '18 hours left',
      'description':
          'The received quantity was lower than the quantity agreed during the exchange.',
    },
    {
      'id': 'DSP-1045',
      'title': 'Condition issue',
      'resource': 'Laptop Accessories',
      'member': 'Meera Nair',
      'status': 'Escalated',
      'priority': 'High',
      'date': 'Yesterday, 4:20 PM',
      'deadline': 'Priority review',
      'description':
          'The received resource condition was different from the agreed condition.',
    },
    {
      'id': 'DSP-1041',
      'title': 'Late handover',
      'resource': 'Lab Equipment',
      'member': 'Rahul Dev',
      'status': 'Resolved',
      'priority': 'Low',
      'date': 'Sep 04, 2:15 PM',
      'deadline': 'Resolved',
      'description':
          'The exchange was completed later than the originally scheduled handover.',
    },
    {
      'id': 'DSP-1038',
      'title': 'Incorrect resource',
      'resource': 'Stationery Kit',
      'member': 'Priya S',
      'status': 'Resolved',
      'priority': 'Medium',
      'date': 'Sep 02, 11:05 AM',
      'deadline': 'Resolved',
      'description':
          'A different resource was received during the completed exchange.',
    },
  ];

  final List<Map<String, String>> resolutions = [
    {
      'title': 'Replacement approved',
      'case': 'DSP-1038',
      'type': 'Replacement',
      'date': 'Sep 02',
    },
    {
      'title': 'Partial allocation approved',
      'case': 'DSP-1034',
      'type': 'Partial resolution',
      'date': 'Aug 30',
    },
    {
      'title': 'Exchange rescheduled',
      'case': 'DSP-1029',
      'type': 'Reschedule',
      'date': 'Aug 28',
    },
  ];

  List<Map<String, dynamic>> get filteredDisputes {
    return disputes.where((item) {
      final matchesFilter =
          selectedFilter == 'All' || item['status'] == selectedFilter;

      final query = searchText.toLowerCase();

      final matchesSearch = query.isEmpty ||
          item['id'].toString().toLowerCase().contains(query) ||
          item['title'].toString().toLowerCase().contains(query) ||
          item['resource'].toString().toLowerCase().contains(query) ||
          item['member'].toString().toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Exchange Trust Center',
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
            onPressed: showInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              buildHero(),
              const SizedBox(height: 18),
              buildStats(),
              const SizedBox(height: 20),
              buildTabs(),
              const SizedBox(height: 18),
              buildContent(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showReportIssue,
        backgroundColor: const Color(0xFF18202A),
        icon: const Icon(Icons.report_problem_outlined),
        label: const Text(
          'Report Issue',
          style: TextStyle(fontWeight: FontWeight.w700),
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
            Color(0xFF303D4D),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Exchange Trust Center',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFB8F2D0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Healthy',
                  style: TextStyle(
                    color: Color(0xFF146B3A),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Platform Resolution Score',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '96',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4,
                  bottom: 8,
                ),
                child: Text(
                  '/100',
                  style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.96,
              minHeight: 8,
              backgroundColor: Color(0x33202020),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFB8F2D0),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Most exchange issues are being resolved quickly and fairly.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStats() {
    return Row(
      children: [
        Expanded(
          child: statCard(
            'Open',
            '2',
            Icons.pending_actions_rounded,
            const Color(0xFFE8F0FF),
            const Color(0xFF3867D6),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: statCard(
            'Resolved',
            '34',
            Icons.task_alt_rounded,
            const Color(0xFFE8F8EF),
            const Color(0xFF23844D),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: statCard(
            'Escalated',
            '1',
            Icons.priority_high_rounded,
            const Color(0xFFFFECEC),
            const Color(0xFFC43D3D),
          ),
        ),
      ],
    );
  }

  Widget statCard(
    String title,
    String value,
    IconData icon,
    Color background,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7EBF0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 19,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
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
                      fontSize: 12,
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
        return buildDisputes();
      case 2:
        return buildResolutions();
      case 3:
        return buildHistory();
      default:
        return buildOverview();
    }
  }

  Widget buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Attention required',
          '2 exchanges need review',
        ),
        const SizedBox(height: 12),
        attentionCard(
          'Quantity mismatch',
          'Study Materials • DSP-1048',
          Icons.inventory_2_outlined,
          const Color(0xFF3867D6),
          'Review',
          () => showDisputeDetails(disputes[0]),
        ),
        const SizedBox(height: 10),
        attentionCard(
          'Condition issue',
          'Laptop Accessories • DSP-1045',
          Icons.warning_amber_rounded,
          const Color(0xFFC43D3D),
          'Resolve',
          () => showDisputeDetails(disputes[1]),
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Resolution performance',
          'Last 30 days',
        ),
        const SizedBox(height: 12),
        performanceCard(),
        const SizedBox(height: 22),
        sectionTitle(
          'Smart recommendations',
          'Based on exchange patterns',
        ),
        const SizedBox(height: 12),
        recommendationCard(
          Icons.fact_check_outlined,
          'Add quantity confirmation',
          'Ask both parties to confirm quantities before handover.',
        ),
        const SizedBox(height: 10),
        recommendationCard(
          Icons.photo_camera_outlined,
          'Use condition snapshots',
          'A quick photo before handover can reduce condition disputes.',
        ),
        const SizedBox(height: 10),
        recommendationCard(
          Icons.schedule_rounded,
          'Set handover reminders',
          'Automated reminders can reduce late exchange cases.',
        ),
      ],
    );
  }

  Widget attentionCard(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    String action,
    VoidCallback onTap,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7EBF0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
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
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              action,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget performanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE7EBF0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              performanceItem('97%', 'Resolution rate'),
              performanceItem('4.6h', 'Avg. resolution'),
              performanceItem('98%', 'Fairness score'),
            ],
          ),
          const SizedBox(height: 22),
          progressRow('Resolved within 24h', 0.92, '92%'),
          const SizedBox(height: 13),
          progressRow(
            'Resolved without escalation',
            0.97,
            '97%',
          ),
          const SizedBox(height: 13),
          progressRow(
            'Members satisfied',
            0.94,
            '94%',
          ),
        ],
      ),
    );
  }

  Widget performanceItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressRow(
    String title,
    double value,
    String percentage,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4D5865),
                ),
              ),
            ),
            Text(
              percentage,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF18202A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            backgroundColor: const Color(0xFFECEFF3),
          ),
        ),
      ],
    );
  }

  Widget recommendationCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF3867D6),
              size: 21,
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
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
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

  Widget buildDisputes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search disputes, members or resources',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: searchText.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        searchText = '';
                      });
                    },
                    icon: const Icon(Icons.close_rounded),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE2E7ED),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE2E7ED),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final selected = selectedFilter == filter;

              return ChoiceChip(
                label: Text(filter),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                selectedColor: const Color(0xFF18202A),
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF687382),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        if (filteredDisputes.isEmpty)
          emptyState()
        else
          ...filteredDisputes.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: disputeCard(item),
            ),
          ),
      ],
    );
  }

  Widget disputeCard(Map<String, dynamic> item) {
    final status = item['status'].toString();

    Color statusColor;
    Color statusBackground;

    if (status == 'Resolved') {
      statusColor = const Color(0xFF23844D);
      statusBackground = const Color(0xFFE8F8EF);
    } else if (status == 'Escalated') {
      statusColor = const Color(0xFFC43D3D);
      statusBackground = const Color(0xFFFFECEC);
    } else {
      statusColor = const Color(0xFF3867D6);
      statusBackground = const Color(0xFFE8F0FF);
    }

    return InkWell(
      onTap: () => showDisputeDetails(item),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.gavel_rounded,
                    color: Color(0xFF4D5865),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        '${item['resource']} • ${item['id']}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.person_outline_rounded,
                  size: 16,
                  color: Color(0xFF7A8491),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item['member'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF596573),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                priorityBadge(
                  item['priority'].toString(),
                ),
              ],
            ),
            const SizedBox(height: 13),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 15,
                  color: Color(0xFF7A8491),
                ),
                const SizedBox(width: 5),
                Text(
                  item['date'].toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const Spacer(),
                Text(
                  item['deadline'].toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: status == 'Escalated'
                        ? const Color(0xFFC43D3D)
                        : const Color(0xFF596573),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: Color(0xFF9AA3AE),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget priorityBadge(String priority) {
    Color color;

    if (priority == 'High') {
      color = const Color(0xFFC43D3D);
    } else if (priority == 'Medium') {
      color = const Color(0xFFB27600);
    } else {
      color = const Color(0xFF23844D);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.flag_rounded,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          priority,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget buildResolutions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Resolution workflow',
          'Track completed outcomes',
        ),
        const SizedBox(height: 14),
        Container(
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
              workflowStep(
                1,
                'Issue reported',
                'Exchange concern submitted',
                true,
              ),
              workflowConnector(),
              workflowStep(
                2,
                'Evidence reviewed',
                'Details and supporting information checked',
                true,
              ),
              workflowConnector(),
              workflowStep(
                3,
                'Resolution selected',
                'Fair outcome recommended',
                true,
              ),
              workflowConnector(),
              workflowStep(
                4,
                'Outcome confirmed',
                'Both parties receive the final update',
                false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Recent resolutions',
          '${resolutions.length} completed',
        ),
        const SizedBox(height: 12),
        ...resolutions.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: resolutionCard(item),
          ),
        ),
      ],
    );
  }

  Widget workflowStep(
    int number,
    String title,
    String subtitle,
    bool completed,
  ) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: completed
                ? const Color(0xFF18202A)
                : const Color(0xFFECEFF3),
            shape: BoxShape.circle,
          ),
          child: completed
              ? const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 18,
                )
              : Text(
                  '$number',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7A8491),
                  ),
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
          ),
        ),
      ],
    );
  }

  Widget workflowConnector() {
    return Container(
      height: 22,
      margin: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Color(0xFFDCE1E7),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget resolutionCard(Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Icons.task_alt_rounded,
              color: Color(0xFF23844D),
            ),
          ),
          const SizedBox(width: 12),
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
                  '${item['case']} • ${item['type']}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['date']!,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF8A949F),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHistory() {
    final history = [
      [
        'Dispute resolved',
        'Incorrect resource case closed',
        'Today, 9:32 AM',
        Icons.check_circle_outline_rounded,
      ],
      [
        'Evidence uploaded',
        'Condition photos added to DSP-1045',
        'Yesterday, 6:10 PM',
        Icons.attach_file_rounded,
      ],
      [
        'Case escalated',
        'DSP-1045 moved to priority review',
        'Yesterday, 5:48 PM',
        Icons.priority_high_rounded,
      ],
      [
        'Resolution accepted',
        'Both parties accepted the replacement',
        'Sep 02, 3:14 PM',
        Icons.handshake_outlined,
      ],
      [
        'Dispute created',
        'Quantity mismatch was reported',
        'Sep 01, 10:42 AM',
        Icons.add_alert_outlined,
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(
          'Activity history',
          'Latest trust events',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE5E9EF),
            ),
          ),
          child: Column(
            children: List.generate(
              history.length,
              (index) {
                final item = history[index];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F3F6),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Icon(
                              item[3] as IconData,
                              size: 19,
                              color: const Color(0xFF4D5865),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item[0].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Color(0xFF18202A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item[1].toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF7A8491),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item[2].toString(),
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF9AA3AE),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index != history.length - 1)
                      const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 22),
        sectionTitle(
          'Trust protection',
          'How ResourceX keeps exchanges fair',
        ),
        const SizedBox(height: 12),
        protectionCard(
          Icons.verified_user_outlined,
          'Verified identities',
          'Member verification helps create accountable exchanges.',
        ),
        const SizedBox(height: 10),
        protectionCard(
          Icons.history_rounded,
          'Exchange records',
          'Important exchange actions are recorded for transparency.',
        ),
        const SizedBox(height: 10),
        protectionCard(
          Icons.support_agent_rounded,
          'Resolution support',
          'Escalated cases can receive additional platform review.',
        ),
      ],
    );
  }

  Widget protectionCard(
    IconData icon,
    String title,
    String description,
  ) {
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
          Icon(
            icon,
            color: const Color(0xFF3867D6),
            size: 24,
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
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Color(0xFF7A8491),
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

  Widget emptyState() {
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
      child: const Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 45,
            color: Color(0xFF9AA3AE),
          ),
          SizedBox(height: 12),
          Text(
            'No disputes found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18202A),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Try another search or filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  void showDisputeDetails(Map<String, dynamic> item) {
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
              12,
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
                  const SizedBox(height: 22),
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
                      statusPill(item['status'].toString()),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item['id']} • ${item['resource']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                  const SizedBox(height: 22),
                  detailRow(
                    Icons.person_outline_rounded,
                    'Member',
                    item['member'].toString(),
                  ),
                  detailRow(
                    Icons.flag_outlined,
                    'Priority',
                    item['priority'].toString(),
                  ),
                  detailRow(
                    Icons.schedule_outlined,
                    'Reported',
                    item['date'].toString(),
                  ),
                  detailRow(
                    Icons.timer_outlined,
                    'Response',
                    item['deadline'].toString(),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Issue description',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      item['description'].toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF596573),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Evidence',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: evidenceTile(
                          Icons.photo_library_outlined,
                          '3 Photos',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: evidenceTile(
                          Icons.chat_bubble_outline_rounded,
                          'Conversation',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            showEvidence();
                          },
                          icon: const Icon(
                            Icons.folder_open_outlined,
                          ),
                          label: const Text('Evidence'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            showResolutionOptions(item);
                          },
                          icon: const Icon(Icons.gavel_rounded),
                          label: const Text('Resolve'),
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

  Widget statusPill(String status) {
    final resolved = status == 'Resolved';
    final escalated = status == 'Escalated';

    final color = resolved
        ? const Color(0xFF23844D)
        : escalated
            ? const Color(0xFFC43D3D)
            : const Color(0xFF3867D6);

    final background = resolved
        ? const Color(0xFFE8F8EF)
        : escalated
            ? const Color(0xFFFFECEC)
            : const Color(0xFFE8F0FF);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
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
            size: 19,
            color: const Color(0xFF7A8491),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
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

  Widget evidenceTile(
    IconData icon,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: const Color(0xFF3867D6),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF596573),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showResolutionOptions(
    Map<String, dynamic> item,
  ) {
    final options = [
      [
        Icons.swap_horiz_rounded,
        'Replacement',
        'Provide an equivalent replacement resource.',
      ],
      [
        Icons.call_split_rounded,
        'Partial resolution',
        'Resolve only the affected part of the exchange.',
      ],
      [
        Icons.event_repeat_rounded,
        'Reschedule exchange',
        'Give both parties another handover opportunity.',
      ],
      [
        Icons.support_agent_rounded,
        'Escalate',
        'Send the case for additional platform review.',
      ],
    ];

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
              14,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8DDE3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose resolution',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF18202A),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recommended for ${item['id']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ...options.map(
                  (option) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F3F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        option[0] as IconData,
                        color: const Color(0xFF3867D6),
                      ),
                    ),
                    title: Text(
                      option[1].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF18202A),
                      ),
                    ),
                    subtitle: Text(
                      option[2].toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF7A8491),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF9AA3AE),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      completeResolution(
                        option[1].toString(),
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

  void completeResolution(String resolution) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$resolution selected. Resolution workflow updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showEvidence() {
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
                  Icons.folder_copy_outlined,
                  size: 44,
                  color: Color(0xFF3867D6),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Evidence Center',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Photos, messages and exchange records are available for review.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text('Exchange photos'),
                  subtitle: const Text('3 files'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.chat_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text('Conversation record'),
                  subtitle: const Text('Available'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.receipt_long_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text('Exchange details'),
                  subtitle: const Text('Verified'),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(sheetContext),
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

  void showReportIssue() {
    String reason = 'Resource mismatch';

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
            final reasons = [
              'Resource mismatch',
              'Quantity issue',
              'Condition issue',
              'Late handover',
              'Unsafe exchange',
              'Other',
            ];

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  14,
                  20,
                  MediaQuery.of(context).viewInsets.bottom + 20,
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
                        'Report exchange issue',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Tell us what happened so the issue can be reviewed fairly.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Issue type',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: reasons.map(
                          (item) {
                            final selected = reason == item;

                            return ChoiceChip(
                              label: Text(item),
                              selected: selected,
                              onSelected: (_) {
                                setSheetState(() {
                                  reason = item;
                                });
                              },
                              selectedColor:
                                  const Color(0xFF18202A),
                              labelStyle: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF596573),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 9),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Describe the issue...',
                          filled: true,
                          fillColor: const Color(0xFFF6F8FB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Attachment option selected.',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.attach_file_rounded,
                        ),
                        label: const Text('Attach evidence'),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            ScaffoldMessenger.of(this.context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Issue reported successfully. Case DSP-1052 created.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.send_rounded),
                          label: const Text(
                            'Submit Issue',
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
                  'Trust Center Alerts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: const Icon(
                    Icons.priority_high_rounded,
                    color: Color(0xFFC43D3D),
                  ),
                  title: const Text('DSP-1045 was escalated'),
                  subtitle: const Text(
                    'Requires priority review.',
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.schedule_rounded,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text(
                    'DSP-1048 response deadline',
                  ),
                  subtitle: const Text(
                    '18 hours remaining.',
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Color(0xFF23844D),
                  ),
                  title: const Text('DSP-1041 resolved'),
                  subtitle: const Text(
                    'Exchange successfully closed.',
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

  void showInfo() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'About Trust Center',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'The Exchange Trust Center helps members report, track and resolve exchange problems while keeping issue handling transparent.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshData() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Trust Center updated.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}