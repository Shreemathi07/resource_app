  import 'package:flutter/material.dart';

class RequirementPriorityTriageScreen extends StatefulWidget {
  const RequirementPriorityTriageScreen({super.key});

  @override
  State<RequirementPriorityTriageScreen> createState() =>
      _RequirementPriorityTriageScreenState();
}

class _RequirementPriorityTriageScreenState
    extends State<RequirementPriorityTriageScreen> {
  int selectedTab = 0;
  int selectedPeriod = 1;
  String selectedPriority = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Triage Queue',
    'Critical',
    'Analytics',
    'Insights',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> priorities = [
    'All',
    'Critical',
    'High',
    'Medium',
    'Low',
  ];

  final List<Map<String, dynamic>> requirements = [
    {
      'title': 'Emergency Study Material',
      'requester': 'VIT Student Support',
      'category': 'Education',
      'location': 'Vellore',
      'people': 84,
      'quantity': '120 kits',
      'deadline': 'Today, 6:00 PM',
      'priority': 'Critical',
      'score': 96,
      'progress': 0.32,
      'affected': '84 people',
      'shortage': 'Severe',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Community Meal Support',
      'requester': 'Hope Community Center',
      'category': 'Food',
      'location': 'Katpadi',
      'people': 65,
      'quantity': '180 meals',
      'deadline': 'Tomorrow, 11:00 AM',
      'priority': 'High',
      'score': 88,
      'progress': 0.54,
      'affected': '65 people',
      'shortage': 'High',
      'icon': Icons.restaurant_outlined,
    },
    {
      'title': 'Desktop Computers for Learning',
      'requester': 'Digital Learning Hub',
      'category': 'Technology',
      'location': 'Sathuvachari',
      'people': 32,
      'quantity': '15 devices',
      'deadline': 'Sep 9, 4:00 PM',
      'priority': 'High',
      'score': 84,
      'progress': 0.67,
      'affected': '32 people',
      'shortage': 'High',
      'icon': Icons.computer_outlined,
    },
    {
      'title': 'Medical Equipment Requirement',
      'requester': 'Community Health Team',
      'category': 'Healthcare',
      'location': 'Vellore',
      'people': 21,
      'quantity': '8 units',
      'deadline': 'Sep 10, 10:00 AM',
      'priority': 'Medium',
      'score': 72,
      'progress': 0.41,
      'affected': '21 people',
      'shortage': 'Moderate',
      'icon': Icons.health_and_safety_outlined,
    },
    {
      'title': 'Notebook Collection',
      'requester': 'Student Resource Club',
      'category': 'Stationery',
      'location': 'Gandhi Nagar',
      'people': 48,
      'quantity': '400 notebooks',
      'deadline': 'Sep 12, 3:00 PM',
      'priority': 'Medium',
      'score': 64,
      'progress': 0.76,
      'affected': '48 people',
      'shortage': 'Moderate',
      'icon': Icons.menu_book_outlined,
    },
    {
      'title': 'Community Gardening Tools',
      'requester': 'Green Neighborhood',
      'category': 'Tools',
      'location': 'Katpadi',
      'people': 18,
      'quantity': '12 tools',
      'deadline': 'Sep 16, 9:00 AM',
      'priority': 'Low',
      'score': 42,
      'progress': 0.83,
      'affected': '18 people',
      'shortage': 'Low',
      'icon': Icons.yard_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredRequirements {
    return requirements.where((requirement) {
      final query = searchQuery.toLowerCase();
      final title = requirement['title'].toString().toLowerCase();
      final requester = requirement['requester'].toString().toLowerCase();
      final category = requirement['category'].toString().toLowerCase();

      final matchesSearch = query.isEmpty ||
          title.contains(query) ||
          requester.contains(query) ||
          category.contains(query);

      final matchesPriority = selectedPriority == 'All' ||
          requirement['priority'] == selectedPriority;

      return matchesSearch && matchesPriority;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Priority & Triage',
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
        onPressed: _showCreatePrioritySheet,
        icon: const Icon(Icons.add_alert_outlined),
        label: const Text('Prioritize'),
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
                _buildHeroCard(scheme),
                const SizedBox(height: 18),
                _buildSearchBar(),
                const SizedBox(height: 14),
                _buildPeriodSelector(),
                const SizedBox(height: 18),
                _buildPriorityOverview(),
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

  Widget _buildHeroCard(ColorScheme scheme) {
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
                  Icons.priority_high_rounded,
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
                  'Smart Triage',
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
            'Requirement Priority Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Identify the most urgent community requirements using deadline, impact, shortage and fulfillment signals.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('42', 'Active'),
              _heroMetric('6', 'Critical'),
              _heroMetric('91%', 'Accuracy'),
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
        hintText: 'Search requirements, categories or requesters...',
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

  Widget _buildPriorityOverview() {
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
                  color: Colors.red.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Priority Health',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Current requirement urgency distribution',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '84%',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              _priorityCount('6', 'Critical', Colors.red),
              _priorityCount('11', 'High', Colors.orange),
              _priorityCount('17', 'Medium', Colors.amber.shade700),
              _priorityCount('8', 'Low', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priorityCount(
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
        return _buildCriticalTab();
      case 2:
        return _buildAnalyticsTab();
      case 3:
        return _buildInsightsTab();
      default:
        return _buildTriageQueue();
    }
  }

  Widget _buildTriageQueue() {
    final items = filteredRequirements;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Smart Triage Queue',
          'Requirements ranked by urgency',
          Icons.sort_rounded,
        ),
        const SizedBox(height: 12),
        _buildFilterChips(),
        const SizedBox(height: 14),
        if (items.isEmpty)
          _buildEmptyState(
            Icons.search_off_rounded,
            'No requirements found',
            'Try another search or priority filter.',
          )
        else
          ...items.map(_buildRequirementCard),
      ],
    );
  }

  Widget _buildCriticalTab() {
    final critical = requirements.where(
      (requirement) =>
          requirement['priority'] == 'Critical' ||
          requirement['priority'] == 'High',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Critical Action Queue',
          'Requirements requiring immediate attention',
          Icons.crisis_alert_outlined,
        ),
        const SizedBox(height: 12),
        ...critical.map(_buildCriticalCard),
        const SizedBox(height: 18),
        _buildEscalationCard(),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Priority Analytics',
          'Requirement urgency trends',
          Icons.bar_chart_rounded,
        ),
        const SizedBox(height: 12),
        _buildPriorityTrend(),
        const SizedBox(height: 18),
        _buildPriorityDistribution(),
        const SizedBox(height: 18),
        _buildCategoryPriority(),
        const SizedBox(height: 18),
        _buildTriagePerformance(),
      ],
    );
  }

  Widget _buildInsightsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Triage Intelligence',
          'Smart signals detected from requirements',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          'Education requirements need faster matching',
          'Education requests have the highest combination of deadline pressure and affected users.',
          Icons.school_outlined,
          Colors.indigo,
        ),
        _buildInsightCard(
          'Two requirements may become critical',
          'Current fulfillment progress suggests two high-priority requirements could become overdue within 24 hours.',
          Icons.warning_amber_outlined,
          Colors.orange,
        ),
        _buildInsightCard(
          'Nearby providers can reduce urgency',
          'Three high-priority requirements have verified providers within the local delivery radius.',
          Icons.location_on_outlined,
          Colors.green,
        ),
        const SizedBox(height: 18),
        _buildSmartRecommendation(),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: priorities.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final priority = priorities[index];
          final selected = selectedPriority == priority;

          return FilterChip(
            label: Text(priority),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedPriority = priority;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildRequirementCard(Map<String, dynamic> requirement) {
    final priority = requirement['priority'].toString();
    final priorityColor = _priorityColor(priority);
    final score = requirement['score'] as int;
    final progress = requirement['progress'] as double;

    return GestureDetector(
      onTap: () => _showRequirementDetails(requirement),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: priority == 'Critical'
                ? Colors.red.withValues(alpha: 0.25)
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
                    requirement['icon'] as IconData,
                    color: priorityColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requirement['title'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        requirement['requester'].toString(),
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
                          Text(
                            requirement['location'].toString(),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _priorityBadge(
                  priority,
                  priorityColor,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _infoItem(
                  Icons.groups_outlined,
                  requirement['affected'].toString(),
                ),
                _infoItem(
                  Icons.inventory_2_outlined,
                  requirement['quantity'].toString(),
                ),
                _infoItem(
                  Icons.schedule_outlined,
                  requirement['deadline'].toString(),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Text(
                  'Fulfillment',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Priority score $score',
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _shortageColor(
                      requirement['shortage'].toString(),
                    ).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${requirement['shortage']} shortage',
                    style: TextStyle(
                      color: _shortageColor(
                        requirement['shortage'].toString(),
                      ),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _showQuickActions(requirement),
                  icon: const Icon(Icons.more_horiz_rounded),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String text,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriticalCard(Map<String, dynamic> requirement) {
    final color = _priorityColor(
      requirement['priority'].toString(),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.17),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.priority_high_rounded,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  requirement['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Deadline: ${requirement['deadline']}',
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${requirement['people']} people affected • ${requirement['quantity']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showQuickActions(requirement),
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildEscalationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.13),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.notification_important_outlined,
            color: Colors.red,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Escalation Recommended',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Two critical requirements have no confirmed provider yet. Consider escalating them to nearby verified organizations.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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

  Widget _buildPriorityTrend() {
    final values = [0.42, 0.58, 0.51, 0.70, 0.63, 0.82, 0.76];

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
            'Urgency Trend',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Average priority score over the selected period',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: values.asMap().entries.map((entry) {
                final index = entry.key;
                final value = entry.value;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${(value * 100).round()}',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 20,
                        height: 110 * value,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'D${index + 1}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityDistribution() {
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
            'Priority Distribution',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 17),
          _distributionRow('Critical', 0.14, Colors.red),
          _distributionRow('High', 0.26, Colors.orange),
          _distributionRow('Medium', 0.40, Colors.amber.shade700),
          _distributionRow('Low', 0.20, Colors.green),
        ],
      ),
    );
  }

  Widget _distributionRow(
    String label,
    double value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          SizedBox(
            width: 65,
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
                color: color,
                backgroundColor: color.withValues(alpha: 0.10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${(value * 100).round()}%',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPriority() {
    final categories = [
      ['Education', '89', Colors.indigo],
      ['Food', '82', Colors.orange],
      ['Healthcare', '76', Colors.green],
      ['Technology', '71', Colors.teal],
    ];

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
            'Priority by Category',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          ...categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: category[2] as Color,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      category[0].toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    category[1].toString(),
                    style: TextStyle(
                      color: category[2] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
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

  Widget _buildTriagePerformance() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.12),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Triage Performance',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _PerformanceMetric(
                  value: '91%',
                  label: 'Accuracy',
                ),
              ),
              Expanded(
                child: _PerformanceMetric(
                  value: '2.4h',
                  label: 'Avg. Response',
                ),
              ),
              Expanded(
                child: _PerformanceMetric(
                  value: '87%',
                  label: 'Resolved',
                ),
              ),
            ],
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

  Widget _buildSmartRecommendation() {
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
                  'Smart Triage Recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Prioritize requirements with short deadlines, severe shortages and a high number of affected people. Matching nearby verified providers can reduce the priority score quickly.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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

  Widget _priorityBadge(
    String priority,
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
        priority,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
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
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber.shade800;
      default:
        return Colors.green;
    }
  }

  Color _shortageColor(String shortage) {
    switch (shortage) {
      case 'Severe':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Moderate':
        return Colors.amber.shade800;
      default:
        return Colors.green;
    }
  }

  void _showRequirementDetails(Map<String, dynamic> requirement) {
    final priority = requirement['priority'].toString();
    final color = _priorityColor(priority);

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
                        requirement['icon'] as IconData,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        requirement['title'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    _priorityBadge(
                      priority,
                      color,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.person_outline,
                  'Requester',
                  requirement['requester'].toString(),
                ),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  requirement['category'].toString(),
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  requirement['location'].toString(),
                ),
                _detailRow(
                  Icons.groups_outlined,
                  'People affected',
                  requirement['people'].toString(),
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Required quantity',
                  requirement['quantity'].toString(),
                ),
                _detailRow(
                  Icons.schedule_outlined,
                  'Deadline',
                  requirement['deadline'].toString(),
                ),
                _detailRow(
                  Icons.warning_amber_outlined,
                  'Shortage',
                  requirement['shortage'].toString(),
                ),
                _detailRow(
                  Icons.auto_awesome_outlined,
                  'Priority score',
                  requirement['score'].toString(),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Fulfillment Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: requirement['progress'] as double,
                    minHeight: 9,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${((requirement['progress'] as double) * 100).round()}% fulfilled',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar('Requirement escalated');
                        },
                        icon: const Icon(
                          Icons.arrow_upward_rounded,
                        ),
                        label: const Text('Escalate'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar('Provider matching started');
                        },
                        icon: const Icon(
                          Icons.auto_awesome_outlined,
                        ),
                        label: const Text('Match'),
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

  void _showQuickActions(Map<String, dynamic> requirement) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.auto_awesome_outlined),
                title: const Text('Find matching providers'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Searching for matching providers');
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_upward_rounded),
                title: const Text('Escalate requirement'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Requirement escalated');
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Adjust priority'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showPriorityEditor(requirement);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add_alt_1_outlined),
                title: const Text('Assign coordinator'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Coordinator assignment opened');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPriorityEditor(Map<String, dynamic> requirement) {
    String priority = requirement['priority'].toString();

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
                    'Adjust Priority',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    requirement['title'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    initialValue: priority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Critical',
                        child: Text('Critical'),
                      ),
                      DropdownMenuItem(
                        value: 'High',
                        child: Text('High'),
                      ),
                      DropdownMenuItem(
                        value: 'Medium',
                        child: Text('Medium'),
                      ),
                      DropdownMenuItem(
                        value: 'Low',
                        child: Text('Low'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setSheetState(() {
                          priority = value;
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
                          'Priority updated to $priority',
                        );
                      },
                      child: const Text(
                        'Save Priority',
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
                  'Priority Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                ...priorities.map(
                  (priority) => ListTile(
                    leading: Icon(
                      priority == 'Critical'
                          ? Icons.crisis_alert_outlined
                          : priority == 'High'
                              ? Icons.priority_high_rounded
                              : priority == 'Medium'
                                  ? Icons.warning_amber_outlined
                                  : priority == 'Low'
                                      ? Icons.low_priority_outlined
                                      : Icons.all_inbox_outlined,
                    ),
                    title: Text(priority),
                    trailing: selectedPriority == priority
                        ? const Icon(Icons.check_rounded)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedPriority = priority;
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

  void _showCreatePrioritySheet() {
    String priority = 'High';

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
                      'Create Priority Alert',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Create a manual triage alert for a requirement.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Requirement',
                        hintText: 'Enter requirement name',
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
                      initialValue: priority,
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Critical',
                          child: Text('Critical'),
                        ),
                        DropdownMenuItem(
                          value: 'High',
                          child: Text('High'),
                        ),
                        DropdownMenuItem(
                          value: 'Medium',
                          child: Text('Medium'),
                        ),
                        DropdownMenuItem(
                          value: 'Low',
                          child: Text('Low'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            priority = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Reason',
                        hintText: 'Why does this requirement need attention?',
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
                            '$priority priority alert created',
                          );
                        },
                        icon: const Icon(Icons.add_alert_outlined),
                        label: const Text(
                          'Create Alert',
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
                  'Triage Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.crisis_alert_outlined,
                  'A critical requirement needs immediate matching',
                  'Just now',
                ),
                _notificationItem(
                  Icons.schedule_outlined,
                  'High-priority deadline approaching',
                  '24 min ago',
                ),
                _notificationItem(
                  Icons.auto_awesome_outlined,
                  'New provider recommendation available',
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

    _showSnackBar('Priority data refreshed');
  }
}

class _PerformanceMetric extends StatelessWidget {
  final String value;
  final String label;

  const _PerformanceMetric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.green,
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
    );
  }
}