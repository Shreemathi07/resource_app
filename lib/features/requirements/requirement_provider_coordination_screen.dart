import 'package:flutter/material.dart';

class RequirementProviderCoordinationScreen extends StatefulWidget {
  const RequirementProviderCoordinationScreen({super.key});

  @override
  State<RequirementProviderCoordinationScreen> createState() =>
      _RequirementProviderCoordinationScreenState();
}

class _RequirementProviderCoordinationScreenState
    extends State<RequirementProviderCoordinationScreen> {
  int selectedTab = 0;
  int selectedPeriod = 1;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Providers',
    'Pending',
    'Performance',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> filters = [
    'All',
    'Active',
    'Pending',
    'Delayed',
    'Completed',
  ];

  final List<Map<String, dynamic>> providers = [
    {
      'name': 'Green Campus Initiative',
      'category': 'Education',
      'resource': 'Reusable Study Kits',
      'quantity': '45 kits',
      'status': 'Active',
      'location': 'Vellore',
      'distance': '2.4 km',
      'reliability': 96,
      'response': '12 min',
      'rating': 4.9,
      'verified': true,
      'color': Colors.indigo,
    },
    {
      'name': 'Arun Kumar',
      'category': 'Technology',
      'resource': 'Desktop Computers',
      'quantity': '12 units',
      'status': 'Pending',
      'location': 'Katpadi',
      'distance': '4.8 km',
      'reliability': 92,
      'response': '28 min',
      'rating': 4.7,
      'verified': true,
      'color': Colors.teal,
    },
    {
      'name': 'Vellore Community Kitchen',
      'category': 'Food',
      'resource': 'Food Support',
      'quantity': '120 meals',
      'status': 'Active',
      'location': 'Vellore',
      'distance': '3.1 km',
      'reliability': 95,
      'response': '18 min',
      'rating': 4.8,
      'verified': true,
      'color': Colors.orange,
    },
    {
      'name': 'Hope Community Center',
      'category': 'Healthcare',
      'resource': 'Medical Equipment',
      'quantity': '8 units',
      'status': 'Completed',
      'location': 'Sathuvachari',
      'distance': '6.2 km',
      'reliability': 98,
      'response': '9 min',
      'rating': 5.0,
      'verified': true,
      'color': Colors.green,
    },
    {
      'name': 'Student Resource Club',
      'category': 'Stationery',
      'resource': 'Notebook Collection',
      'quantity': '200 items',
      'status': 'Delayed',
      'location': 'Gandhi Nagar',
      'distance': '5.6 km',
      'reliability': 81,
      'response': '1 hr',
      'rating': 4.2,
      'verified': false,
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> pendingActions = [
    {
      'title': 'Provider confirmation required',
      'provider': 'Arun Kumar',
      'resource': 'Desktop Computers',
      'due': 'Due in 25 min',
      'priority': 'High',
      'icon': Icons.pending_actions_outlined,
    },
    {
      'title': 'Pickup details need confirmation',
      'provider': 'Vellore Community Kitchen',
      'resource': 'Food Support',
      'due': 'Due today',
      'priority': 'Medium',
      'icon': Icons.location_on_outlined,
    },
    {
      'title': 'Availability update requested',
      'provider': 'Student Resource Club',
      'resource': 'Notebook Collection',
      'due': 'Due tomorrow',
      'priority': 'Low',
      'icon': Icons.update_outlined,
    },
  ];

  final List<Map<String, dynamic>> performanceData = [
    {
      'name': 'Green Campus Initiative',
      'score': 96,
      'completed': 38,
      'response': '12 min',
    },
    {
      'name': 'Hope Community Center',
      'score': 98,
      'completed': 31,
      'response': '9 min',
    },
    {
      'name': 'Vellore Community Kitchen',
      'score': 95,
      'completed': 27,
      'response': '18 min',
    },
    {
      'name': 'Arun Kumar',
      'score': 92,
      'completed': 21,
      'response': '28 min',
    },
  ];

  List<Map<String, dynamic>> get filteredProviders {
    return providers.where((provider) {
      final name = provider['name'].toString().toLowerCase();
      final resource = provider['resource'].toString().toLowerCase();
      final category = provider['category'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          name.contains(query) ||
          resource.contains(query) ||
          category.contains(query);

      bool matchesFilter = true;

      if (selectedFilter == 'Active') {
        matchesFilter = provider['status'] == 'Active';
      } else if (selectedFilter == 'Pending') {
        matchesFilter = provider['status'] == 'Pending';
      } else if (selectedFilter == 'Delayed') {
        matchesFilter = provider['status'] == 'Delayed';
      } else if (selectedFilter == 'Completed') {
        matchesFilter = provider['status'] == 'Completed';
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
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Provider Coordination',
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
        onPressed: _showCoordinationSheet,
        icon: const Icon(Icons.handshake_outlined),
        label: const Text('Coordinate'),
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
                _buildCoordinationHealth(),
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
            scheme.primary.withValues(alpha: 0.76),
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
                  Icons.groups_2_outlined,
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
                  'Smart Coordination',
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
            'Provider Coordination Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coordinate providers, monitor fulfillment readiness and keep every requirement moving.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('18', 'Active'),
              _heroMetric('5', 'Pending'),
              _heroMetric('93%', 'Reliability'),
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
        hintText: 'Search providers, resources or categories...',
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

  Widget _buildCoordinationHealth() {
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
                  Icons.verified_user_outlined,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coordination Health',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Provider network is performing strongly',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '93%',
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
              value: 0.93,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _healthMetric('Response', '95%'),
              _healthMetric('Reliability', '93%'),
              _healthMetric('Completion', '91%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthMetric(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
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
        return _buildProvidersTab();
      case 2:
        return _buildPendingTab();
      case 3:
        return _buildPerformanceTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Priority Coordination',
          'Providers that need attention',
          Icons.priority_high_rounded,
        ),
        const SizedBox(height: 12),
        ...filteredProviders
            .where(
              (provider) =>
                  provider['status'] == 'Pending' ||
                  provider['status'] == 'Delayed',
            )
            .map(_buildProviderCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Smart Provider Recommendations',
          'Best providers for active requirements',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _buildRecommendationCard(
          'Green Campus Initiative',
          '96% reliability • 2.4 km away',
          'Best match for Education requirements',
          Colors.indigo,
          Icons.school_outlined,
        ),
        _buildRecommendationCard(
          'Hope Community Center',
          '98% reliability • 6.2 km away',
          'Highly reliable Healthcare provider',
          Colors.green,
          Icons.health_and_safety_outlined,
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Active Providers',
          'Currently coordinating fulfillment',
          Icons.groups_outlined,
        ),
        const SizedBox(height: 12),
        ...filteredProviders
            .where((provider) => provider['status'] == 'Active')
            .map(_buildProviderCard),
      ],
    );
  }

  Widget _buildProvidersTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterChips(),
        const SizedBox(height: 16),
        if (filteredProviders.isEmpty)
          _buildEmptyState(
            Icons.groups_outlined,
            'No providers found',
            'Try another search or filter.',
          )
        else
          ...filteredProviders.map(_buildProviderCard),
      ],
    );
  }

  Widget _buildPendingTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Pending Coordination',
          'Actions waiting for provider confirmation',
          Icons.pending_actions_outlined,
        ),
        const SizedBox(height: 12),
        ...pendingActions.map(_buildPendingCard),
        const SizedBox(height: 20),
        _buildEscalationCard(),
      ],
    );
  }

  Widget _buildPerformanceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Provider Performance',
          'Reliability and fulfillment activity',
          Icons.analytics_outlined,
        ),
        const SizedBox(height: 12),
        _buildPerformanceSummary(),
        const SizedBox(height: 18),
        ...performanceData.map(_buildPerformanceCard),
        const SizedBox(height: 18),
        _buildPerformanceInsight(),
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

  Widget _buildProviderCard(Map<String, dynamic> provider) {
    final color = provider['color'] as Color;
    final reliability = provider['reliability'] as int;
    final status = provider['status'].toString();

    final statusColor = status == 'Active'
        ? Colors.green
        : status == 'Pending'
            ? Colors.orange
            : status == 'Delayed'
                ? Colors.red
                : Colors.blue;

    return GestureDetector(
      onTap: () => _showProviderDetails(provider),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: status == 'Delayed'
                ? Colors.red.withValues(alpha: 0.25)
                : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: color.withValues(alpha: 0.12),
                  child: Text(
                    provider['name'].toString().substring(0, 1),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
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
                              provider['name'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          if (provider['verified'] == true)
                            const Icon(
                              Icons.verified_rounded,
                              color: Colors.blue,
                              size: 18,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        provider['role']?.toString() ??
                            provider['category'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        provider['resource'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(status, statusColor),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  _providerStat(
                    Icons.inventory_2_outlined,
                    provider['quantity'].toString(),
                  ),
                  _providerStat(
                    Icons.location_on_outlined,
                    provider['distance'].toString(),
                  ),
                  _providerStat(
                    Icons.speed_outlined,
                    '$reliability%',
                  ),
                  _providerStat(
                    Icons.star_outline_rounded,
                    provider['rating'].toString(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Response ${provider['response']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _showProviderActions(provider),
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 16,
                  ),
                  label: const Text('Coordinate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _providerStat(
    IconData icon,
    String value,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingCard(Map<String, dynamic> action) {
    final priority = action['priority'].toString();

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
              action['icon'] as IconData,
              color: priorityColor,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  action['provider'].toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  action['resource'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    _statusBadge(
                      priority,
                      priorityColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      action['due'].toString(),
                      style: TextStyle(
                        color: priorityColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showPendingActions(action),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary() {
    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            '93%',
            'Avg Reliability',
            Icons.verified_outlined,
            Colors.green,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard(
            '24 min',
            'Avg Response',
            Icons.speed_outlined,
            Colors.indigo,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard(
            '117',
            'Completed',
            Icons.check_circle_outline,
            Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _summaryCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
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

  Widget _buildPerformanceCard(Map<String, dynamic> item) {
    final score = item['score'] as int;

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
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.10),
                child: Text(
                  item['name'].toString().substring(0, 1),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['name'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                '$score%',
                style: TextStyle(
                  color: score >= 95 ? Colors.green : Colors.indigo,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _smallMetric(
                'Completed',
                item['completed'].toString(),
              ),
              _smallMetric(
                'Response',
                item['response'].toString(),
              ),
              _smallMetric(
                'Score',
                '$score/100',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallMetric(
    String title,
    String value,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(
    String name,
    String stats,
    String reason,
    Color color,
    IconData icon,
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
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stats,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reason,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showSnackBar('Provider selected for coordination');
            },
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
          color: Colors.red.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Escalation',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'One provider is showing delayed response behaviour. Consider sending a follow-up.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showSnackBar('Escalation action opened');
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceInsight() {
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
                  'Coordination Insight',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Verified providers with faster response times are completing requirements more consistently.',
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

  Widget _statusBadge(
    String text,
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

  void _showProviderDetails(Map<String, dynamic> provider) {
    final color = provider['color'] as Color;

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
                      radius: 28,
                      backgroundColor: color.withValues(alpha: 0.12),
                      child: Text(
                        provider['name'].toString().substring(0, 1),
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider['name'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 19,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            provider['category'].toString(),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (provider['verified'] == true)
                      const Icon(
                        Icons.verified_rounded,
                        color: Colors.blue,
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Resource',
                  provider['resource'].toString(),
                ),
                _detailRow(
                  Icons.numbers_outlined,
                  'Quantity',
                  provider['quantity'].toString(),
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  provider['location'].toString(),
                ),
                _detailRow(
                  Icons.route_outlined,
                  'Distance',
                  provider['distance'].toString(),
                ),
                _detailRow(
                  Icons.speed_outlined,
                  'Response time',
                  provider['response'].toString(),
                ),
                _detailRow(
                  Icons.star_outline_rounded,
                  'Community rating',
                  provider['rating'].toString(),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Reliability',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: (provider['reliability'] as int) / 100,
                    minHeight: 9,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${provider['reliability']}% provider reliability',
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
                          _showSnackBar('Message composer opened');
                        },
                        icon: const Icon(Icons.chat_outlined),
                        label: const Text('Message'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Provider added to coordination',
                          );
                        },
                        icon: const Icon(Icons.handshake_outlined),
                        label: const Text('Coordinate'),
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
            size: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 11),
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

  void _showProviderActions(Map<String, dynamic> provider) {
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
                leading: const Icon(Icons.chat_outlined),
                title: const Text('Send message'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Message composer opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: const Text('Schedule coordination'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Coordination schedule opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('View location'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Provider location opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share requirement details'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Requirement details shared');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPendingActions(Map<String, dynamic> action) {
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
                title: const Text('Send follow-up'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Follow-up sent');
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: const Text('Snooze action'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Action snoozed');
                },
              ),
              ListTile(
                leading: const Icon(Icons.done_all_outlined),
                title: const Text('Mark as completed'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Coordination action completed');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCoordinationSheet() {
    String selectedProvider = providers.first['name'].toString();
    String selectedAction = 'Confirm Availability';

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
                      'Coordinate Provider',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Create a coordination action for an active requirement.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      initialValue: selectedProvider,
                      decoration: const InputDecoration(
                        labelText: 'Provider',
                        border: OutlineInputBorder(),
                      ),
                      items: providers
                          .map(
                            (provider) => DropdownMenuItem<String>(
                              value: provider['name'].toString(),
                              child: Text(
                                provider['name'].toString(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedProvider = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedAction,
                      decoration: const InputDecoration(
                        labelText: 'Coordination Action',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Confirm Availability',
                          child: Text('Confirm Availability'),
                        ),
                        DropdownMenuItem(
                          value: 'Schedule Pickup',
                          child: Text('Schedule Pickup'),
                        ),
                        DropdownMenuItem(
                          value: 'Request Update',
                          child: Text('Request Update'),
                        ),
                        DropdownMenuItem(
                          value: 'Verify Resource',
                          child: Text('Verify Resource'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedAction = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            'Add coordination notes for $selectedProvider...',
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
                            '$selectedAction created for $selectedProvider',
                          );
                        },
                        icon: const Icon(Icons.handshake_outlined),
                        label: const Text(
                          'Create Coordination',
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
                  'Provider Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                ...filters.map(
                  (filter) => ListTile(
                    leading: Icon(
                      filter == 'Active'
                          ? Icons.check_circle_outline
                          : filter == 'Pending'
                              ? Icons.pending_outlined
                              : filter == 'Delayed'
                                  ? Icons.warning_amber_outlined
                                  : filter == 'Completed'
                                      ? Icons.task_alt_outlined
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
                  'Provider Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                _notificationItem(
                  Icons.pending_actions_outlined,
                  '5 provider confirmations are pending',
                  'Just now',
                ),
                _notificationItem(
                  Icons.verified_outlined,
                  'A provider completed verification',
                  '18 min ago',
                ),
                _notificationItem(
                  Icons.warning_amber_outlined,
                  'One provider response is delayed',
                  '42 min ago',
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

    _showSnackBar('Provider coordination refreshed');
  }
}