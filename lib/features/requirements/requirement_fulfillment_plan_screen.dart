import 'package:flutter/material.dart';

class RequirementFulfillmentPlanScreen extends StatefulWidget {
  const RequirementFulfillmentPlanScreen({super.key});

  @override
  State<RequirementFulfillmentPlanScreen> createState() =>
      _RequirementFulfillmentPlanScreenState();
}

class _RequirementFulfillmentPlanScreenState
    extends State<RequirementFulfillmentPlanScreen> {
  int selectedTab = 0;
  String selectedPlan = 'Campus Laptop Requirement';
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Campus Laptop Requirement',
      'category': 'Electronics',
      'progress': 0.82,
      'status': 'On Track',
      'deadline': '18 Sep 2026',
      'quantity': '41 / 50',
      'provider': 'VIT Tech Community',
      'location': 'Vellore Campus',
      'color': Colors.indigo,
    },
    {
      'title': 'Community Meal Support',
      'category': 'Food',
      'progress': 0.64,
      'status': 'Attention',
      'deadline': '12 Sep 2026',
      'quantity': '320 / 500',
      'provider': 'Community Kitchen',
      'location': 'Katpadi',
      'color': Colors.orange,
    },
    {
      'title': 'Student Study Materials',
      'category': 'Education',
      'progress': 0.94,
      'status': 'Almost Complete',
      'deadline': '10 Sep 2026',
      'quantity': '188 / 200',
      'provider': 'Learning Circle',
      'location': 'Vellore',
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> milestones = [
    {
      'title': 'Requirement confirmed',
      'subtitle': 'Agreement successfully finalized',
      'done': true,
    },
    {
      'title': 'Provider preparation',
      'subtitle': 'Resources are being prepared',
      'done': true,
    },
    {
      'title': 'Quantity collection',
      'subtitle': '41 of 50 resources collected',
      'done': true,
    },
    {
      'title': 'Quality verification',
      'subtitle': 'Final inspection in progress',
      'done': false,
    },
    {
      'title': 'Handover',
      'subtitle': 'Schedule final resource handover',
      'done': false,
    },
  ];

  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Verify collected laptops',
      'owner': 'Provider',
      'priority': 'High',
      'done': true,
    },
    {
      'title': 'Confirm remaining quantity',
      'owner': 'Seeker',
      'priority': 'High',
      'done': false,
    },
    {
      'title': 'Complete quality inspection',
      'owner': 'Verification Team',
      'priority': 'Medium',
      'done': false,
    },
    {
      'title': 'Prepare handover location',
      'owner': 'Coordinator',
      'priority': 'Medium',
      'done': false,
    },
    {
      'title': 'Confirm final handover time',
      'owner': 'Both Parties',
      'priority': 'Low',
      'done': false,
    },
  ];

  final List<Map<String, dynamic>> activities = [
    {
      'title': '41 resources collected',
      'subtitle': 'Provider updated fulfillment quantity',
      'time': '24 min ago',
      'icon': Icons.inventory_2_outlined,
    },
    {
      'title': 'Quality review started',
      'subtitle': 'Verification team opened inspection',
      'time': '1 hr ago',
      'icon': Icons.verified_outlined,
    },
    {
      'title': 'Deadline reminder generated',
      'subtitle': '4 days remaining for fulfillment',
      'time': '3 hrs ago',
      'icon': Icons.notifications_active_outlined,
    },
    {
      'title': 'Agreement confirmed',
      'subtitle': 'Both parties accepted the fulfillment terms',
      'time': 'Yesterday',
      'icon': Icons.handshake_outlined,
    },
  ];

  final List<Map<String, dynamic>> recommendations = [
    {
      'title': 'Prioritize the remaining 9 laptops',
      'subtitle':
          'The current collection rate suggests a small quantity gap before the deadline.',
      'icon': Icons.priority_high_rounded,
    },
    {
      'title': 'Schedule quality verification today',
      'subtitle':
          'Completing inspection early will reduce handover-day delays.',
      'icon': Icons.fact_check_outlined,
    },
    {
      'title': 'Prepare a backup provider',
      'subtitle':
          'A secondary source can cover the remaining quantity if collection slows down.',
      'icon': Icons.alt_route_outlined,
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
          'Fulfillment Planning',
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
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              _buildHero(),
              const SizedBox(height: 18),
              _buildPlanSelector(),
              const SizedBox(height: 18),
              _buildTabs(),
              const SizedBox(height: 18),
              if (selectedTab == 0) ...[
                _buildProgressOverview(),
                const SizedBox(height: 18),
                _buildMilestoneTimeline(),
                const SizedBox(height: 18),
                _buildQuantityTracking(),
                const SizedBox(height: 18),
                _buildDeadlineCard(),
                const SizedBox(height: 18),
                _buildSmartRecommendations(),
              ],
              if (selectedTab == 1) ...[
                _buildTaskSection(),
                const SizedBox(height: 18),
                _buildAssignmentCard(),
                const SizedBox(height: 18),
                _buildDeliveryPreparation(),
              ],
              if (selectedTab == 2) ...[
                _buildActivitySection(),
                const SizedBox(height: 18),
                _buildFulfillmentHistory(),
              ],
              if (selectedTab == 3) ...[
                _buildPerformanceSummary(),
                const SizedBox(height: 18),
                _buildPlanInsights(),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreatePlan,
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('New Plan'),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF312E81),
            Color(0xFF4F46E5),
            Color(0xFF6366F1),
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
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.route_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              _statusPill('82% Fulfilled'),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Smart Fulfillment Planning',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Turn confirmed requirements into clear, trackable fulfillment plans.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('41', 'Collected'),
              _heroDivider(),
              _heroMetric('9', 'Remaining'),
              _heroDivider(),
              _heroMetric('4', 'Days Left'),
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
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroDivider() {
    return Container(
      height: 34,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white.withValues(alpha: 0.18),
    );
  }

  Widget _statusPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildPlanSelector() {
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
              Icons.assignment_turned_in_outlined,
              color: Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Active requirement',
                  style: TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedPlan,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showPlanSelector,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = ['Overview', 'Tasks', 'Activity', 'Performance'];

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
              labelStyle: TextStyle(
                color: selectedTab == index
                    ? Colors.white
                    : const Color(0xFF596273),
                fontWeight: FontWeight.w700,
              ),
              side: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressOverview() {
    return _sectionCard(
      title: 'Fulfillment Progress',
      icon: Icons.donut_large_rounded,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 112,
                height: 112,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 104,
                      height: 104,
                      child: CircularProgressIndicator(
                        value: 0.82,
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
                          '82%',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF172033),
                          ),
                        ),
                        Text(
                          'Complete',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF7B8496),
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
                  children: [
                    _progressRow('Resources collected', '41 / 50', 0.82),
                    const SizedBox(height: 12),
                    _progressRow('Verification', '32 / 41', 0.78),
                    const SizedBox(height: 12),
                    _progressRow('Handover readiness', '3 / 5', 0.60),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressRow(String title, String value, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF4F596B),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: const Color(0xFFE9EBF2),
            valueColor: const AlwaysStoppedAnimation(
              Color(0xFF4F46E5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneTimeline() {
    return _sectionCard(
      title: 'Fulfillment Milestones',
      icon: Icons.timeline_rounded,
      child: Column(
        children: List.generate(
          milestones.length,
          (index) {
            final milestone = milestones[index];
            final done = milestone['done'] as bool;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFEEF2FF),
                      ),
                      child: Icon(
                        done
                            ? Icons.check_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 18,
                        color: done
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF6366F1),
                      ),
                    ),
                    if (index != milestones.length - 1)
                      Container(
                        width: 2,
                        height: 43,
                        color: done
                            ? const Color(0xFFBBF7D0)
                            : const Color(0xFFE5E7EB),
                      ),
                  ],
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18, top: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone['title'] as String,
                          style: const TextStyle(
                            color: Color(0xFF172033),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          milestone['subtitle'] as String,
                          style: const TextStyle(
                            color: Color(0xFF7B8496),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuantityTracking() {
    return _sectionCard(
      title: 'Quantity Tracking',
      icon: Icons.inventory_outlined,
      action: TextButton(
        onPressed: _showQuantityUpdate,
        child: const Text('Update'),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _quantityBox('50', 'Required'),
              const SizedBox(width: 10),
              _quantityBox('41', 'Collected'),
              const SizedBox(width: 10),
              _quantityBox('9', 'Remaining'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFEA580C),
                  size: 19,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    '9 additional resources are needed to complete this requirement.',
                    style: TextStyle(
                      color: Color(0xFF9A3412),
                      fontSize: 12,
                      height: 1.4,
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

  Widget _quantityBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8EAF0)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
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

  Widget _buildDeadlineCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF172033),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.event_available_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fulfillment deadline',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '18 September 2026',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '4 days',
              style: TextStyle(
                color: Color(0xFF92400E),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartRecommendations() {
    return _sectionCard(
      title: 'Smart Action Recommendations',
      icon: Icons.auto_awesome_rounded,
      child: Column(
        children: recommendations.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          color: Color(0xFF312E81),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF625F78),
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
        }).toList(),
      ),
    );
  }

  Widget _buildTaskSection() {
    final filteredTasks = selectedFilter == 'All'
        ? tasks
        : tasks
            .where(
              (task) => task['priority'] == selectedFilter,
            )
            .toList();

    return _sectionCard(
      title: 'Fulfillment Tasks',
      icon: Icons.checklist_rounded,
      action: PopupMenuButton<String>(
        onSelected: (value) {
          setState(() {
            selectedFilter = value;
          });
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'All', child: Text('All Tasks')),
          PopupMenuItem(value: 'High', child: Text('High Priority')),
          PopupMenuItem(value: 'Medium', child: Text('Medium Priority')),
          PopupMenuItem(value: 'Low', child: Text('Low Priority')),
        ],
        child: const Icon(Icons.filter_list_rounded),
      ),
      child: Column(
        children: filteredTasks.map((task) {
          final done = task['done'] as bool;
          final priority = task['priority'] as String;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFE8EAF0)),
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
                const SizedBox(width: 2),
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
                      const SizedBox(height: 5),
                      Text(
                        task['owner'] as String,
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 11,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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

  Widget _buildAssignmentCard() {
    return _sectionCard(
      title: 'Task Assignment',
      icon: Icons.group_outlined,
      child: Column(
        children: [
          _assignmentRow(
            'Provider',
            'VIT Tech Community',
            Icons.business_center_outlined,
            '3 tasks',
          ),
          _assignmentRow(
            'Seeker',
            'Student Support Team',
            Icons.person_outline_rounded,
            '2 tasks',
          ),
          _assignmentRow(
            'Verification',
            'Quality Team',
            Icons.verified_user_outlined,
            '1 task',
          ),
          _assignmentRow(
            'Coordinator',
            'ResourceX Admin',
            Icons.manage_accounts_outlined,
            '1 task',
          ),
        ],
      ),
    );
  }

  Widget _assignmentRow(
    String role,
    String name,
    IconData icon,
    String tasksText,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: const Color(0xFFEEF2FF),
            child: Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 20,
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
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            tasksText,
            style: const TextStyle(
              color: Color(0xFF4F46E5),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPreparation() {
    return _sectionCard(
      title: 'Handover Preparation',
      icon: Icons.local_shipping_outlined,
      child: Column(
        children: [
          _checkRow('Handover location confirmed', true),
          _checkRow('Quantity verified', true),
          _checkRow('Resource condition documented', false),
          _checkRow('Participants confirmed', false),
          _checkRow('Digital receipt prepared', false),
        ],
      ),
    );
  }

  Widget _checkRow(String title, bool done) {
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
                    ? const Color(0xFF4B5563)
                    : const Color(0xFF172033),
                fontSize: 13,
                fontWeight: done ? FontWeight.w500 : FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return _sectionCard(
      title: 'Recent Fulfillment Activity',
      icon: Icons.history_rounded,
      child: Column(
        children: activities.map((activity) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
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
                        activity['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF172033),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF7B8496),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity['time'] as String,
                        style: const TextStyle(
                          color: Color(0xFFA0A7B4),
                          fontSize: 10,
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

  Widget _buildFulfillmentHistory() {
    return _sectionCard(
      title: 'Plan History',
      icon: Icons.auto_stories_outlined,
      child: Column(
        children: [
          _historyRow(
            'Agreement finalized',
            '06 Sep 2026',
            'Completed',
          ),
          _historyRow(
            'Fulfillment plan created',
            '06 Sep 2026',
            'Completed',
          ),
          _historyRow(
            'Provider started collection',
            '07 Sep 2026',
            'Completed',
          ),
          _historyRow(
            'Quality verification',
            '09 Sep 2026',
            'In Progress',
          ),
        ],
      ),
    );
  }

  Widget _historyRow(String title, String date, String status) {
    final completed = status == 'Completed';

    return Container(
      margin: const EdgeInsets.only(bottom: 11),
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
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                status,
                style: TextStyle(
                  color: completed
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFF59E0B),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary() {
    return _sectionCard(
      title: 'Fulfillment Performance',
      icon: Icons.insights_rounded,
      child: Column(
        children: [
          Row(
            children: [
              _performanceBox('82%', 'Completion'),
              const SizedBox(width: 10),
              _performanceBox('4.6 hrs', 'Avg Response'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _performanceBox('94%', 'On-Time'),
              const SizedBox(width: 10),
              _performanceBox('4.8/5', 'Satisfaction'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _performanceBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE8EAF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF4F46E5),
                fontSize: 20,
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

  Widget _buildPlanInsights() {
    return _sectionCard(
      title: 'Fulfillment Intelligence',
      icon: Icons.psychology_alt_outlined,
      child: Column(
        children: [
          _insightRow(
            Icons.trending_up_rounded,
            'Strong collection rate',
            'Collection has reached 82%, keeping the plan on track.',
          ),
          _insightRow(
            Icons.warning_amber_rounded,
            'Quantity gap detected',
            'Nine resources still need to be sourced before the deadline.',
          ),
          _insightRow(
            Icons.schedule_rounded,
            'Handover preparation needed',
            'Three preparation tasks should be completed before scheduling.',
          ),
          _insightRow(
            Icons.shield_outlined,
            'Verification is the next bottleneck',
            'Early verification can reduce final-day delays.',
          ),
        ],
      ),
    );
  }

  Widget _insightRow(
    IconData icon,
    String title,
    String subtitle,
  ) {
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
            icon,
            color: const Color(0xFF4F46E5),
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
                    color: Color(0xFF312E81),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF625F78),
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

  void _showPlanSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Fulfillment Plan',
                  style: TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                ...plans.map(
                  (plan) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEEF2FF),
                      child: Icon(
                        Icons.assignment_outlined,
                        color: plan['color'] as Color,
                      ),
                    ),
                    title: Text(
                      plan['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${plan['quantity']} • ${plan['deadline']}',
                    ),
                    trailing: selectedPlan == plan['title']
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF4F46E5),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        selectedPlan = plan['title'] as String;
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

  void _showQuantityUpdate() {
    final controller = TextEditingController(text: '41');

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Collected Quantity',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF172033),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter the latest number of resources collected.',
                style: TextStyle(
                  color: Color(0xFF7B8496),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Collected quantity',
                  prefixIcon: const Icon(Icons.inventory_2_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showMessage('Fulfillment quantity updated');
                  },
                  child: const Text('Save Quantity'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreatePlan() {
    final titleController = TextEditingController();
    final quantityController = TextEditingController();

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
                  'Create Fulfillment Plan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create a structured plan for a confirmed requirement.',
                  style: TextStyle(
                    color: Color(0xFF7B8496),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Requirement name',
                    prefixIcon: const Icon(Icons.assignment_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Required quantity',
                    prefixIcon: const Icon(Icons.numbers_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'Education',
                  decoration: InputDecoration(
                    labelText: 'Category',
                    prefixIcon: const Icon(Icons.category_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Education',
                      child: Text('Education'),
                    ),
                    DropdownMenuItem(
                      value: 'Electronics',
                      child: Text('Electronics'),
                    ),
                    DropdownMenuItem(
                      value: 'Food',
                      child: Text('Food'),
                    ),
                    DropdownMenuItem(
                      value: 'Medical',
                      child: Text('Medical'),
                    ),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _showMessage('Fulfillment plan created');
                    },
                    icon: const Icon(Icons.add_task_rounded),
                    label: const Text('Create Plan'),
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
      showDragHandle: true,
      builder: (sheetContext) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  title: Text('9 resources remaining'),
                  subtitle: Text('Collection needs attention'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.verified_outlined,
                    color: Colors.indigo,
                  ),
                  title: Text('Quality inspection pending'),
                  subtitle: Text('32 resources verified'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.event_outlined,
                    color: Colors.green,
                  ),
                  title: Text('4 days until deadline'),
                  subtitle: Text('Handover preparation recommended'),
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
          title: const Text('Fulfillment Planning'),
          content: const Text(
            'This center converts confirmed requirements into structured fulfillment plans with milestones, tasks, quantity tracking, deadlines, handover preparation, and smart recommendations.',
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
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    _showMessage('Fulfillment data refreshed');
  }
}