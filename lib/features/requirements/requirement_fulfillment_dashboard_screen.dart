import 'package:flutter/material.dart';

class RequirementFulfillmentDashboardScreen extends StatefulWidget {
  const RequirementFulfillmentDashboardScreen({super.key});

  @override
  State<RequirementFulfillmentDashboardScreen> createState() =>
      _RequirementFulfillmentDashboardScreenState();
}

class _RequirementFulfillmentDashboardScreenState
    extends State<RequirementFulfillmentDashboardScreen> {
  int selectedTab = 0;
  String selectedPeriod = '30 Days';

  final List<Map<String, dynamic>> requirements = [
    {
      'title': 'Campus Laptop Support',
      'category': 'Electronics',
      'progress': 0.86,
      'status': 'On Track',
      'required': 50,
      'fulfilled': 43,
      'deadline': '18 Sep',
      'provider': 'VIT Tech Community',
    },
    {
      'title': 'Community Meal Support',
      'category': 'Food',
      'progress': 0.64,
      'status': 'Attention',
      'required': 500,
      'fulfilled': 320,
      'deadline': '12 Sep',
      'provider': 'Community Kitchen',
    },
    {
      'title': 'Study Material Distribution',
      'category': 'Education',
      'progress': 0.94,
      'status': 'Almost Complete',
      'required': 200,
      'fulfilled': 188,
      'deadline': '10 Sep',
      'provider': 'Learning Circle',
    },
    {
      'title': 'Medical Supply Support',
      'category': 'Healthcare',
      'progress': 0.72,
      'status': 'Monitoring',
      'required': 120,
      'fulfilled': 86,
      'deadline': '22 Sep',
      'provider': 'Care Network',
    },
  ];

  final List<Map<String, dynamic>> alerts = [
    {
      'title': '9 laptops still required',
      'subtitle': 'Campus Laptop Support has a remaining quantity gap.',
      'priority': 'High',
      'icon': Icons.inventory_2_outlined,
    },
    {
      'title': 'Meal support needs attention',
      'subtitle': 'Collection rate is below the expected fulfillment pace.',
      'priority': 'Medium',
      'icon': Icons.restaurant_outlined,
    },
    {
      'title': 'Quality verification pending',
      'subtitle': '32 collected resources are waiting for inspection.',
      'priority': 'Medium',
      'icon': Icons.verified_outlined,
    },
  ];

  final List<Map<String, dynamic>> actions = [
    {
      'title': 'Review pending matches',
      'subtitle': '12 provider matches are waiting for confirmation.',
      'icon': Icons.people_alt_outlined,
    },
    {
      'title': 'Schedule upcoming handovers',
      'subtitle': '5 requirements are ready for delivery coordination.',
      'icon': Icons.event_available_outlined,
    },
    {
      'title': 'Verify collected resources',
      'subtitle': '41 resources are currently in the verification pipeline.',
      'icon': Icons.fact_check_outlined,
    },
    {
      'title': 'Contact delayed providers',
      'subtitle': '3 providers have missed their expected update window.',
      'icon': Icons.chat_outlined,
    },
  ];

  final List<Map<String, dynamic>> insights = [
    {
      'title': 'Fulfillment health is strong',
      'description':
          'Overall completion has increased steadily and most active requirements are on track.',
      'icon': Icons.trending_up_rounded,
    },
    {
      'title': 'Food requirements need attention',
      'description':
          'Meal-related requirements are showing slower provider response compared with other categories.',
      'icon': Icons.warning_amber_rounded,
    },
    {
      'title': 'Education has the highest success rate',
      'description':
          'Education resources are reaching fulfillment faster with strong provider participation.',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Early verification can reduce delays',
      'description':
          'Requirements with early quality checks reach handover readiness more consistently.',
      'icon': Icons.shield_outlined,
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
          'Fulfillment Dashboard',
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
              _buildPeriodSelector(),
              const SizedBox(height: 18),
              _buildTabs(),
              const SizedBox(height: 18),
              if (selectedTab == 0) ...[
                _buildHealthOverview(),
                const SizedBox(height: 18),
                _buildKpiGrid(),
                const SizedBox(height: 18),
                _buildRequirementProgress(),
                const SizedBox(height: 18),
                _buildAttentionAlerts(),
                const SizedBox(height: 18),
                _buildSmartActions(),
              ],
              if (selectedTab == 1) ...[
                _buildRequirementProgress(),
                const SizedBox(height: 18),
                _buildCategoryPerformance(),
                const SizedBox(height: 18),
                _buildFulfillmentFunnel(),
              ],
              if (selectedTab == 2) ...[
                _buildAttentionAlerts(),
                const SizedBox(height: 18),
                _buildActionQueue(),
                const SizedBox(height: 18),
                _buildDeadlineMonitor(),
              ],
              if (selectedTab == 3) ...[
                _buildInsights(),
                const SizedBox(height: 18),
                _buildForecast(),
                const SizedBox(height: 18),
                _buildRecommendations(),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showQuickActions,
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.bolt_rounded),
        label: const Text('Quick Actions'),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF172554),
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
                  color: Colors.white.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.dashboard_customize_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              _heroBadge('Healthy Network'),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Requirement Fulfillment',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'A complete command center for monitoring requirements from matching to successful handover.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.80),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('286', 'Active'),
              _heroDivider(),
              _heroMetric('76%', 'Fulfilled'),
              _heroDivider(),
              _heroMetric('94%', 'On-Time'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroBadge(String text) {
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
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
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
              fontSize: 10,
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

  Widget _buildPeriodSelector() {
    const periods = [
      '7 Days',
      '30 Days',
      '3 Months',
      '1 Year',
    ];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: periods.map((period) {
          final selected = selectedPeriod == period;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF4F46E5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : const Color(0xFF7B8496),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabs() {
    const tabs = [
      'Overview',
      'Performance',
      'Alerts',
      'Intelligence',
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

  Widget _buildHealthOverview() {
    return _sectionCard(
      title: 'Fulfillment Health',
      icon: Icons.health_and_safety_outlined,
      child: Row(
        children: [
          SizedBox(
            width: 116,
            height: 116,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 108,
                  height: 108,
                  child: CircularProgressIndicator(
                    value: 0.91,
                    strokeWidth: 10,
                    backgroundColor: const Color(0xFFE8EAF2),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF4F46E5),
                    ),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '91',
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Health Score',
                      style: TextStyle(
                        color: Color(0xFF7B8496),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _healthRow(
                  'Fulfillment rate',
                  '76%',
                  Icons.trending_up_rounded,
                ),
                const SizedBox(height: 12),
                _healthRow(
                  'Provider response',
                  '89%',
                  Icons.people_outline_rounded,
                ),
                const SizedBox(height: 12),
                _healthRow(
                  'Handover success',
                  '97%',
                  Icons.handshake_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _healthRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF4F46E5),
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF596273),
              fontSize: 11,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildKpiGrid() {
    return Column(
      children: [
        Row(
          children: [
            _kpiBox(
              '286',
              'Total Requirements',
              Icons.assignment_outlined,
            ),
            const SizedBox(width: 10),
            _kpiBox(
              '218',
              'Fulfilled',
              Icons.check_circle_outline_rounded,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _kpiBox(
              '42',
              'In Progress',
              Icons.timelapse_rounded,
            ),
            const SizedBox(width: 10),
            _kpiBox(
              '26',
              'Unmet',
              Icons.error_outline_rounded,
            ),
          ],
        ),
      ],
    );
  }

  Widget _kpiBox(
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: _cardDecoration(),
        child: Row(
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
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
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

  Widget _buildRequirementProgress() {
    return _sectionCard(
      title: 'Active Requirement Progress',
      icon: Icons.bar_chart_rounded,
      action: TextButton(
        onPressed: _showAllRequirements,
        child: const Text('View All'),
      ),
      child: Column(
        children: requirements.map((requirement) {
          final progress = requirement['progress'] as double;
          final status = requirement['status'] as String;

          return GestureDetector(
            onTap: () => _showRequirementDetails(requirement),
            child: Container(
              margin: const EdgeInsets.only(bottom: 13),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
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
                          Icons.inventory_2_outlined,
                          color: Color(0xFF4F46E5),
                          size: 19,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requirement['title'] as String,
                              style: const TextStyle(
                                color: Color(0xFF172033),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${requirement['category']} • ${requirement['provider']}',
                              style: const TextStyle(
                                color: Color(0xFF7B8496),
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _statusBadge(status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 7,
                            backgroundColor: const Color(0xFFE6E8EF),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Text(
                        '${requirement['fulfilled']} / ${requirement['required']} fulfilled',
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 9,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Due ${requirement['deadline']}',
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color textColor;
    Color background;

    if (status == 'On Track') {
      textColor = const Color(0xFF15803D);
      background = const Color(0xFFDCFCE7);
    } else if (status == 'Attention') {
      textColor = const Color(0xFFB45309);
      background = const Color(0xFFFEF3C7);
    } else if (status == 'Almost Complete') {
      textColor = const Color(0xFF0369A1);
      background = const Color(0xFFE0F2FE);
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
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 8,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildAttentionAlerts() {
    return _sectionCard(
      title: 'Needs Attention',
      icon: Icons.notifications_active_outlined,
      action: TextButton(
        onPressed: () {
          setState(() {
            selectedTab = 2;
          });
        },
        child: const Text('Manage'),
      ),
      child: Column(
        children: alerts.map((alert) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFFDE68A),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFD97706),
                  size: 21,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF78350F),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        alert['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF92400E),
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                _priorityChip(alert['priority'] as String),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _priorityChip(String priority) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: priority == 'High'
            ? const Color(0xFFFEE2E2)
            : const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: priority == 'High'
              ? const Color(0xFFB91C1C)
              : const Color(0xFFB45309),
          fontSize: 8,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildSmartActions() {
    return _sectionCard(
      title: 'Smart Action Queue',
      icon: Icons.auto_awesome_rounded,
      child: Column(
        children: actions.map((action) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    action['icon'] as IconData,
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
                        action['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF312E81),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        action['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF625F78),
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF6366F1),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryPerformance() {
    return _sectionCard(
      title: 'Category Performance',
      icon: Icons.category_outlined,
      child: Column(
        children: [
          _categoryRow('Education', '91%', 0.91),
          _categoryRow('Electronics', '86%', 0.86),
          _categoryRow('Healthcare', '78%', 0.78),
          _categoryRow('Food', '64%', 0.64),
          _categoryRow('Household', '59%', 0.59),
        ],
      ),
    );
  }

  Widget _categoryRow(
    String title,
    String value,
    double progress,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF596273),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: const Color(0xFFE8EAF0),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF4F46E5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFulfillmentFunnel() {
    return _sectionCard(
      title: 'Fulfillment Funnel',
      icon: Icons.filter_alt_outlined,
      child: Column(
        children: [
          _funnelRow(
            'Requirements created',
            '286',
            1.0,
          ),
          _funnelRow(
            'Matched',
            '252',
            0.88,
          ),
          _funnelRow(
            'Confirmed',
            '231',
            0.81,
          ),
          _funnelRow(
            'In fulfillment',
            '218',
            0.76,
          ),
          _funnelRow(
            'Successfully handed over',
            '205',
            0.72,
          ),
        ],
      ),
    );
  }

  Widget _funnelRow(
    String title,
    String value,
    double progress,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF596273),
                fontSize: 10,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation(
                  Color(0xFF6366F1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionQueue() {
    return _sectionCard(
      title: 'Priority Action Queue',
      icon: Icons.bolt_outlined,
      child: Column(
        children: actions.map((action) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFEEF2FF),
              child: Icon(
                action['icon'] as IconData,
                color: const Color(0xFF4F46E5),
                size: 19,
              ),
            ),
            title: Text(
              action['title'] as String,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              action['subtitle'] as String,
              style: const TextStyle(
                color: Color(0xFF7B8496),
                fontSize: 10,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              size: 19,
            ),
            onTap: () => _showMessage(
              '${action['title']} selected',
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDeadlineMonitor() {
    return _sectionCard(
      title: 'Deadline Monitor',
      icon: Icons.calendar_month_outlined,
      child: Column(
        children: [
          _deadlineRow(
            'Study Material Distribution',
            '10 Sep',
            '2 days',
            const Color(0xFFDC2626),
          ),
          _deadlineRow(
            'Community Meal Support',
            '12 Sep',
            '4 days',
            const Color(0xFFD97706),
          ),
          _deadlineRow(
            'Campus Laptop Support',
            '18 Sep',
            '10 days',
            const Color(0xFF16A34A),
          ),
          _deadlineRow(
            'Medical Supply Support',
            '22 Sep',
            '14 days',
            const Color(0xFF16A34A),
          ),
        ],
      ),
    );
  }

  Widget _deadlineRow(
    String title,
    String date,
    String remaining,
    Color color,
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
            Icons.event_outlined,
            color: color,
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
                    color: Color(0xFF172033),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Deadline: $date',
                  style: const TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Text(
            remaining,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsights() {
    return _sectionCard(
      title: 'Fulfillment Intelligence',
      icon: Icons.psychology_alt_outlined,
      child: Column(
        children: insights.map((insight) {
          return Container(
            margin: const EdgeInsets.only(bottom: 11),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  insight['icon'] as IconData,
                  color: const Color(0xFF4F46E5),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF312E81),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        insight['description'] as String,
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
        }).toList(),
      ),
    );
  }

  Widget _buildForecast() {
    return _sectionCard(
      title: 'Fulfillment Forecast',
      icon: Icons.auto_graph_rounded,
      child: Column(
        children: [
          Row(
            children: [
              _forecastBox(
                '82%',
                'Expected next month',
                Icons.trending_up_rounded,
              ),
              const SizedBox(width: 10),
              _forecastBox(
                '18',
                'Potential delays',
                Icons.schedule_rounded,
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Based on recent fulfillment activity, ResourceX expects the network completion rate to continue improving if pending matches and verification tasks are resolved on time.',
            style: TextStyle(
              color: Color(0xFF596273),
              fontSize: 11,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forecastBox(
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
          border: Border.all(
            color: const Color(0xFFE8EAF0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 20,
            ),
            const SizedBox(height: 9),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
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
    );
  }

  Widget _buildRecommendations() {
    return _sectionCard(
      title: 'Recommended Actions',
      icon: Icons.lightbulb_outline_rounded,
      child: Column(
        children: [
          _recommendation(
            'Increase provider outreach',
            'Focus on unmet electronics and food requirements.',
          ),
          _recommendation(
            'Move verification earlier',
            'Start quality checks immediately after collection.',
          ),
          _recommendation(
            'Automate deadline reminders',
            'Notify participants before requirements enter the critical window.',
          ),
        ],
      ),
    );
  }

  Widget _recommendation(
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0xFF4F46E5),
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
                    color: Color(0xFF172033),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
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

  void _showRequirementDetails(
    Map<String, dynamic> requirement,
  ) {
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
                Text(
                  requirement['title'] as String,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${requirement['category']} • ${requirement['provider']}',
                  style: const TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 18),
                _detailRow(
                  'Fulfillment',
                  '${requirement['fulfilled']} / ${requirement['required']}',
                ),
                _detailRow(
                  'Progress',
                  '${((requirement['progress'] as double) * 100).round()}%',
                ),
                _detailRow(
                  'Status',
                  requirement['status'] as String,
                ),
                _detailRow(
                  'Deadline',
                  requirement['deadline'] as String,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _showMessage('Requirement workspace opened');
                    },
                    child: const Text('Open Requirement'),
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
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF7B8496),
                fontSize: 11,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  void _showAllRequirements() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            children: requirements.map((requirement) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFEEF2FF),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: Color(0xFF4F46E5),
                  ),
                ),
                title: Text(
                  requirement['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  '${requirement['fulfilled']} / ${requirement['required']} fulfilled',
                ),
                trailing: _statusBadge(
                  requirement['status'] as String,
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showRequirementDetails(requirement);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showQuickActions() {
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
              children: [
                _quickActionTile(
                  'Create Requirement',
                  Icons.add_task_rounded,
                  () {
                    Navigator.pop(sheetContext);
                    _showMessage('Requirement creation opened');
                  },
                ),
                _quickActionTile(
                  'Find Smart Matches',
                  Icons.auto_awesome_rounded,
                  () {
                    Navigator.pop(sheetContext);
                    _showMessage('Smart matching opened');
                  },
                ),
                _quickActionTile(
                  'Schedule Handover',
                  Icons.event_available_rounded,
                  () {
                    Navigator.pop(sheetContext);
                    _showMessage('Handover scheduling opened');
                  },
                ),
                _quickActionTile(
                  'Generate Report',
                  Icons.description_outlined,
                  () {
                    Navigator.pop(sheetContext);
                    _showMessage('Fulfillment report generated');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _quickActionTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFEEF2FF),
        child: Icon(
          icon,
          color: const Color(0xFF4F46E5),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF172033),
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
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
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  title: Text('3 fulfillment alerts'),
                  subtitle: Text('Review priority requirements'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.event_outlined,
                    color: Colors.indigo,
                  ),
                  title: Text('5 handovers ready'),
                  subtitle: Text('Schedule delivery coordination'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.verified_outlined,
                    color: Colors.green,
                  ),
                  title: Text('41 resources collected'),
                  subtitle: Text('Verification pipeline updated'),
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
          title: const Text('Fulfillment Dashboard'),
          content: const Text(
            'This dashboard provides a complete overview of requirement fulfillment, performance, alerts, deadlines and intelligent actions across the ResourceX network.',
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

    _showMessage('Fulfillment dashboard refreshed');
  }
}