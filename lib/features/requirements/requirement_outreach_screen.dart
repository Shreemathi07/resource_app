import 'package:flutter/material.dart';

class RequirementOutreachScreen extends StatefulWidget {
  const RequirementOutreachScreen({super.key});

  @override
  State<RequirementOutreachScreen> createState() =>
      _RequirementOutreachScreenState();
}

class _RequirementOutreachScreenState
    extends State<RequirementOutreachScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Outreach',
    'Responses',
    'History',
  ];

  final List<String> filters = [
    'All',
    'Active',
    'High Response',
    'Pending',
    'Completed',
  ];

  final List<Map<String, dynamic>> campaigns = [
    {
      'title': 'Laptop Requirement Outreach',
      'requirement': 'Refurbished laptops',
      'providers': 42,
      'responses': 28,
      'connected': 16,
      'status': 'Active',
      'response': 67,
      'category': 'Technology',
      'date': 'Today',
    },
    {
      'title': 'Food Donation Network',
      'requirement': 'Surplus packaged food',
      'providers': 31,
      'responses': 24,
      'connected': 19,
      'status': 'High Response',
      'response': 77,
      'category': 'Food',
      'date': 'Yesterday',
    },
    {
      'title': 'Study Material Request',
      'requirement': 'Engineering textbooks',
      'providers': 26,
      'responses': 15,
      'connected': 9,
      'status': 'Active',
      'response': 58,
      'category': 'Education',
      'date': '2 days ago',
    },
    {
      'title': 'Furniture Recovery',
      'requirement': 'Classroom furniture',
      'providers': 18,
      'responses': 7,
      'connected': 4,
      'status': 'Pending',
      'response': 39,
      'category': 'Furniture',
      'date': '3 days ago',
    },
  ];

  final List<Map<String, dynamic>> providers = [
    {
      'name': 'TechCare Foundation',
      'type': 'Technology Provider',
      'location': 'Vellore',
      'match': 96,
      'availability': 'Available',
      'verified': true,
    },
    {
      'name': 'Campus Green Collective',
      'type': 'Community Provider',
      'location': 'Katpadi',
      'match': 91,
      'availability': 'Available',
      'verified': true,
    },
    {
      'name': 'Learning Resource Hub',
      'type': 'Education Provider',
      'location': 'Vellore',
      'match': 87,
      'availability': 'Responded',
      'verified': true,
    },
    {
      'name': 'Community Food Network',
      'type': 'Food Provider',
      'location': 'Ranipet',
      'match': 84,
      'availability': 'Available',
      'verified': false,
    },
  ];

  final List<Map<String, dynamic>> messages = [
    {
      'title': 'Provider invitation sent',
      'description': '42 providers were invited for the laptop requirement.',
      'time': '10 min ago',
      'type': 'Invitation',
    },
    {
      'title': 'New provider response',
      'description': 'TechCare Foundation responded to your request.',
      'time': '35 min ago',
      'type': 'Response',
    },
    {
      'title': 'Smart outreach suggestion',
      'description': '8 additional nearby providers may match this requirement.',
      'time': '1 hr ago',
      'type': 'Suggestion',
    },
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return campaigns.where((campaign) {
      final matchesSearch = campaign['title']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          campaign['requirement']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      final matchesFilter = selectedFilter == 'All' ||
          campaign['status'].toString() == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text(
          'Provider Outreach',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showNotifications();
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildTabs(),
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  _buildOverview(scheme),
                  _buildOutreach(scheme),
                  _buildResponses(scheme),
                  _buildHistory(scheme),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateOutreach();
        },
        icon: const Icon(Icons.campaign_rounded),
        label: const Text('New Outreach'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search outreach campaigns...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: IconButton(
            onPressed: _showFilters,
            icon: const Icon(Icons.tune_rounded),
          ),
          filled: true,
          fillColor: const Color(0xFFF1F4F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 52,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final selected = selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverview(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHero(scheme),
        const SizedBox(height: 16),
        _buildStatsGrid(scheme),
        const SizedBox(height: 20),
        _sectionTitle('Smart Outreach Intelligence', 'View insights'),
        const SizedBox(height: 10),
        _buildInsightCard(
          icon: Icons.auto_awesome_rounded,
          title: 'Best outreach opportunity',
          description:
              'Technology providers within 15 km have the highest response probability this week.',
          action: 'Target providers',
          scheme: scheme,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          icon: Icons.schedule_rounded,
          title: 'Best communication time',
          description:
              'Provider responses are 24% higher between 6 PM and 9 PM.',
          action: 'Schedule outreach',
          scheme: scheme,
        ),
        const SizedBox(height: 20),
        _sectionTitle('Active Campaigns', 'View all'),
        const SizedBox(height: 10),
        ...filteredCampaigns.take(3).map(
              (campaign) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _campaignCard(campaign, scheme),
              ),
            ),
        const SizedBox(height: 8),
        _sectionTitle('Recent Communication', 'History'),
        const SizedBox(height: 10),
        ...messages.map(
          (message) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _communicationCard(message, scheme),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildHero(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.forum_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SMART OUTREACH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Connect Requirements\nwith the Right Providers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Reach verified providers using targeted invitations, smart recommendations and measurable communication.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _heroMetric('126', 'Invited'),
              _heroMetric('74', 'Responses'),
              _heroMetric('48', 'Connections'),
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
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(ColorScheme scheme) {
    final stats = [
      ('126', 'Providers Reached', Icons.groups_rounded),
      ('74', 'Responses', Icons.mark_email_read_rounded),
      ('58.7%', 'Response Rate', Icons.insights_rounded),
      ('48', 'Connections', Icons.handshake_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) {
        final item = stats[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE7EBF0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                item.$3,
                color: scheme.primary,
                size: 24,
              ),
              const Spacer(),
              Text(
                item.$1,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                item.$2,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOutreach(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _filterChips(),
        const SizedBox(height: 16),
        _sectionTitle('Outreach Campaigns', '${filteredCampaigns.length} active'),
        const SizedBox(height: 12),
        ...filteredCampaigns.map(
          (campaign) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _campaignCard(campaign, scheme),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _filterChips() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = filter == selectedFilter;

          return ChoiceChip(
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

  Widget _campaignCard(
    Map<String, dynamic> campaign,
    ColorScheme scheme,
  ) {
    final response = campaign['response'] as int;

    return InkWell(
      onTap: () => _showCampaignDetails(campaign),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE6EAF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _categoryIcon(campaign['category'].toString(), scheme),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign['title'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        campaign['requirement'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(campaign['status'].toString()),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _smallStat(
                  Icons.groups_outlined,
                  '${campaign['providers']}',
                  'Invited',
                ),
                _smallStat(
                  Icons.reply_rounded,
                  '${campaign['responses']}',
                  'Responses',
                ),
                _smallStat(
                  Icons.handshake_outlined,
                  '${campaign['connected']}',
                  'Connected',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Response rate',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '$response%',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: response / 100,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 15,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 5),
                Text(
                  campaign['date'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _showCampaignDetails(campaign),
                  child: const Text('View details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallStat(IconData icon, String value, String label) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryIcon(String category, ColorScheme scheme) {
    IconData icon;

    switch (category) {
      case 'Technology':
        icon = Icons.devices_rounded;
        break;
      case 'Food':
        icon = Icons.restaurant_rounded;
        break;
      case 'Education':
        icon = Icons.menu_book_rounded;
        break;
      default:
        icon = Icons.inventory_2_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: scheme.primary,
      ),
    );
  }

  Widget _statusBadge(String status) {
    final isPositive = status == 'High Response';
    final isPending = status == 'Pending';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: isPending
            ? Colors.orange.withValues(alpha: 0.10)
            : isPositive
                ? Colors.green.withValues(alpha: 0.10)
                : Colors.blue.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: isPending
              ? Colors.orange.shade700
              : isPositive
                  ? Colors.green.shade700
                  : Colors.blue.shade700,
        ),
      ),
    );
  }

  Widget _buildResponses(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildResponseSummary(scheme),
        const SizedBox(height: 20),
        _sectionTitle('Provider Responses', 'Sort'),
        const SizedBox(height: 12),
        ...providers.map(
          (provider) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _providerCard(provider, scheme),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildResponseSummary(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE5E9EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Response Performance',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 86,
                height: 86,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.587,
                      strokeWidth: 9,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    Text(
                      '58.7%',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: scheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strong provider engagement',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Your targeted outreach is performing above the community average.',
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
        ],
      ),
    );
  }

  Widget _providerCard(
    Map<String, dynamic> provider,
    ColorScheme scheme,
  ) {
    return InkWell(
      onTap: () => _showProviderDetails(provider),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E9EF)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: scheme.primary.withValues(alpha: 0.10),
              child: Icon(
                Icons.business_rounded,
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          provider['name'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (provider['verified'] == true) ...[
                        const SizedBox(width: 5),
                        Icon(
                          Icons.verified_rounded,
                          size: 16,
                          color: scheme.primary,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider['type'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${provider['location']} • ${provider['availability']}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '${provider['match']}%',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                Text(
                  'match',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Communication History', 'Export'),
        const SizedBox(height: 12),
        ...messages.map(
          (message) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _communicationCard(message, scheme),
          ),
        ),
        const SizedBox(height: 12),
        _buildHistoryTimeline(scheme),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _communicationCard(
    Map<String, dynamic> message,
    ColorScheme scheme,
  ) {
    IconData icon;

    switch (message['type'].toString()) {
      case 'Response':
        icon = Icons.mark_email_read_rounded;
        break;
      case 'Suggestion':
        icon = Icons.auto_awesome_rounded;
        break;
      default:
        icon = Icons.send_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: scheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message['description'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Text(
            message['time'].toString(),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTimeline(ColorScheme scheme) {
    final history = [
      ('Campaign created', 'Laptop Requirement Outreach', 'Today, 9:10 AM'),
      ('Provider invitations sent', '42 providers reached', 'Today, 9:14 AM'),
      ('First response received', 'TechCare Foundation', 'Today, 9:24 AM'),
      ('Connection established', 'Resource exchange initiated', 'Today, 10:05 AM'),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Outreach Timeline',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(
            history.length,
            (index) {
              final item = history[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (index != history.length - 1)
                          Container(
                            width: 2,
                            height: 45,
                            color: scheme.primary.withValues(alpha: 0.15),
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.$1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.$2,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.$3,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String action) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$action opened')),
            );
          },
          child: Text(action),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String description,
    required String action,
    required ColorScheme scheme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: scheme.primary,
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
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$action selected')),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(action),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Outreach Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filters.map((filter) {
                      return ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        onSelected: (_) {
                          setSheetState(() {});
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Apply Filters'),
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

  void _showCreateOutreach() {
    final titleController = TextEditingController();
    final messageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(context).viewInsets.bottom + 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Provider Outreach',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Invite relevant providers to respond to a requirement.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Outreach title',
                    prefixIcon: Icon(Icons.title_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'Technology',
                  decoration: const InputDecoration(
                    labelText: 'Requirement category',
                    prefixIcon: Icon(Icons.category_rounded),
                  ),
                  items: const [
                    'Technology',
                    'Food',
                    'Education',
                    'Furniture',
                    'Clothing',
                    'Other',
                  ]
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'Nearby verified providers',
                  decoration: const InputDecoration(
                    labelText: 'Provider segment',
                    prefixIcon: Icon(Icons.groups_rounded),
                  ),
                  items: const [
                    'Nearby verified providers',
                    'High-trust providers',
                    'Technology providers',
                    'Community organizations',
                    'Previously responsive providers',
                  ]
                      .map(
                        (segment) => DropdownMenuItem(
                          value: segment,
                          child: Text(segment),
                        ),
                      )
                      .toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    hintText: 'Write a clear provider invitation...',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 18),
                _buildOutreachOptions(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Outreach campaign created successfully',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Create Outreach'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOutreachOptions() {
    return Column(
      children: [
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text(
            'Smart provider targeting',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            'Prioritize providers with stronger requirement compatibility.',
          ),
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text(
            'Track responses',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            'Measure invitations, replies and successful connections.',
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  void _showCampaignDetails(Map<String, dynamic> campaign) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      campaign['title'].toString(),
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  _statusBadge(campaign['status'].toString()),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                campaign['requirement'].toString(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
              _detailRow(
                Icons.groups_rounded,
                'Providers invited',
                '${campaign['providers']}',
              ),
              _detailRow(
                Icons.mark_email_read_rounded,
                'Responses',
                '${campaign['responses']}',
              ),
              _detailRow(
                Icons.handshake_rounded,
                'Connections',
                '${campaign['connected']}',
              ),
              _detailRow(
                Icons.insights_rounded,
                'Response rate',
                '${campaign['response']}%',
              ),
              _detailRow(
                Icons.category_rounded,
                'Category',
                campaign['category'].toString(),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(this.context).showSnackBar(
                          const SnackBar(
                            content: Text('Campaign paused'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.pause_rounded),
                      label: const Text('Pause'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(this.context).showSnackBar(
                          const SnackBar(
                            content: Text('More providers targeted'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Expand'),
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

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  void _showProviderDetails(Map<String, dynamic> provider) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final match = provider['match'] as int;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 32,
                child: const Icon(Icons.business_rounded),
              ),
              const SizedBox(height: 12),
              Text(
                provider['name'].toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                provider['type'].toString(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 18),
              LinearProgressIndicator(value: match / 100),
              const SizedBox(height: 6),
              Text(
                '$match% requirement compatibility',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.location_on_outlined,
                'Location',
                provider['location'].toString(),
              ),
              _detailRow(
                Icons.check_circle_outline_rounded,
                'Availability',
                provider['availability'].toString(),
              ),
              _detailRow(
                Icons.verified_outlined,
                'Verification',
                provider['verified'] == true ? 'Verified' : 'Pending',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Message sent to ${provider['name']}',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat_rounded),
                  label: const Text('Contact Provider'),
                ),
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
      showDragHandle: true,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
          children: [
            const Text(
              'Outreach Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.reply_rounded),
              ),
              title: Text('New provider response'),
              subtitle: Text('TechCare Foundation responded'),
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.auto_awesome_rounded),
              ),
              title: Text('Smart recommendation'),
              subtitle: Text('8 more providers may match'),
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.trending_up_rounded),
              ),
              title: Text('Response rate increased'),
              subtitle: Text('Your outreach is performing well'),
            ),
          ],
        );
      },
    );
  }
}