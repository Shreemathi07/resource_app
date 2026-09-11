import 'package:flutter/material.dart';

class RequirementFulfillmentCommunicationScreen extends StatefulWidget {
  const RequirementFulfillmentCommunicationScreen({super.key});

  @override
  State<RequirementFulfillmentCommunicationScreen> createState() =>
      _RequirementFulfillmentCommunicationScreenState();
}

class _RequirementFulfillmentCommunicationScreenState
    extends State<RequirementFulfillmentCommunicationScreen> {
  int selectedTab = 0;
  int selectedPeriod = 1;

  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Conversations',
    'Updates',
    'Reminders',
  ];

  final List<String> filters = [
    'All',
    'Needs Reply',
    'Unread',
    'Active',
    'Resolved',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<Map<String, dynamic>> conversations = [
    {
      'name': 'Green Campus Initiative',
      'role': 'Resource Provider',
      'requirement': 'Reusable Study Materials',
      'message': 'We can provide 45 study kits this week.',
      'time': '8 min ago',
      'unread': true,
      'online': true,
      'status': 'Needs Reply',
      'category': 'Education',
      'color': Colors.indigo,
    },
    {
      'name': 'Vellore Community Kitchen',
      'role': 'Organization',
      'requirement': 'Food Donation Support',
      'message': 'Pickup can be arranged tomorrow morning.',
      'time': '32 min ago',
      'unread': true,
      'online': true,
      'status': 'Active',
      'category': 'Food',
      'color': Colors.orange,
    },
    {
      'name': 'Arun Kumar',
      'role': 'Resource Provider',
      'requirement': 'Desktop Computers',
      'message': 'The devices are ready for verification.',
      'time': '1 hr ago',
      'unread': false,
      'online': false,
      'status': 'Active',
      'category': 'Technology',
      'color': Colors.teal,
    },
    {
      'name': 'Hope Community Center',
      'role': 'Resource Seeker',
      'requirement': 'Medical Equipment',
      'message': 'Thank you. The requirement has been fulfilled.',
      'time': '3 hrs ago',
      'unread': false,
      'online': false,
      'status': 'Resolved',
      'category': 'Healthcare',
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> updates = [
    {
      'title': 'Provider availability updated',
      'description':
          'Green Campus Initiative increased the available quantity from 30 to 45 units.',
      'time': '8 min ago',
      'type': 'Resource',
      'icon': Icons.inventory_2_outlined,
    },
    {
      'title': 'Pickup schedule confirmed',
      'description':
          'Vellore Community Kitchen confirmed tomorrow at 10:30 AM.',
      'time': '32 min ago',
      'type': 'Exchange',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'title': 'Verification completed',
      'description':
          'Desktop Computers requirement passed the resource verification check.',
      'time': '1 hr ago',
      'type': 'Verification',
      'icon': Icons.verified_outlined,
    },
    {
      'title': 'Requirement fulfilled',
      'description':
          'Medical Equipment requirement was successfully completed.',
      'time': '3 hrs ago',
      'type': 'Fulfillment',
      'icon': Icons.check_circle_outline,
    },
  ];

  final List<Map<String, dynamic>> reminders = [
    {
      'title': 'Waiting for provider response',
      'description':
          'Green Campus Initiative has not received a response for the latest availability update.',
      'due': 'Due in 18 min',
      'priority': 'High',
      'icon': Icons.reply_outlined,
    },
    {
      'title': 'Confirm pickup location',
      'description':
          'Confirm the exact pickup point for the Food Donation Support exchange.',
      'due': 'Due today',
      'priority': 'Medium',
      'icon': Icons.location_on_outlined,
    },
    {
      'title': 'Send fulfillment update',
      'description':
          'Share the latest progress with the Desktop Computers provider.',
      'due': 'Due tomorrow',
      'priority': 'Low',
      'icon': Icons.update_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredConversations {
    return conversations.where((conversation) {
      final name = conversation['name'].toString().toLowerCase();
      final requirement =
          conversation['requirement'].toString().toLowerCase();
      final message = conversation['message'].toString().toLowerCase();

      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          name.contains(query) ||
          requirement.contains(query) ||
          message.contains(query);

      bool matchesFilter = true;

      if (selectedFilter == 'Needs Reply') {
        matchesFilter = conversation['status'] == 'Needs Reply';
      } else if (selectedFilter == 'Unread') {
        matchesFilter = conversation['unread'] == true;
      } else if (selectedFilter == 'Active') {
        matchesFilter = conversation['status'] == 'Active';
      } else if (selectedFilter == 'Resolved') {
        matchesFilter = conversation['status'] == 'Resolved';
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Fulfillment Communication',
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
        onPressed: _showNewMessageSheet,
        icon: const Icon(Icons.edit_outlined),
        label: const Text('New Message'),
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
                _buildCommunicationHealth(),
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
            scheme.primary.withValues(alpha: 0.78),
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
                  Icons.forum_outlined,
                  color: Colors.white,
                  size: 26,
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Fulfillment Communication Hub',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coordinate providers, seekers and organizations from one intelligent communication center.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('24', 'Active Chats'),
              _heroMetric('7', 'Need Reply'),
              _heroMetric('96%', 'Response Rate'),
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
        hintText: 'Search conversations, requirements or messages...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: _showCommunicationFilters,
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
              fontWeight: FontWeight.w700,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade700,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommunicationHealth() {
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
                  color: Colors.green.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Communication Health',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Strong fulfillment coordination',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '94%',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.94,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _healthItem('Response', '96%'),
              _healthItem('Updates', '91%'),
              _healthItem('Resolution', '95%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
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
                horizontal: 18,
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
        return _buildConversationsTab();
      case 2:
        return _buildUpdatesTab();
      case 3:
        return _buildRemindersTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    final attentionItems = filteredConversations
        .where((item) => item['status'] == 'Needs Reply')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Needs Attention',
          'Conversations requiring action',
          Icons.priority_high_rounded,
        ),
        const SizedBox(height: 12),
        if (attentionItems.isEmpty)
          _buildEmptyState(
            Icons.check_circle_outline,
            'All caught up',
            'There are no conversations currently waiting for a reply.',
          )
        else
          ...attentionItems.map(_buildConversationCard),
        const SizedBox(height: 20),
        _sectionTitle(
          'Smart Message Suggestions',
          'Recommended communication actions',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _buildSuggestionCard(
          'Follow up with Green Campus Initiative',
          'A quick confirmation could move this requirement closer to fulfillment.',
          Icons.reply_all_outlined,
          Colors.indigo,
        ),
        _buildSuggestionCard(
          'Confirm tomorrow pickup',
          'The pickup time is approaching. Confirm the location with both participants.',
          Icons.location_on_outlined,
          Colors.orange,
        ),
        const SizedBox(height: 20),
        _sectionTitle(
          'Recent Conversations',
          'Latest fulfillment communication',
          Icons.forum_outlined,
        ),
        const SizedBox(height: 12),
        ...filteredConversations.take(4).map(_buildConversationCard),
      ],
    );
  }

  Widget _buildConversationsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterChips(),
        const SizedBox(height: 16),
        if (filteredConversations.isEmpty)
          _buildEmptyState(
            Icons.forum_outlined,
            'No conversations found',
            'Try changing your search or communication filter.',
          )
        else
          ...filteredConversations.map(_buildConversationCard),
      ],
    );
  }

  Widget _buildUpdatesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Fulfillment Updates',
          'Recent activity from your network',
          Icons.update_outlined,
        ),
        const SizedBox(height: 12),
        ...updates.map(_buildUpdateCard),
      ],
    );
  }

  Widget _buildRemindersTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Smart Reminders',
          'Keep every fulfillment conversation moving',
          Icons.alarm_outlined,
        ),
        const SizedBox(height: 12),
        ...reminders.map(_buildReminderCard),
        const SizedBox(height: 20),
        _buildReminderSettingsCard(),
      ],
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

  Widget _buildConversationCard(Map<String, dynamic> conversation) {
    final color = conversation['color'] as Color;

    return GestureDetector(
      onTap: () => _showConversation(conversation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: conversation['unread'] == true
                ? color.withValues(alpha: 0.30)
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: color.withValues(alpha: 0.12),
                  child: Text(
                    conversation['name'].toString().substring(0, 1),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (conversation['online'] == true)
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation['name'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        conversation['time'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    conversation['role'].toString(),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    conversation['requirement'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    conversation['message'].toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      height: 1.3,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _statusBadge(
                        conversation['status'].toString(),
                        conversation['status'] == 'Needs Reply'
                            ? Colors.red
                            : conversation['status'] == 'Resolved'
                                ? Colors.green
                                : Colors.blue,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard(Map<String, dynamic> update) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              update['icon'] as IconData,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        update['title'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      update['time'].toString(),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  update['description'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 9),
                _statusBadge(
                  update['type'].toString(),
                  Colors.indigo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    final priority = reminder['priority'].toString();

    final priorityColor = priority == 'High'
        ? Colors.red
        : priority == 'Medium'
            ? Colors.orange
            : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: priorityColor.withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              reminder['icon'] as IconData,
              color: priorityColor,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  reminder['description'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _statusBadge(
                      priority,
                      priorityColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      reminder['due'].toString(),
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showReminderActions(reminder),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showSnackBar('Suggested action opened');
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderSettingsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Communication reminders',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Automatically remind participants when a response or update is pending.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {
              _showSnackBar(
                value
                    ? 'Smart reminders enabled'
                    : 'Smart reminders paused',
              );
            },
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
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String text, Color color) {
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
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
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
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _showConversation(Map<String, dynamic> conversation) {
    final color = conversation['color'] as Color;

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
        final controller = TextEditingController();

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            18,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 20,
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
                      radius: 24,
                      backgroundColor: color.withValues(alpha: 0.12),
                      child: Text(
                        conversation['name'].toString().substring(0, 1),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            conversation['name'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            conversation['requirement'].toString(),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _messageBubble(
                  'Hi! We wanted to share the latest update regarding this requirement.',
                  false,
                ),
                _messageBubble(
                  conversation['message'].toString(),
                  true,
                ),
                _messageBubble(
                  'Thanks for the update. I will coordinate the next fulfillment step.',
                  false,
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write a fulfillment update...',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.text.trim().isEmpty) {
                          return;
                        }

                        Navigator.pop(sheetContext);
                        _showSnackBar('Message sent successfully');
                      },
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _quickMessageButton(
                      'Confirm',
                      Icons.check_circle_outline,
                      () {
                        Navigator.pop(sheetContext);
                        _showSnackBar('Confirmation message sent');
                      },
                    ),
                    const SizedBox(width: 8),
                    _quickMessageButton(
                      'Pickup',
                      Icons.local_shipping_outlined,
                      () {
                        Navigator.pop(sheetContext);
                        _showSnackBar('Pickup message sent');
                      },
                    ),
                    const SizedBox(width: 8),
                    _quickMessageButton(
                      'Update',
                      Icons.update_outlined,
                      () {
                        Navigator.pop(sheetContext);
                        _showSnackBar('Status update sent');
                      },
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

  Widget _messageBubble(
    String message,
    bool incoming,
  ) {
    return Align(
      alignment:
          incoming ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: incoming
              ? Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.10)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _quickMessageButton(
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 15,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  void _showNewMessageSheet() {
    String selectedRecipient = 'Green Campus Initiative';
    String selectedTemplate = 'Fulfillment Update';

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
                      'New Fulfillment Message',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Start a conversation with a participant.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      initialValue: selectedRecipient,
                      decoration: const InputDecoration(
                        labelText: 'Recipient',
                        border: OutlineInputBorder(),
                      ),
                      items: conversations
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item['name'].toString(),
                              child: Text(
                                item['name'].toString(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedRecipient = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedTemplate,
                      decoration: const InputDecoration(
                        labelText: 'Message Template',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Fulfillment Update',
                          child: Text('Fulfillment Update'),
                        ),
                        DropdownMenuItem(
                          value: 'Pickup Confirmation',
                          child: Text('Pickup Confirmation'),
                        ),
                        DropdownMenuItem(
                          value: 'Availability Check',
                          child: Text('Availability Check'),
                        ),
                        DropdownMenuItem(
                          value: 'Thank You',
                          child: Text('Thank You'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedTemplate = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            'Write your message to $selectedRecipient...',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Message sent to $selectedRecipient',
                          );
                        },
                        icon: const Icon(Icons.send_rounded),
                        label: const Text(
                          'Send Message',
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

  void _showCommunicationFilters() {
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
                  'Communication Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                ...filters.map(
                  (filter) => ListTile(
                    leading: Icon(
                      filter == 'Needs Reply'
                          ? Icons.reply_outlined
                          : filter == 'Unread'
                              ? Icons.mark_email_unread_outlined
                              : filter == 'Active'
                                  ? Icons.forum_outlined
                                  : filter == 'Resolved'
                                      ? Icons.check_circle_outline
                                      : Icons.all_inbox_outlined,
                    ),
                    title: Text(filter),
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

  void _showReminderActions(Map<String, dynamic> reminder) {
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
                leading: const Icon(Icons.send_outlined),
                title: const Text('Send reminder now'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Reminder sent');
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: const Text('Snooze reminder'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Reminder snoozed');
                },
              ),
              ListTile(
                leading: const Icon(Icons.done_all_outlined),
                title: const Text('Mark as completed'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Reminder marked as completed');
                },
              ),
            ],
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
                  'Communication Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                _notificationItem(
                  Icons.reply_outlined,
                  '7 conversations need a reply',
                  'Just now',
                ),
                _notificationItem(
                  Icons.local_shipping_outlined,
                  'Pickup confirmation received',
                  '12 min ago',
                ),
                _notificationItem(
                  Icons.update_outlined,
                  'New fulfillment update',
                  '28 min ago',
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

    _showSnackBar('Communication center refreshed');
  }
}