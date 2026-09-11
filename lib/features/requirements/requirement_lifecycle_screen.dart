import 'package:flutter/material.dart';

class RequirementLifecycleScreen extends StatefulWidget {
  const RequirementLifecycleScreen({super.key});

  @override
  State<RequirementLifecycleScreen> createState() =>
      _RequirementLifecycleScreenState();
}

class _RequirementLifecycleScreenState
    extends State<RequirementLifecycleScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchText = '';

  final List<String> tabs = [
    'All',
    'Active',
    'Delayed',
    'Completed',
  ];

  final List<String> filters = [
    'All',
    'Technology',
    'Education',
    'Food',
    'Medical',
    'Clothing',
  ];

  final List<Map<String, dynamic>> requirements = [
    {
      'title': 'Laptops for Student Lab',
      'category': 'Technology',
      'requester': 'VIT Student Support',
      'location': 'Vellore',
      'status': 'Matching',
      'progress': 0.62,
      'matched': 5,
      'required': 8,
      'days': 4,
      'priority': 'High',
      'icon': Icons.laptop_mac_rounded,
      'description':
          'Laptops required for students who need temporary access to learning resources.',
      'updated': 'Today, 10:42 AM',
    },
    {
      'title': 'Engineering Textbooks',
      'category': 'Education',
      'requester': 'Student Resource Circle',
      'location': 'Katpadi',
      'status': 'Confirmed',
      'progress': 0.82,
      'matched': 41,
      'required': 50,
      'days': 6,
      'priority': 'Medium',
      'icon': Icons.menu_book_rounded,
      'description':
          'Engineering reference books requested for the upcoming academic cycle.',
      'updated': 'Today, 9:15 AM',
    },
    {
      'title': 'Community Food Kits',
      'category': 'Food',
      'requester': 'Hope Community Group',
      'location': 'Vellore',
      'status': 'Fulfilled',
      'progress': 1.0,
      'matched': 30,
      'required': 30,
      'days': 0,
      'priority': 'High',
      'icon': Icons.shopping_basket_rounded,
      'description':
          'Food support kits coordinated for families requiring short-term assistance.',
      'updated': 'Yesterday, 6:30 PM',
    },
    {
      'title': 'First Aid Supplies',
      'category': 'Medical',
      'requester': 'Care Support Network',
      'location': 'Ranipet',
      'status': 'Delayed',
      'progress': 0.44,
      'matched': 11,
      'required': 25,
      'days': -2,
      'priority': 'High',
      'icon': Icons.medical_services_rounded,
      'description':
          'First aid materials required for community health and emergency support.',
      'updated': 'Yesterday, 3:48 PM',
    },
    {
      'title': 'Clothing Collection',
      'category': 'Clothing',
      'requester': 'Community Volunteers',
      'location': 'Chennai',
      'status': 'Published',
      'progress': 0.18,
      'matched': 9,
      'required': 50,
      'days': 12,
      'priority': 'Medium',
      'icon': Icons.checkroom_rounded,
      'description':
          'Good-condition clothing collection for community distribution.',
      'updated': '2 days ago',
    },
  ];

  List<Map<String, dynamic>> get filteredRequirements {
    return requirements.where((requirement) {
      final categoryMatch = selectedFilter == 'All' ||
          requirement['category'] == selectedFilter;

      final search = searchText.toLowerCase();

      final searchMatch = search.isEmpty ||
          requirement['title'].toString().toLowerCase().contains(search) ||
          requirement['requester']
              .toString()
              .toLowerCase()
              .contains(search) ||
          requirement['category'].toString().toLowerCase().contains(search);

      final status = requirement['status'] as String;

      final tabMatch = switch (selectedTab) {
        0 => true,
        1 => status != 'Fulfilled' && status != 'Delayed',
        2 => status == 'Delayed',
        3 => status == 'Fulfilled',
        _ => true,
      };

      return categoryMatch && searchMatch && tabMatch;
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
          'Requirement Lifecycle',
          style: TextStyle(
            color: Color(0xFF1D2638),
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showLifecycleInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF30384A),
            ),
          ),
          IconButton(
            onPressed: refreshRequirements,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF30384A),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshRequirements,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            buildHero(),
            const SizedBox(height: 18),
            buildSearch(),
            const SizedBox(height: 14),
            buildCategoryFilters(),
            const SizedBox(height: 16),
            buildTabs(),
            const SizedBox(height: 20),
            buildLifecycleOverview(),
            const SizedBox(height: 22),
            buildSectionHeader(),
            const SizedBox(height: 13),
            buildRequirementList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showCreateRequirement,
        backgroundColor: const Color(0xFF5B5FEF),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'New Requirement',
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
            Color(0xFF5156E9),
            Color(0xFF777BF5),
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
                  Icons.route_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
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
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Smart Tracking',
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
            'Requirement\nLifecycle Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Track every requirement from publication to successful fulfillment with intelligent progress monitoring.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              buildHeroMetric('48', 'Active'),
              buildHeroDivider(),
              buildHeroMetric('76%', 'Fulfillment'),
              buildHeroDivider(),
              buildHeroMetric('7', 'Delayed'),
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
              color: Colors.white.withValues(alpha: 0.75),
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
      color: Colors.white.withValues(alpha: 0.22),
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
        hintText: 'Search requirements or requesters...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: showAdvancedFilters,
          icon: const Icon(Icons.tune_rounded),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildCategoryFilters() {
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
                      fontSize: 10,
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

  Widget buildLifecycleOverview() {
    final stats = [
      ['48', 'Active', Icons.pending_actions_rounded],
      ['31', 'Matching', Icons.hub_rounded],
      ['14', 'Confirmed', Icons.handshake_rounded],
      ['52', 'Fulfilled', Icons.task_alt_rounded],
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
              color: const Color(0xFFE6E9F0),
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
                  color: Color(0xFF7A8292),
                  fontSize: 10,
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
                'Requirements',
                style: TextStyle(
                  color: Color(0xFF1D2638),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Monitor progress and fulfillment status',
                style: TextStyle(
                  color: Color(0xFF7B8392),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${filteredRequirements.length} items',
          style: const TextStyle(
            color: Color(0xFF5B5FEF),
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget buildRequirementList() {
    final items = filteredRequirements;

    if (items.isEmpty) {
      return buildEmptyState();
    }

    return Column(
      children: items.map(buildRequirementCard).toList(),
    );
  }

  Widget buildRequirementCard(Map<String, dynamic> requirement) {
    final status = requirement['status'] as String;
    final progress = requirement['progress'] as double;
    final priority = requirement['priority'] as String;
    final highPriority = priority == 'High';

    return GestureDetector(
      onTap: () => showRequirementDetails(requirement),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: const Color(0xFFE5E8EF),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F1FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    requirement['icon'] as IconData,
                    color: const Color(0xFF5B5FEF),
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requirement['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF202A3C),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        requirement['requester'] as String,
                        style: const TextStyle(
                          color: Color(0xFF707889),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: Color(0xFF8B92A0),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${requirement['location']} • ${requirement['category']}',
                            style: const TextStyle(
                              color: Color(0xFF8B92A0),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildStatusBadge(status),
              ],
            ),
            const SizedBox(height: 16),
            buildLifecycleProgress(
              status,
              progress,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                buildSmallMetric(
                  Icons.inventory_2_outlined,
                  '${requirement['matched']}/${requirement['required']}',
                  'Matched',
                ),
                buildSmallMetric(
                  Icons.calendar_today_outlined,
                  requirement['days'] == 0
                      ? 'Today'
                      : requirement['days'] > 0
                          ? '${requirement['days']}d'
                          : '${(requirement['days'] as int).abs()}d',
                  'Deadline',
                ),
                buildSmallMetric(
                  Icons.priority_high_rounded,
                  priority,
                  'Priority',
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Icon(
                  highPriority
                      ? Icons.warning_amber_rounded
                      : Icons.info_outline_rounded,
                  color: highPriority
                      ? const Color(0xFFE05D58)
                      : const Color(0xFF777F90),
                  size: 15,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    highPriority
                        ? 'High priority requirement needs attention.'
                        : 'Requirement is progressing normally.',
                    style: const TextStyle(
                      color: Color(0xFF777F90),
                      fontSize: 9,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9AA1AE),
                  size: 19,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusBadge(String status) {
    Color background;
    Color foreground;

    switch (status) {
      case 'Fulfilled':
        background = const Color(0xFFEAF9F3);
        foreground = const Color(0xFF21966A);
        break;
      case 'Delayed':
        background = const Color(0xFFFFEEEE);
        foreground = const Color(0xFFE05D58);
        break;
      case 'Confirmed':
        background = const Color(0xFFEFF1FF);
        foreground = const Color(0xFF5559E8);
        break;
      case 'Matching':
        background = const Color(0xFFFFF4E8);
        foreground = const Color(0xFFD58931);
        break;
      default:
        background = const Color(0xFFF1F2F5);
        foreground = const Color(0xFF727A8A);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 8,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildLifecycleProgress(
    String status,
    double progress,
  ) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Fulfillment Progress',
              style: TextStyle(
                color: Color(0xFF737B8B),
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                color: Color(0xFF5559E8),
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            minHeight: 7,
            value: progress,
            backgroundColor: const Color(0xFFECEFF3),
            valueColor: AlwaysStoppedAnimation<Color>(
              status == 'Delayed'
                  ? const Color(0xFFE05D58)
                  : status == 'Fulfilled'
                      ? const Color(0xFF35B58A)
                      : const Color(0xFF5B5FEF),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSmallMetric(
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF7A8292),
            size: 14,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF30384A),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF9097A5),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 45,
            color: Color(0xFF9AA1B0),
          ),
          SizedBox(height: 12),
          Text(
            'No requirements found',
            style: TextStyle(
              color: Color(0xFF30384A),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try changing your filters or search criteria.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7A8292),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void showRequirementDetails(
    Map<String, dynamic> requirement,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
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
                        requirement['icon'] as IconData,
                        color: const Color(0xFF5B5FEF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        requirement['title'] as String,
                        style: const TextStyle(
                          color: Color(0xFF202A3C),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildDetailRow(
                  'Requester',
                  requirement['requester'] as String,
                ),
                buildDetailRow(
                  'Category',
                  requirement['category'] as String,
                ),
                buildDetailRow(
                  'Location',
                  requirement['location'] as String,
                ),
                buildDetailRow(
                  'Status',
                  requirement['status'] as String,
                ),
                buildDetailRow(
                  'Matched',
                  '${requirement['matched']} / ${requirement['required']}',
                ),
                buildDetailRow(
                  'Priority',
                  requirement['priority'] as String,
                ),
                buildDetailRow(
                  'Last Updated',
                  requirement['updated'] as String,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Color(0xFF30384A),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  requirement['description'] as String,
                  style: const TextStyle(
                    color: Color(0xFF747C8C),
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                buildLifecycleSteps(
                  requirement['status'] as String,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          showUpdateRequirement(requirement);
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 16,
                        ),
                        label: const Text('Update'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          showSnackBar(
                            'Opening matching opportunities...',
                          );
                        },
                        icon: const Icon(
                          Icons.hub_rounded,
                          size: 16,
                        ),
                        label: const Text('Find Matches'),
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
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF30384A),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLifecycleSteps(String currentStatus) {
    final steps = [
      ['Published', Icons.publish_rounded],
      ['Matching', Icons.hub_rounded],
      ['Confirmed', Icons.handshake_rounded],
      ['Fulfilled', Icons.task_alt_rounded],
    ];

    final currentIndex = switch (currentStatus) {
      'Published' => 0,
      'Matching' => 1,
      'Confirmed' => 2,
      'Fulfilled' => 3,
      'Delayed' => 1,
      _ => 0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lifecycle',
          style: TextStyle(
            color: Color(0xFF30384A),
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          steps.length,
          (index) {
            final completed = index <= currentIndex;

            return Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: completed
                            ? const Color(0xFF5B5FEF)
                            : const Color(0xFFE9EBF1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        steps[index][1] as IconData,
                        color: completed
                            ? Colors.white
                            : const Color(0xFF8B92A0),
                        size: 15,
                      ),
                    ),
                    if (index < steps.length - 1)
                      Container(
                        width: 2,
                        height: 22,
                        color: completed
                            ? const Color(0xFF5B5FEF)
                            : const Color(0xFFE0E3EA),
                      ),
                  ],
                ),
                const SizedBox(width: 11),
                Text(
                  steps[index][0] as String,
                  style: TextStyle(
                    color: completed
                        ? const Color(0xFF30384A)
                        : const Color(0xFF8A91A0),
                    fontSize: 11,
                    fontWeight:
                        completed ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void showUpdateRequirement(
    Map<String, dynamic> requirement,
  ) {
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
                'Update Requirement',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                requirement['title'] as String,
                style: const TextStyle(
                  color: Color(0xFF7A8292),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 18),
              updateOption(
                Icons.access_time_rounded,
                'Extend Deadline',
                'Give providers more time to respond.',
              ),
              updateOption(
                Icons.inventory_2_outlined,
                'Increase Quantity',
                'Request additional resources.',
              ),
              updateOption(
                Icons.priority_high_rounded,
                'Change Priority',
                'Adjust the urgency of this requirement.',
              ),
              updateOption(
                Icons.pause_circle_outline_rounded,
                'Pause Requirement',
                'Temporarily stop new matching activity.',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget updateOption(
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
            size: 19,
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
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9AA1AE),
            size: 18,
          ),
        ],
      ),
    );
  }

  void showAdvancedFilters() {
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
                'Advanced Filters',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 18),
              filterAction(
                Icons.warning_amber_rounded,
                'High Priority',
              ),
              filterAction(
                Icons.access_time_rounded,
                'Deadline This Week',
              ),
              filterAction(
                Icons.hub_rounded,
                'Currently Matching',
              ),
              filterAction(
                Icons.verified_rounded,
                'Verified Requesters',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget filterAction(
    IconData icon,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF5B5FEF),
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF4D5668),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Switch(
            value: false,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  void showCreateRequirement() {
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
                'Create Requirement',
                style: TextStyle(
                  color: Color(0xFF202A3C),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Start a new community resource requirement.',
                style: TextStyle(
                  color: Color(0xFF7A8292),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Requirement title',
                  hintText: 'Example: 10 laptops for students',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    showSnackBar(
                      'Requirement published successfully',
                    );
                  },
                  icon: const Icon(Icons.publish_rounded),
                  label: const Text('Publish Requirement'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLifecycleInfo() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Requirement Lifecycle',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Text(
            'ResourceX tracks each requirement through Published, Matching, Confirmed and Fulfilled stages. Delayed requirements are highlighted so they can receive attention before becoming inactive.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Understood'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshRequirements() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 600),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
    showSnackBar('Requirement lifecycle updated');
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