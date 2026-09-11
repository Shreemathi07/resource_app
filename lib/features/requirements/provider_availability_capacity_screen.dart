import 'package:flutter/material.dart';

class ProviderAvailabilityCapacityScreen extends StatefulWidget {
  const ProviderAvailabilityCapacityScreen({super.key});

  @override
  State<ProviderAvailabilityCapacityScreen> createState() =>
      _ProviderAvailabilityCapacityScreenState();
}

class _ProviderAvailabilityCapacityScreenState
    extends State<ProviderAvailabilityCapacityScreen> {
  int selectedTab = 0;
  int selectedPeriod = 1;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Availability',
    'Capacity',
    'Insights',
  ];

  final List<String> periods = [
    '7 Days',
    '30 Days',
    '3 Months',
    '1 Year',
  ];

  final List<String> filters = [
    'All',
    'Available',
    'Limited',
    'Busy',
    'Unavailable',
  ];

  final List<Map<String, dynamic>> providers = [
    {
      'name': 'Green Campus Initiative',
      'category': 'Education',
      'resource': 'Study Kits',
      'capacity': 82,
      'available': 45,
      'total': 55,
      'status': 'Available',
      'location': 'Vellore',
      'nextAvailable': 'Today, 4:00 PM',
      'slots': '6 slots',
      'reliability': 96,
      'color': Colors.indigo,
      'icon': Icons.school_outlined,
    },
    {
      'name': 'Vellore Community Kitchen',
      'category': 'Food',
      'resource': 'Meal Support',
      'capacity': 68,
      'available': 120,
      'total': 175,
      'status': 'Available',
      'location': 'Vellore',
      'nextAvailable': 'Tomorrow, 11:30 AM',
      'slots': '4 slots',
      'reliability': 95,
      'color': Colors.orange,
      'icon': Icons.restaurant_outlined,
    },
    {
      'name': 'Arun Kumar',
      'category': 'Technology',
      'resource': 'Desktop Computers',
      'capacity': 42,
      'available': 12,
      'total': 28,
      'status': 'Limited',
      'location': 'Katpadi',
      'nextAvailable': 'Tomorrow, 2:00 PM',
      'slots': '2 slots',
      'reliability': 92,
      'color': Colors.teal,
      'icon': Icons.computer_outlined,
    },
    {
      'name': 'Hope Community Center',
      'category': 'Healthcare',
      'resource': 'Medical Equipment',
      'capacity': 91,
      'available': 8,
      'total': 9,
      'status': 'Busy',
      'location': 'Sathuvachari',
      'nextAvailable': 'Sep 9, 10:00 AM',
      'slots': '1 slot',
      'reliability': 98,
      'color': Colors.green,
      'icon': Icons.health_and_safety_outlined,
    },
    {
      'name': 'Student Resource Club',
      'category': 'Stationery',
      'resource': 'Notebook Collection',
      'capacity': 24,
      'available': 200,
      'total': 840,
      'status': 'Limited',
      'location': 'Gandhi Nagar',
      'nextAvailable': 'Sep 10, 9:00 AM',
      'slots': '3 slots',
      'reliability': 81,
      'color': Colors.purple,
      'icon': Icons.menu_book_outlined,
    },
    {
      'name': 'Community Tool Library',
      'category': 'Tools',
      'resource': 'Repair Tools',
      'capacity': 15,
      'available': 5,
      'total': 34,
      'status': 'Unavailable',
      'location': 'Katpadi',
      'nextAvailable': 'Sep 12, 3:00 PM',
      'slots': '0 slots',
      'reliability': 88,
      'color': Colors.blueGrey,
      'icon': Icons.handyman_outlined,
    },
  ];

  final List<Map<String, dynamic>> availabilitySlots = [
    {
      'day': 'Today',
      'date': 'Sep 7',
      'time': '4:00 PM - 7:00 PM',
      'provider': 'Green Campus Initiative',
      'type': 'Pickup',
      'status': 'Open',
    },
    {
      'day': 'Tomorrow',
      'date': 'Sep 8',
      'time': '10:00 AM - 1:00 PM',
      'provider': 'Vellore Community Kitchen',
      'type': 'Handover',
      'status': 'Open',
    },
    {
      'day': 'Tomorrow',
      'date': 'Sep 8',
      'time': '2:00 PM - 5:00 PM',
      'provider': 'Arun Kumar',
      'type': 'Pickup',
      'status': 'Limited',
    },
    {
      'day': 'Wednesday',
      'date': 'Sep 9',
      'time': '10:00 AM - 12:00 PM',
      'provider': 'Hope Community Center',
      'type': 'Handover',
      'status': 'Limited',
    },
  ];

  final List<Map<String, dynamic>> capacityAlerts = [
    {
      'title': 'Low available capacity',
      'provider': 'Community Tool Library',
      'message': 'Only 5 units are currently available.',
      'priority': 'High',
      'icon': Icons.inventory_2_outlined,
    },
    {
      'title': 'Provider nearing capacity',
      'provider': 'Hope Community Center',
      'message': 'Current workload has reached 91%.',
      'priority': 'Medium',
      'icon': Icons.speed_outlined,
    },
    {
      'title': 'Availability window closing',
      'provider': 'Arun Kumar',
      'message': 'Current pickup window has limited slots.',
      'priority': 'Medium',
      'icon': Icons.schedule_outlined,
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

      if (selectedFilter != 'All') {
        matchesFilter = provider['status'] == selectedFilter;
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
          'Availability & Capacity',
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
        onPressed: _showUpdateAvailabilitySheet,
        icon: const Icon(Icons.edit_calendar_outlined),
        label: const Text('Update Availability'),
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
                _buildCapacityHealth(),
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
            scheme.primary.withValues(alpha: 0.74),
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
                  Icons.event_available_outlined,
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
                  'Live Capacity',
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
            'Provider Availability Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'See when providers are available, how much capacity they have and when to coordinate the next exchange.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric('24', 'Available'),
              _heroMetric('78%', 'Capacity'),
              _heroMetric('11', 'Open Slots'),
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

  Widget _buildCapacityHealth() {
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
                  Icons.donut_large_outlined,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Network Capacity Health',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Healthy balance across active providers',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '78%',
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
              value: 0.78,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _healthMetric('Available', '24'),
              _healthMetric('Limited', '6'),
              _healthMetric('Busy', '3'),
              _healthMetric('Offline', '2'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthMetric(
    String title,
    String value,
  ) {
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
        return _buildAvailabilityTab();
      case 2:
        return _buildCapacityTab();
      case 3:
        return _buildInsightsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Availability Today',
          'Best windows for upcoming exchanges',
          Icons.today_outlined,
        ),
        const SizedBox(height: 12),
        ...availabilitySlots.take(3).map(_buildAvailabilityCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Capacity Alerts',
          'Providers that may need attention',
          Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 12),
        ...capacityAlerts.take(2).map(_buildAlertCard),
        const SizedBox(height: 18),
        _sectionTitle(
          'Recommended Providers',
          'Based on availability and capacity',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        ...filteredProviders
            .where(
              (provider) =>
                  provider['status'] == 'Available' &&
                  provider['capacity'] < 90,
            )
            .take(3)
            .map(_buildProviderCard),
      ],
    );
  }

  Widget _buildAvailabilityTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvailabilitySummary(),
        const SizedBox(height: 18),
        _sectionTitle(
          'Upcoming Availability',
          'Open provider windows',
          Icons.calendar_month_outlined,
        ),
        const SizedBox(height: 12),
        ...availabilitySlots.map(_buildAvailabilityCard),
        const SizedBox(height: 18),
        _buildSmartSchedulingCard(),
      ],
    );
  }

  Widget _buildCapacityTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCapacitySummary(),
        const SizedBox(height: 18),
        _buildFilterChips(),
        const SizedBox(height: 16),
        if (filteredProviders.isEmpty)
          _buildEmptyState(
            Icons.inventory_2_outlined,
            'No providers found',
            'Try another search or capacity filter.',
          )
        else
          ...filteredProviders.map(_buildProviderCard),
      ],
    );
  }

  Widget _buildInsightsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Capacity Intelligence',
          'Patterns detected across the provider network',
          Icons.insights_outlined,
        ),
        const SizedBox(height: 12),
        _buildIntelligenceCard(
          'Morning capacity is strongest',
          'Providers have 18% more available capacity between 9 AM and 1 PM.',
          Icons.wb_sunny_outlined,
          Colors.orange,
        ),
        _buildIntelligenceCard(
          'Technology resources are constrained',
          'Computer and device availability is lower than the network average.',
          Icons.devices_outlined,
          Colors.indigo,
        ),
        _buildIntelligenceCard(
          'Weekend demand may increase',
          'Historical exchange activity suggests higher community demand on weekends.',
          Icons.trending_up_rounded,
          Colors.green,
        ),
        const SizedBox(height: 18),
        _buildCapacityForecast(),
        const SizedBox(height: 18),
        _buildSmartRecommendation(),
      ],
    );
  }

  Widget _buildAvailabilitySummary() {
    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            '11',
            'Open Slots',
            Icons.event_available_outlined,
            Colors.green,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard(
            '24',
            'Available',
            Icons.groups_outlined,
            Colors.indigo,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard(
            '6',
            'Limited',
            Icons.schedule_outlined,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildCapacitySummary() {
    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            '78%',
            'Utilization',
            Icons.donut_large_outlined,
            Colors.teal,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard(
            '1,240',
            'Units Available',
            Icons.inventory_2_outlined,
            Colors.indigo,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard(
            '93%',
            'Reliability',
            Icons.verified_outlined,
            Colors.green,
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
          const SizedBox(height: 11),
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
    final capacity = provider['capacity'] as int;
    final status = provider['status'].toString();

    final statusColor = status == 'Available'
        ? Colors.green
        : status == 'Limited'
            ? Colors.orange
            : status == 'Busy'
                ? Colors.red
                : Colors.grey;

    return GestureDetector(
      onTap: () => _showProviderDetails(provider),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: status == 'Unavailable'
                ? Colors.grey.shade300
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
                  child: Icon(
                    provider['icon'] as IconData,
                    color: color,
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
                          if (provider['reliability'] >= 90)
                            const Icon(
                              Icons.verified_rounded,
                              color: Colors.blue,
                              size: 17,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        provider['category'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 6),
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
            Row(
              children: [
                Text(
                  'Capacity',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const Spacer(),
                Text(
                  '$capacity%',
                  style: TextStyle(
                    color: capacity >= 90
                        ? Colors.red
                        : capacity >= 70
                            ? Colors.orange
                            : Colors.green,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: capacity / 100,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 13),
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  _providerStat(
                    Icons.inventory_2_outlined,
                    '${provider['available']} available',
                  ),
                  _providerStat(
                    Icons.location_on_outlined,
                    provider['location'].toString(),
                  ),
                  _providerStat(
                    Icons.schedule_outlined,
                    provider['slots'].toString(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                Icon(
                  Icons.event_available_outlined,
                  size: 15,
                  color: Colors.green.shade600,
                ),
                const SizedBox(width: 5),
                Text(
                  provider['nextAvailable'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _showProviderActions(provider),
                  child: const Text('Manage'),
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

  Widget _buildAvailabilityCard(Map<String, dynamic> slot) {
    final isLimited = slot['status'] == 'Limited';
    final color = isLimited ? Colors.orange : Colors.green;

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
        children: [
          Container(
            width: 62,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  slot['day'].toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  slot['date'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slot['provider'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  slot['time'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      slot['type'] == 'Pickup'
                          ? Icons.local_shipping_outlined
                          : Icons.handshake_outlined,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      slot['type'].toString(),
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
          _statusBadge(
            slot['status'].toString(),
            color,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final priority = alert['priority'].toString();
    final color = priority == 'High' ? Colors.red : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              alert['icon'] as IconData,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert['provider'].toString(),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  alert['message'].toString(),
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
              _showSnackBar('Capacity alert opened');
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartSchedulingCard() {
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
              .withValues(alpha: 0.10),
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
                  'Smart Scheduling Suggestion',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'The best coordination window is tomorrow between 10 AM and 1 PM based on provider availability and expected demand.',
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

  Widget _buildIntelligenceCard(
    String title,
    String message,
    IconData icon,
    Color color,
  ) {
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

  Widget _buildCapacityForecast() {
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
            '7-Day Capacity Forecast',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Expected network utilization',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _forecastBar('M', 0.62),
              _forecastBar('T', 0.71),
              _forecastBar('W', 0.78),
              _forecastBar('T', 0.67),
              _forecastBar('F', 0.84),
              _forecastBar('S', 0.91),
              _forecastBar('S', 0.74),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastBar(
    String day,
    double value,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${(value * 100).round()}%',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 100 * value,
            width: 18,
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
            day,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
              fontWeight: FontWeight.w700,
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
        color: Colors.green.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Capacity Recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Prioritize providers below 70% utilization for new requirements. This can improve fulfillment speed while avoiding provider overload.',
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
    final capacity = provider['capacity'] as int;

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
                      child: Icon(
                        provider['icon'] as IconData,
                        color: color,
                        size: 27,
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
                    _statusBadge(
                      provider['status'].toString(),
                      provider['status'] == 'Available'
                          ? Colors.green
                          : Colors.orange,
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
                  'Available',
                  '${provider['available']} units',
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  provider['location'].toString(),
                ),
                _detailRow(
                  Icons.event_available_outlined,
                  'Next availability',
                  provider['nextAvailable'].toString(),
                ),
                _detailRow(
                  Icons.schedule_outlined,
                  'Open slots',
                  provider['slots'].toString(),
                ),
                _detailRow(
                  Icons.verified_outlined,
                  'Reliability',
                  '${provider['reliability']}%',
                ),
                const SizedBox(height: 12),
                const Text(
                  'Capacity Utilization',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: capacity / 100,
                    minHeight: 9,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '$capacity% of current capacity is utilized',
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
                          _showSnackBar('Availability calendar opened');
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                        label: const Text('Calendar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _showSnackBar(
                            'Provider selected for coordination',
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
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('View availability'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Availability calendar opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_calendar_outlined),
                title: const Text('Update capacity'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showUpdateCapacitySheet(provider);
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule_outlined),
                title: const Text('Manage time slots'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Time slot manager opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.handshake_outlined),
                title: const Text('Coordinate exchange'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar('Exchange coordination started');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateAvailabilitySheet() {
    String selectedStatus = 'Available';
    String selectedWindow = 'Today, 4:00 PM';

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
                      'Update Availability',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Set the current availability status and next coordination window.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Availability Status',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Available',
                          child: Text('Available'),
                        ),
                        DropdownMenuItem(
                          value: 'Limited',
                          child: Text('Limited'),
                        ),
                        DropdownMenuItem(
                          value: 'Busy',
                          child: Text('Busy'),
                        ),
                        DropdownMenuItem(
                          value: 'Unavailable',
                          child: Text('Unavailable'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedStatus = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedWindow,
                      decoration: const InputDecoration(
                        labelText: 'Next Available Window',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Today, 4:00 PM',
                          child: Text('Today, 4:00 PM'),
                        ),
                        DropdownMenuItem(
                          value: 'Tomorrow, 10:00 AM',
                          child: Text('Tomorrow, 10:00 AM'),
                        ),
                        DropdownMenuItem(
                          value: 'Tomorrow, 2:00 PM',
                          child: Text('Tomorrow, 2:00 PM'),
                        ),
                        DropdownMenuItem(
                          value: 'Sep 10, 9:00 AM',
                          child: Text('Sep 10, 9:00 AM'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedWindow = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add availability notes...',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
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
                            'Availability updated to $selectedStatus',
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Save Availability',
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

  void _showUpdateCapacitySheet(Map<String, dynamic> provider) {
    double capacity = (provider['capacity'] as int).toDouble();

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
                  Text(
                    'Update ${provider['name']} Capacity',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adjust current capacity utilization.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      '${capacity.round()}%',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Slider(
                    value: capacity,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: '${capacity.round()}%',
                    onChanged: (value) {
                      setSheetState(() {
                        capacity = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Capacity updated to ${capacity.round()}%',
                        );
                      },
                      child: const Text(
                        'Save Capacity',
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
                  'Capacity Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                ...filters.map(
                  (filter) => ListTile(
                    leading: Icon(
                      filter == 'Available'
                          ? Icons.check_circle_outline
                          : filter == 'Limited'
                              ? Icons.warning_amber_outlined
                              : filter == 'Busy'
                                  ? Icons.speed_outlined
                                  : filter == 'Unavailable'
                                      ? Icons.block_outlined
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
                  'Availability Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                _notificationItem(
                  Icons.warning_amber_outlined,
                  'One provider has reached 91% capacity',
                  'Just now',
                ),
                _notificationItem(
                  Icons.event_available_outlined,
                  'New pickup slot opened for tomorrow',
                  '18 min ago',
                ),
                _notificationItem(
                  Icons.inventory_2_outlined,
                  'Technology resource capacity is limited',
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

    _showSnackBar('Availability and capacity refreshed');
  }
}