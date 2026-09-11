import 'package:flutter/material.dart';

class ActivityAuditScreen extends StatefulWidget {
  const ActivityAuditScreen({super.key});

  @override
  State<ActivityAuditScreen> createState() => _ActivityAuditScreenState();
}

class _ActivityAuditScreenState extends State<ActivityAuditScreen> {
  int _selectedFilter = 0;
  String _selectedPeriod = 'All time';
  String _searchQuery = '';

  final List<String> _filters = [
    'All',
    'Resources',
    'Matches',
    'Exchanges',
    'Requirements',
    'Account',
  ];

  final List<_ActivityItem> _activities = [
    _ActivityItem(
      title: 'Exchange completed',
      description:
          '12 engineering lab kits were successfully transferred to VIT Community Hub.',
      category: 'Exchanges',
      time: 'Today • 10:42 AM',
      dateGroup: 'Today',
      icon: Icons.check_circle_outline_rounded,
      color: Colors.green,
      status: 'Completed',
      reference: 'EX-24091',
    ),
    _ActivityItem(
      title: 'New smart match found',
      description:
          'ResourceX found a 96% match for your available engineering equipment.',
      category: 'Matches',
      time: 'Today • 9:18 AM',
      dateGroup: 'Today',
      icon: Icons.auto_awesome_rounded,
      color: Colors.indigo,
      status: '96% Match',
      reference: 'MT-78412',
    ),
    _ActivityItem(
      title: 'Resource availability updated',
      description:
          'Engineering Lab Equipment was marked as available for exchange.',
      category: 'Resources',
      time: 'Yesterday • 6:35 PM',
      dateGroup: 'Yesterday',
      icon: Icons.inventory_2_outlined,
      color: Colors.blue,
      status: 'Available',
      reference: 'RS-58231',
    ),
    _ActivityItem(
      title: 'Requirement submitted',
      description:
          'Your requirement for 8 laptops has been submitted successfully.',
      category: 'Requirements',
      time: 'Yesterday • 4:20 PM',
      dateGroup: 'Yesterday',
      icon: Icons.assignment_outlined,
      color: Colors.orange,
      status: 'Open',
      reference: 'RQ-39102',
    ),
    _ActivityItem(
      title: 'Profile verification completed',
      description:
          'Your ResourceX profile verification was successfully completed.',
      category: 'Account',
      time: 'Aug 23 • 11:12 AM',
      dateGroup: 'Earlier',
      icon: Icons.verified_user_outlined,
      color: Colors.teal,
      status: 'Verified',
      reference: 'VR-12088',
    ),
    _ActivityItem(
      title: 'Resource saved',
      description:
          'You saved Reusable Event Materials for later exploration.',
      category: 'Resources',
      time: 'Aug 22 • 3:47 PM',
      dateGroup: 'Earlier',
      icon: Icons.bookmark_border_rounded,
      color: Colors.purple,
      status: 'Saved',
      reference: 'RS-44791',
    ),
    _ActivityItem(
      title: 'Exchange scheduled',
      description:
          'Laptop exchange with Digital Learning Foundation was scheduled.',
      category: 'Exchanges',
      time: 'Aug 21 • 2:30 PM',
      dateGroup: 'Earlier',
      icon: Icons.event_available_outlined,
      color: Colors.cyan,
      status: 'Scheduled',
      reference: 'EX-11873',
    ),
    _ActivityItem(
      title: 'Requirement matched',
      description:
          'Your available resources were connected to a community requirement.',
      category: 'Matches',
      time: 'Aug 20 • 9:52 AM',
      dateGroup: 'Earlier',
      icon: Icons.link_rounded,
      color: Colors.deepOrange,
      status: '91% Match',
      reference: 'MT-66510',
    ),
    _ActivityItem(
      title: 'Password updated',
      description:
          'Your ResourceX account password was successfully changed.',
      category: 'Account',
      time: 'Aug 18 • 8:15 PM',
      dateGroup: 'Earlier',
      icon: Icons.lock_outline_rounded,
      color: Colors.grey,
      status: 'Security',
      reference: 'AC-90211',
    ),
  ];

