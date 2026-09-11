import 'package:flutter/material.dart';

class ExchangeLogisticsScreen extends StatefulWidget {
  const ExchangeLogisticsScreen({super.key});

  @override
  State<ExchangeLogisticsScreen> createState() =>
      _ExchangeLogisticsScreenState();
}

class _ExchangeLogisticsScreenState extends State<ExchangeLogisticsScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Overview',
    'Schedule',
    'Checklist',
    'Issues',
  ];

  final List<Map<String, dynamic>> _exchanges = [
    {
      'title': 'Laptop Donation',
      'resource': '5 Refurbished Laptops',
      'provider': 'VIT Resource Hub',
      'receiver': 'Community Learning Center',
      'location': 'Katpadi Community Hall',
      'distance': '3.8 km',
      'time': 'Today, 4:30 PM',
      'status': 'Ready for Pickup',
      'progress': 0.72,
      'icon': Icons.laptop_mac_rounded,
    },
    {
      'title': 'Study Material Exchange',
      'resource': '120 Engineering Books',
      'provider': 'Student Resource Network',
      'receiver': 'Rural Learning Centre',
      'location': 'Vellore Bus Stand',
      'distance': '6.2 km',
      'time': 'Tomorrow, 10:00 AM',
      'status': 'Scheduled',
      'progress': 0.52,
      'icon': Icons.menu_book_rounded,
    },
    {
      'title': 'Furniture Redistribution',
      'resource': '8 Study Tables',
      'provider': 'Campus Innovation Lab',
      'receiver': 'Government School',
      'location': 'Sathuvachari School',
      'distance': '9.5 km',
      'time': 'Sep 8, 2:00 PM',
      'status': 'Confirmed',
      'progress': 0.35,
      'icon': Icons.table_restaurant_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
 
  

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exchange Logistics',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: _showNotifications,
            icon: const Badge(
              label: Text('2'),
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
          IconButton(
            tooltip: 'More',
            onPressed: _showMoreOptions,
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createExchange,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Plan Exchange'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHero(context),
            ),
            SliverToBoxAdapter(
              child: _buildStats(context),
            ),
            SliverToBoxAdapter(
              child: _buildTabs(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    if (_selectedTab == 0) ...[
                      _buildLiveExchange(context),
                      const SizedBox(height: 20),
                      _buildUpcomingExchanges(context),
                      const SizedBox(height: 20),
                      _buildRouteOverview(context),
                      const SizedBox(height: 20),
                      _buildLogisticsPerformance(context),
                    ],
                    if (_selectedTab == 1) ...[
                      _buildScheduleView(context),
                      const SizedBox(height: 20),
                      _buildTimeSlotCard(context),
                    ],
                    if (_selectedTab == 2) ...[
                      _buildChecklist(context),
                      const SizedBox(height: 20),
                      _buildSafeHandover(context),
                      const SizedBox(height: 20),
                      _buildExchangeReceipt(context),
                    ],
                    if (_selectedTab == 3) ...[
                      _buildIssueCenter(context),
                      const SizedBox(height: 20),
                      _buildDelayReporting(context),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: colorScheme.onPrimary,
                  size: 28,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'Exchange Logistics',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Coordinate every handover from pickup to completion in one place.',
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.82),
              height: 1.4,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric(
                context,
                '3',
                'Active',
              ),
              _heroMetric(
                context,
                '12',
                'Completed',
              ),
              _heroMetric(
                context,
                '94%',
                'On-time',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(
    BuildContext context,
    String value,
    String label,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.72),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final stats = [
      (
        'Active',
        '3',
        Icons.sync_rounded,
      ),
      (
        'Today',
        '1',
        Icons.today_rounded,
      ),
      (
        'Pending',
        '4',
        Icons.pending_actions_rounded,
      ),
      (
        'Issues',
        '1',
        Icons.warning_amber_rounded,
      ),
    ];

    return SizedBox(
      height: 106,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final stat = stats[index];

          return Container(
            width: 118,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.48,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colorScheme.outlineVariant,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  stat.$3,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const Spacer(),
                Text(
                  stat.$2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  stat.$1,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 54,
      margin: const EdgeInsets.only(top: 4),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedTab == index;

          return ChoiceChip(
            label: Text(_tabs[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedTab = index;
              });
            },
            selectedColor: colorScheme.primaryContainer,
            labelStyle: TextStyle(
              color: selected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLiveExchange(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final exchange = _exchanges.first;

    return _sectionCard(
      context,
      title: 'Live Exchange',
      icon: Icons.bolt_rounded,
      trailing: TextButton(
        onPressed: () => _showExchangeDetails(exchange),
        child: const Text('Track'),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _resourceIcon(
                context,
                exchange['icon'] as IconData,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exchange['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exchange['resource'] as String,
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _statusChip(
                context,
                exchange['status'] as String,
              ),
            ],
          ),
          const SizedBox(height: 18),
          _progressLine(
            context,
            exchange['progress'] as double,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Pickup confirmed',
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              const Text(
                '72%',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _locationRow(
            context,
            Icons.person_pin_circle_rounded,
            exchange['provider'] as String,
            'Provider',
          ),
          const SizedBox(height: 12),
          _locationRow(
            context,
            Icons.location_on_rounded,
            exchange['location'] as String,
            '${exchange['distance']} • Handover point',
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingExchanges(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Upcoming Exchanges',
      icon: Icons.calendar_month_rounded,
      trailing: TextButton(
        onPressed: () {
          setState(() {
            _selectedTab = 1;
          });
        },
        child: const Text('View all'),
      ),
      child: Column(
        children: [
          for (int i = 1; i < _exchanges.length; i++) ...[
            _exchangeTile(
              context,
              _exchanges[i],
            ),
            if (i != _exchanges.length - 1)
              const Divider(height: 25),
          ],
        ],
      ),
    );
  }

  Widget _exchangeTile(
    BuildContext context,
    Map<String, dynamic> exchange,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _showExchangeDetails(exchange),
      child: Row(
        children: [
          _resourceIcon(
            context,
            exchange['icon'] as IconData,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exchange['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exchange['time'] as String,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }

  Widget _buildRouteOverview(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Route Overview',
      icon: Icons.route_rounded,
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RoutePainter(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 32,
                  child: _mapPoint(
                    context,
                    Icons.inventory_2_rounded,
                    'Pickup',
                  ),
                ),
                Positioned(
                  right: 34,
                  bottom: 28,
                  child: _mapPoint(
                    context,
                    Icons.home_work_rounded,
                    'Handover',
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black.withValues(alpha: 0.08),
                        ),
                      ],
                    ),
                    child: const Text(
                      '3.8 km • 14 min',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.directions_car_rounded,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Fastest suggested route',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '3.8 km',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogisticsPerformance(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Logistics Performance',
      icon: Icons.analytics_rounded,
      child: Column(
        children: [
          _performanceRow(
            context,
            'On-time exchanges',
            0.94,
            '94%',
          ),
          const SizedBox(height: 17),
          _performanceRow(
            context,
            'Successful handovers',
            0.97,
            '97%',
          ),
          const SizedBox(height: 17),
          _performanceRow(
            context,
            'Checklist completion',
            0.89,
            '89%',
          ),
          const SizedBox(height: 17),
          _performanceRow(
            context,
            'Issue-free exchanges',
            0.92,
            '92%',
          ),
          const SizedBox(height: 15),
          Divider(
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 7),
              Text(
                '+8% improvement this month',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleView(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Exchange Schedule',
      icon: Icons.schedule_rounded,
      trailing: IconButton(
        onPressed: _selectDate,
        icon: const Icon(Icons.calendar_today_rounded),
      ),
      child: Column(
        children: [
          _scheduleItem(
            context,
            'Today',
            '4:30 PM',
            'Laptop Donation',
            'Katpadi Community Hall',
            true,
          ),
          _scheduleItem(
            context,
            'Tomorrow',
            '10:00 AM',
            'Study Material Exchange',
            'Vellore Bus Stand',
            false,
          ),
          _scheduleItem(
            context,
            'Sep 8',
            '2:00 PM',
            'Furniture Redistribution',
            'Sathuvachari School',
            false,
          ),
          _scheduleItem(
            context,
            'Sep 10',
            '11:30 AM',
            'Lab Equipment Exchange',
            'VIT Innovation Centre',
            false,
          ),
        ],
      ),
    );
  }

  Widget _scheduleItem(
    BuildContext context,
    String date,
    String time,
    String title,
    String location,
    bool active,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: active
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              children: [
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: active
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: active
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
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
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showScheduleActions(
                context,
                title,
              );
            },
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotCard(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Preferred Time Slots',
      icon: Icons.access_time_filled_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose a time window that works for both sides.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              '9:00 - 11:00 AM',
              '11:00 AM - 1:00 PM',
              '2:00 - 4:00 PM',
              '4:00 - 6:00 PM',
            ].map((slot) {
              return ActionChip(
                avatar: const Icon(
                  Icons.schedule_rounded,
                  size: 16,
                ),
                label: Text(slot),
                onPressed: () {
                  _showMessage('$slot selected');
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      ('Resource quantity verified', true),
      ('Resource condition checked', true),
      ('Pickup location confirmed', true),
      ('Receiver identity verified', false),
      ('Handover proof prepared', false),
      ('Exchange receipt ready', false),
    ];

    return _sectionCard(
      context,
      title: 'Exchange Checklist',
      icon: Icons.checklist_rounded,
      trailing: Text(
        '3 / 6',
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
      child: Column(
        children: [
          for (final item in items)
            CheckboxListTile(
              value: item.$2,
              onChanged: (_) {
                _showMessage(
                  item.$1,
                );
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                item.$1,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: item.$2
                      ? FontWeight.w500
                      : FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSafeHandover(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: colorScheme.tertiary.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield_rounded,
                color: colorScheme.tertiary,
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Safe Handover Guidance',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Use a verified handover point, confirm both parties before exchange, and record the final handover through ResourceX.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: _showSafetyGuidance,
            icon: const Icon(Icons.info_outline_rounded),
            label: const Text('View safety guidelines'),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeReceipt(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Exchange Receipt',
      icon: Icons.receipt_long_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _receiptRow(
            context,
            'Exchange ID',
            'RX-2026-00842',
          ),
          _receiptRow(
            context,
            'Resource',
            '5 Refurbished Laptops',
          ),
          _receiptRow(
            context,
            'Provider',
            'VIT Resource Hub',
          ),
          _receiptRow(
            context,
            'Receiver',
            'Community Learning Center',
          ),
          _receiptRow(
            context,
            'Status',
            'Pending Completion',
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showReceipt,
              icon: const Icon(Icons.visibility_rounded),
              label: const Text('View Exchange Receipt'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueCenter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Issue Center',
      icon: Icons.support_agent_rounded,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.error,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup delayed',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Study Material Exchange • 18 min delay',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _showIssueDetails,
                  child: const Text('Open'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule_rounded),
            title: const Text('Reschedule an exchange'),
            subtitle: const Text(
              'Notify both provider and receiver',
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: _rescheduleExchange,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.report_problem_outlined),
            title: const Text('Report a logistics issue'),
            subtitle: const Text(
              'Create a support ticket',
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: _reportIssue,
          ),
        ],
      ),
    );
  }

  Widget _buildDelayReporting(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Delay Reporting',
      icon: Icons.timer_off_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Is an exchange running late? Record the reason so ResourceX can update both parties.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Traffic',
              'Provider delay',
              'Receiver delay',
              'Location issue',
              'Resource issue',
              'Other',
            ].map((reason) {
              return ActionChip(
                label: Text(reason),
                onPressed: () {
                  _showDelayDialog(reason);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.035),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  size: 19,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
             ?trailing,
            ],
          ),
          const SizedBox(height: 17),
          child,
        ],
      ),
    );
  }

  Widget _resourceIcon(
    BuildContext context,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _statusChip(
    BuildContext context,
    String status,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }

  Widget _progressLine(
    BuildContext context,
    double progress,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
      ),
    );
  }

  Widget _locationRow(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _performanceRow(
    BuildContext context,
    String title,
    double value,
    String percentage,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 38,
          child: Text(
            percentage,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _mapPoint(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: colorScheme.onPrimary,
            size: 19,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _receiptRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    _showMessage('Logistics data refreshed');
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _createExchange() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Plan New Exchange',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                _bottomAction(
                  context,
                  Icons.inventory_2_rounded,
                  'Select Resource',
                  'Choose the resource to exchange',
                  () {
                    Navigator.pop(context);
                    _showMessage('Resource selector opened');
                  },
                ),
                _bottomAction(
                  context,
                  Icons.location_on_rounded,
                  'Choose Handover Point',
                  'Select a safe exchange location',
                  () {
                    Navigator.pop(context);
                    _showMessage('Handover location selector opened');
                  },
                ),
                _bottomAction(
                  context,
                  Icons.schedule_rounded,
                  'Set Schedule',
                  'Coordinate a suitable time',
                  () {
                    Navigator.pop(context);
                    _showMessage('Schedule planner opened');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bottomAction(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _showExchangeDetails(
    Map<String, dynamic> exchange,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _resourceIcon(
                      context,
                      exchange['icon'] as IconData,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            exchange['title'] as String,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exchange['resource'] as String,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _detailRow(
                  context,
                  Icons.person_rounded,
                  'Provider',
                  exchange['provider'] as String,
                ),
                _detailRow(
                  context,
                  Icons.location_on_rounded,
                  'Handover',
                  exchange['location'] as String,
                ),
                _detailRow(
                  context,
                  Icons.route_rounded,
                  'Distance',
                  exchange['distance'] as String,
                ),
                _detailRow(
                  context,
                  Icons.schedule_rounded,
                  'Schedule',
                  exchange['time'] as String,
                ),
                _detailRow(
                  context,
                  Icons.flag_rounded,
                  'Status',
                  exchange['status'] as String,
                ),
                const SizedBox(height: 15),
                _progressLine(
                  context,
                  exchange['progress'] as double,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Exchange journey is progressing normally.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _rescheduleExchange();
                        },
                        child: const Text('Reschedule'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage(
                            'Exchange coordination opened',
                          );
                        },
                        child: const Text('Coordinate'),
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
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            children: const [
              Text(
                'Logistics Notifications',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.warning_amber_rounded),
                title: Text('Pickup delay reported'),
                subtitle: Text('Study Material Exchange'),
              ),
              ListTile(
                leading: Icon(Icons.schedule_rounded),
                title: Text('Exchange starts in 2 hours'),
                subtitle: Text('Laptop Donation'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.history_rounded),
                title: const Text('Logistics History'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Logistics history opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics_rounded),
                title: const Text('Performance Report'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Performance report opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_rounded),
                title: const Text('Logistics Preferences'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Logistics preferences opened');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 90),
      ),
      initialDate: DateTime.now(),
    ).then((date) {
      if (date != null && mounted) {
        _showMessage(
          'Schedule date selected: ${date.day}/${date.month}/${date.year}',
        );
      }
    });
  }

  void _showScheduleActions(
    BuildContext context,
    String title,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit_calendar_rounded),
                title: const Text('Change schedule'),
                onTap: () {
                  Navigator.pop(context);
                  _selectDate();
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on_rounded),
                title: const Text('Change handover point'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Handover location selector opened',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat_rounded),
                title: const Text('Contact exchange participants'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Conversation opened for $title',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSafetyGuidance() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Safe Handover'),
          content: const Text(
            'Use verified locations, confirm the exchange details before handover, keep the resource condition record updated, and mark the exchange complete only after both sides confirm.',
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

  void _showReceipt() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exchange Receipt'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RX-2026-00842',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 14),
              Text('Resource: 5 Refurbished Laptops'),
              SizedBox(height: 6),
              Text('Provider: VIT Resource Hub'),
              SizedBox(height: 6),
              Text(
                'Receiver: Community Learning Center',
              ),
              SizedBox(height: 6),
              Text('Status: Pending Completion'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Receipt shared');
              },
              child: const Text('Share'),
            ),
          ],
        );
      },
    );
  }

  void _showIssueDetails() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pickup Delay'),
          content: const Text(
            'The provider reported an 18-minute delay. Both participants have been notified and the exchange can be rescheduled if required.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _rescheduleExchange();
              },
              child: const Text('Reschedule'),
            ),
          ],
        );
      },
    );
  }

  void _rescheduleExchange() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 60),
      ),
      initialDate: DateTime.now().add(
        const Duration(days: 1),
      ),
    ).then((date) {
      if (date != null && mounted) {
        _showMessage(
          'Exchange rescheduled to ${date.day}/${date.month}/${date.year}',
        );
      }
    });
  }

  void _reportIssue() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Report Logistics Issue',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                for (final issue in [
                  'Pickup delay',
                  'Wrong location',
                  'Resource mismatch',
                  'Participant unavailable',
                  'Other',
                ])
                  ListTile(
                    leading: const Icon(
                      Icons.report_problem_outlined,
                    ),
                    title: Text(issue),
                    onTap: () {
                      Navigator.pop(context);
                      _showMessage(
                        '$issue report created',
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDelayDialog(String reason) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Report Delay'),
          content: Text(
            'Record "$reason" as the reason for the exchange delay?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage(
                  'Delay reported: $reason',
                );
              },
              child: const Text('Report'),
            ),
          ],
        );
      },
    );
  }
}

class _RoutePainter extends CustomPainter {
  final Color color;

  _RoutePainter({
    required this.color,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(
      size.width * 0.18,
      size.height * 0.27,
    );

    path.cubicTo(
      size.width * 0.32,
      size.height * 0.06,
      size.width * 0.57,
      size.height * 0.77,
      size.width * 0.82,
      size.height * 0.68,
    );

    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 16; i++) {
      final x = (i * 47.0) % size.width;
      final y = (i * 29.0) % size.height;

      canvas.drawCircle(
        Offset(x, y),
        2,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _RoutePainter oldDelegate,
  ) {
    return oldDelegate.color != color;
  }
}