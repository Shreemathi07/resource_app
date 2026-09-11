import 'package:flutter/material.dart';

class RequirementEscalationScreen extends StatefulWidget {
  const RequirementEscalationScreen({super.key});

  @override
  State<RequirementEscalationScreen> createState() =>
      _RequirementEscalationScreenState();
}

class _RequirementEscalationScreenState
    extends State<RequirementEscalationScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchText = '';

  final List<String> tabs = [
    'All Alerts',
    'Urgent',
    'Overdue',
    'Resolved',
  ];

  final List<String> filters = [
    'All',
    'Deadline',
    'Matching',
    'Fulfillment',
    'Response',
  ];

  final List<Map<String, dynamic>> alerts = [
    {
      'title': 'Laptop Requirement Deadline Approaching',
      'requirement': 'Laptops for Student Lab',
      'type': 'Deadline',
      'priority': 'Critical',
      'time': '12 min ago',
      'days': '1 day left',
      'icon': Icons.schedule_rounded,
      'description':
          'Only 8 hours remain before the preferred fulfillment deadline. Current matching progress is 62%.',
      'action': 'Extend deadline or increase provider outreach.',
      'resolved': false,
    },
    {
      'title': 'Medical Supply Requirement Overdue',
      'requirement': 'First Aid Supplies',
      'type': 'Fulfillment',
      'priority': 'Critical',
      'time': '42 min ago',
      'days': '2 days overdue',
      'icon': Icons.warning_amber_rounded,
      'description':
          'The requirement has passed its expected fulfillment date and remains below the required quantity.',
      'action': 'Escalate to verified medical resource providers.',
      'resolved': false,
    },
    {
      'title': 'Low Provider Response',
      'requirement': 'Community Clothing Collection',
      'type': 'Response',
      'priority': 'High',
      'time': '2 hrs ago',
      'days': '18% response',
      'icon': Icons.people_outline_rounded,
      'description':
          'Provider response is significantly lower than the normal response rate for this category.',
      'action': 'Send targeted provider notifications.',
      'resolved': false,
    },
    {
      'title': 'Requirement Successfully Escalated',
      'requirement': 'Engineering Textbooks',
      'type': 'Matching',
      'priority': 'Resolved',
      'time': 'Yesterday',
      'days': '82% fulfilled',
      'icon': Icons.check_circle_outline_rounded,
      'description':
          'Additional providers were contacted and the requirement moved into the confirmed stage.',
      'action': 'No further intervention required.',
      'resolved': true,
    },
    {
      'title': 'Slow Matching Detected',
      'requirement': 'Community Food Kits',
      'type': 'Matching',
      'priority': 'Medium',
      'time': 'Yesterday',
      'days': '5 hrs average',
      'icon': Icons.speed_rounded,
      'description':
          'Matching speed has decreased compared with the normal community average.',
      'action': 'Review nearby provider availability.',
      'resolved': false,
    },
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    return alerts.where((alert) {
      final typeMatch =
          selectedFilter == 'All' || alert['type'] == selectedFilter;

      final search = searchText.toLowerCase();

      final searchMatch = search.isEmpty ||
          alert['title'].toString().toLowerCase().contains(search) ||
          alert['requirement'].toString().toLowerCase().contains(search);

      final priority = alert['priority'] as String;

      final tabMatch = switch (selectedTab) {
        0 => true,
        1 => priority == 'Critical' || priority == 'High',
        2 => (alert['days'] as String).contains('overdue'),
        3 => alert['resolved'] == true,
        _ => true,
      };

      return typeMatch && searchMatch && tabMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7FB),
        elevation: 0,
        title: const Text(
          'Smart Alerts',
          style: TextStyle(
            color: Color(0xFF1D2638),
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showAlertSettings,
            icon: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF30384A),
            ),
          ),
          IconButton(
            onPressed: refreshAlerts,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF30384A),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshAlerts,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            buildHero(),
            const SizedBox(height: 18),
            buildSearch(),
            const SizedBox(height: 14),
            buildFilters(),
            const SizedBox(height: 16),
            buildTabs(),
            const SizedBox(height: 20),
            buildAlertOverview(),
            const SizedBox(height: 22),
            buildSectionHeader(),
            const SizedBox(height: 13),
            buildAlertList(),
            const SizedBox(height: 22),
            buildSmartIntervention(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showCreateAlert,
        backgroundColor: const Color(0xFF5B5FEF),
        icon: const Icon(Icons.add_alert_rounded),
        label: const Text(
          'Create Alert',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4D52E6),
            Color(0xFF777CF5),
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
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Smart Escalation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Requirement\nAlert Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Detect deadlines, delays and fulfillment risks before requirements become critical.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              buildHeroMetric('12', 'Active Alerts'),
              buildHeroDivider(),
              buildHeroMetric('4', 'Critical'),
              buildHeroDivider(),
              buildHeroMetric('28', 'Resolved'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeroMetric(String value, String label) {
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
              color: Colors.white.withValues(alpha: 0.74),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeroDivider() {
    return Container(
      width: 1,
      height: 34,
      color: Colors.white.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget buildSearch() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search alerts or requirements...',
        prefixIcon: const Icon(Icons.search_rounded),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildFilters() {
    return SizedBox(
      height: 40,
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
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF5B5FEF)
                    : Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF5B5FEF)
                      : const Color(0xFFE3E6EF),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF626A7B),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTabs() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF2),
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
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFF5559E8)
                          : const Color(0xFF747B8B),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
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

  Widget buildAlertOverview() {
    final stats = [
      ['12', 'Active', Icons.notifications_active_rounded],
      ['4', 'Critical', Icons.priority_high_rounded],
      ['3', 'Overdue', Icons.event_busy_rounded],
      ['28', 'Resolved', Icons.task_alt_rounded],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: const Color(0xFFE5E8EF),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                stat[2] as IconData,
                color: const Color(0xFF5B5FEF),
                size: 20,
              ),
              const Spacer(),
              Text(
                stat[0] as String,
                style: const TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                stat[1] as String,
                style: const TextStyle(
                  color: Color(0xFF7D8493),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSectionHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alert Queue',
                style: TextStyle(
                  color: Color(0xFF1D2638),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Requirements that need attention',
                style: TextStyle(
                  color: Color(0xFF7B8392),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${filteredAlerts.length} alerts',
          style: const TextStyle(
            color: Color(0xFF5B5FEF),
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget buildAlertList() {
    final items = filteredAlerts;

    if (items.isEmpty) {
      return buildEmptyState();
    }

    return Column(
      children: items.map(buildAlertCard).toList(),
    );
  }

  Widget buildAlertCard(Map<String, dynamic> alert) {
    final priority = alert['priority'] as String;
    final resolved = alert['resolved'] as bool;

    final isCritical = priority == 'Critical';
    final isHigh = priority == 'High';

    final background = resolved
        ? const Color(0xFFEAF9F3)
        : isCritical
            ? const Color(0xFFFFEEEE)
            : isHigh
                ? const Color(0xFFFFF4E8)
                : const Color(0xFFF0F1FF);

    final iconColor = resolved
        ? const Color(0xFF24966A)
        : isCritical
            ? const Color(0xFFE05D58)
            : isHigh
                ? const Color(0xFFD58931)
                : const Color(0xFF5B5FEF);

    return GestureDetector(
      onTap: () => showAlertDetails(alert),
      child: Container(
        margin: const EdgeInsets.only(bottom: 13),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E8EF),
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
                    color: background,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    alert['icon'] as IconData,
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
                        alert['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF30384A),
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        alert['requirement'] as String,
                        style: const TextStyle(
                          color: Color(0xFF777F90),
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12,
                            color: iconColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            alert['time'] as String,
                            style: const TextStyle(
                              color: Color(0xFF8A91A0),
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildPriorityBadge(priority),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 15,
                    color: iconColor,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      alert['days'] as String,
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9299A8),
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriorityBadge(String priority) {
    final resolved = priority == 'Resolved';
    final critical = priority == 'Critical';

    final color = resolved
        ? const Color(0xFF24966A)
        : critical
            ? const Color(0xFFE05D58)
            : priority == 'High'
                ? const Color(0xFFD58931)
                : const Color(0xFF5B5FEF);

    final background = resolved
        ? const Color(0xFFEAF9F3)
        : critical
            ? const Color(0xFFFFEEEE)
            : priority == 'High'
                ? const Color(0xFFFFF4E8)
                : const Color(0xFFF0F1FF);

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
          color: color,
          fontSize: 7,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 44,
            color: Color(0xFF9AA1B0),
          ),
          SizedBox(height: 11),
          Text(
            'No alerts found',
            style: TextStyle(
              color: Color(0xFF30384A),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Everything looks clear for the selected filters.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7A8292),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmartIntervention() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF0F1FF),
            Color(0xFFF8F8FF),
          ],
        ),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFDDE0FF),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF5B5FEF),
            size: 24,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Intervention',
                  style: TextStyle(
                    color: Color(0xFF4D52D7),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'ResourceX detected that targeted provider outreach could resolve the highest-priority technology and medical requirements faster.',
                  style: TextStyle(
                    color: Color(0xFF697183),
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDetails(Map<String, dynamic> alert) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F1FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        alert['icon'] as IconData,
                        color: const Color(0xFF5B5FEF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        alert['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF202A3C),
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildDetailRow(
                  'Requirement',
                  alert['requirement'] as String,
                ),
                buildDetailRow(
                  'Alert Type',
                  alert['type'] as String,
                ),
                buildDetailRow(
                  'Priority',
                  alert['priority'] as String,
                ),
                buildDetailRow(
                  'Detected',
                  alert['time'] as String,
                ),
                buildDetailRow(
                  'Status',
                  alert['resolved'] == true
                      ? 'Resolved'
                      : 'Needs Attention',
                ),
                const SizedBox(height: 12),
                const Text(
                  'What happened?',
                  style: TextStyle(
                    color: Color(0xFF30384A),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  alert['description'] as String,
                  style: const TextStyle(
                    color: Color(0xFF777F90),
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FC),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Color(0xFFD58931),
                        size: 20,
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recommended Action',
                              style: TextStyle(
                                color: Color(0xFF4C5567),
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              alert['action'] as String,
                              style: const TextStyle(
                                color: Color(0xFF7A8292),
                                fontSize: 9,
                                height: 1.5,
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
                          showSnackBar('Alert snoozed for 24 hours');
                        },
                        icon: const Icon(
                          Icons.snooze_rounded,
                          size: 16,
                        ),
                        label: const Text('Snooze'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          resolveAlert(alert);
                        },
                        icon: const Icon(
                          Icons.check_rounded,
                          size: 16,
                        ),
                        label: const Text('Resolve'),
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

  Widget buildDetailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF7B8392),
              fontSize: 10,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF30384A),
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resolveAlert(Map<String, dynamic> alert) {
    setState(() {
      alert['resolved'] = true;
      alert['priority'] = 'Resolved';
    });

    showSnackBar('Alert marked as resolved');
  }

  void showAlertSettings() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alert Settings',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              buildSetting(
                Icons.notifications_active_outlined,
                'Deadline Alerts',
                'Notify before a requirement reaches its deadline.',
              ),
              buildSetting(
                Icons.warning_amber_outlined,
                'Overdue Detection',
                'Automatically identify delayed requirements.',
              ),
              buildSetting(
                Icons.people_outline_rounded,
                'Low Response Alerts',
                'Detect requirements with low provider activity.',
              ),
              buildSetting(
                Icons.auto_awesome_outlined,
                'Smart Suggestions',
                'Receive recommended intervention actions.',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Save Settings'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSetting(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF5B5FEF),
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
                    color: Color(0xFF30384A),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF858C9B),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  void showCreateAlert() {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Custom Alert',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Create a monitoring rule for an important requirement.',
                style: TextStyle(
                  color: Color(0xFF7A8292),
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 17),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Alert name',
                  hintText: 'Example: Notify if match rate falls',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: 'Deadline',
                decoration: InputDecoration(
                  labelText: 'Alert type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                items: filters
                    .where((item) => item != 'All')
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    showSnackBar('Custom alert created');
                  },
                  icon: const Icon(Icons.add_alert_rounded),
                  label: const Text('Create Alert'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> refreshAlerts() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    showSnackBar('Smart alerts refreshed');
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}