  List<_ActivityItem> get _filteredActivities {
    List<_ActivityItem> result = List.from(_activities);

    if (_selectedFilter != 0) {
      final selected = _filters[_selectedFilter];
      result = result.where((item) => item.category == selected).toList();
    }

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      result = result.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query) ||
            item.reference.toLowerCase().contains(query);
      }).toList();
    }

    if (_selectedPeriod == 'Today') {
      result = result.where((item) => item.dateGroup == 'Today').toList();
    } else if (_selectedPeriod == 'Yesterday') {
      result =
          result.where((item) => item.dateGroup == 'Yesterday').toList();
    }

    return result;
  }

  void _showActivityDetails(_ActivityItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Icon(
                          item.icon,
                          color: item.color,
                          size: 29,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.category,
                              style: TextStyle(
                                color: item.color,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _buildDetailBox(
                    'Activity description',
                    item.description,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSmallDetail(
                          Icons.schedule_outlined,
                          'Time',
                          item.time,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSmallDetail(
                          Icons.tag_outlined,
                          'Reference',
                          item.reference,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSmallDetail(
                    Icons.flag_outlined,
                    'Status',
                    item.status,
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Activity timeline',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _timelineStep(
                    'Activity created',
                    item.time,
                    true,
                  ),
                  _timelineStep(
                    'ResourceX processed the activity',
                    'Automatically recorded',
                    true,
                  ),
                  _timelineStep(
                    'Current status',
                    item.status,
                    true,
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMessage(
                          'Activity ${item.reference} copied',
                        );
                      },
                      icon: const Icon(Icons.copy_outlined),
                      label: const Text('Copy Reference ID'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailBox(
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallDetail(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.indigo,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineStep(
    String title,
    String subtitle,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: completed
                      ? Colors.indigo
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  completed
                      ? Icons.check
                      : Icons.circle,
                  size: 13,
                  color: Colors.white,
                ),
              ),
              if (title != 'Current status')
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
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
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showPeriodSheet() {
    final options = [
      'All time',
      'Today',
      'Yesterday',
    ];

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Activity period',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              ...options.map(
                (option) => ListTile(
                  leading: Icon(
                    option == _selectedPeriod
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: option == _selectedPeriod
                        ? Colors.indigo
                        : Colors.grey,
                  ),
                  title: Text(option),
                  onTap: () {
                    setState(() {
                      _selectedPeriod = option;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final activities = _filteredActivities;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity & Audit',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Your complete ResourceX activity history',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showMessage('Activity history refreshed');
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        children: [
          _buildOverviewCard(),
          const SizedBox(height: 18),
          _buildSearchBox(),
          const SizedBox(height: 13),
          _buildFilters(),
          const SizedBox(height: 18),
          _buildActivityHeader(activities.length),
          const SizedBox(height: 10),
          if (activities.isEmpty)
            _buildEmptyState()
          else
            _buildActivityList(activities),
          const SizedBox(height: 18),
          _buildAuditInfoCard(),
        ],
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade800,
            Colors.blue.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.17),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Activity Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          const Text(
            'Every important action on your ResourceX account is organized here so you can easily review your resource, exchange and account history.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Expanded(
                child: _overviewMetric(
                  '48',
                  'Total activities',
                ),
              ),
              Expanded(
                child: _overviewMetric(
                  '16',
                  'Exchanges',
                ),
              ),
              Expanded(
                child: _overviewMetric(
                  '12',
                  'Matches',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewMetric(
    String value,
    String label,
  ) {
    return Column(
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
            color: Colors.white.withValues(alpha: 0.70),
            fontSize: 9.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search activity or reference ID...',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 21,
          ),
          suffixIcon: _searchQuery.isEmpty
              ? null
              : IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.close),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedFilter == index;

          return ChoiceChip(
            label: Text(_filters[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = index;
              });
            },
            selectedColor: Colors.indigo.shade100,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selected
                  ? Colors.indigo.shade200
                  : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: selected
                  ? Colors.indigo.shade800
                  : Colors.grey.shade700,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              fontSize: 10.5,
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityHeader(int count) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Recent activity',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: _showPeriodSheet,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 7,
            ),
            child: Row(
              children: [
                Text(
                  _selectedPeriod,
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          '$count',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList(
    List<_ActivityItem> activities,
  ) {
    return Column(
      children: activities.map(
        (item) {
          return _buildActivityCard(item);
        },
      ).toList(),
    );
  }

  Widget _buildActivityCard(
    _ActivityItem item,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: () {
          _showActivityDetails(item);
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: item.color.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            item.status,
                            style: TextStyle(
                              color: item.color,
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10.5,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.time,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 9.5,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.reference,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.history_toggle_off_rounded,
            size: 52,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 13),
          const Text(
            'No activity found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try changing your filters or search for another activity.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditInfoCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.security_outlined,
              color: Colors.teal,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity records are protected',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'ResourceX keeps a transparent record of important actions to improve accountability, trust and exchange safety.',
                  style: TextStyle(
                    fontSize: 10.5,
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
}

class _ActivityItem {
  final String title;
  final String description;
  final String category;
  final String time;
  final String dateGroup;
  final IconData icon;
  final MaterialColor color;
  final String status;
  final String reference;

  const _ActivityItem({
    required this.title,
    required this.description,
    required this.category,
    required this.time,
    required this.dateGroup,
    required this.icon,
    required this.color,
    required this.status,
    required this.reference,
  });
}