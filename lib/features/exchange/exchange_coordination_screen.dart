import 'package:flutter/material.dart';

class ExchangeCoordinationScreen extends StatefulWidget {
  const ExchangeCoordinationScreen({super.key});

  @override
  State<ExchangeCoordinationScreen> createState() =>
      _ExchangeCoordinationScreenState();
}

class _ExchangeCoordinationScreenState
    extends State<ExchangeCoordinationScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Overview',
    'Schedule',
    'Participants',
    'Readiness',
  ];

  final List<Map<String, dynamic>> _coordinationItems = [
    {
      'title': 'Laptop Donation',
      'resource': '5 Refurbished Laptops',
      'provider': 'VIT Resource Hub',
      'receiver': 'Community Learning Center',
      'location': 'Katpadi Community Hall',
      'distance': '3.8 km',
      'time': 'Today, 4:30 PM',
      'status': 'Ready',
      'score': 96,
      'response': 'Confirmed',
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
      'status': 'Waiting',
      'score': 89,
      'response': 'Awaiting receiver',
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
      'status': 'Scheduled',
      'score': 84,
      'response': 'Confirmed',
      'icon': Icons.table_restaurant_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exchange Coordination',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: _showNotifications,
            icon: const Badge(
              label: Text('4'),
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
        onPressed: _startCoordination,
        icon: const Icon(Icons.handshake_rounded),
        label: const Text('Coordinate'),
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
                      _buildSmartOverview(context),
                      const SizedBox(height: 20),
                      _buildActiveCoordination(context),
                      const SizedBox(height: 20),
                      _buildSmartSuggestions(context),
                      const SizedBox(height: 20),
                      _buildCoordinationTimeline(context),
                      const SizedBox(height: 20),
                      _buildPerformance(context),
                    ],
                    if (_selectedTab == 1) ...[
                      _buildSchedulePlanner(context),
                      const SizedBox(height: 20),
                      _buildAvailability(context),
                      const SizedBox(height: 20),
                      _buildSuggestedSlots(context),
                    ],
                    if (_selectedTab == 2) ...[
                      _buildParticipants(context),
                      const SizedBox(height: 20),
                      _buildCommunicationCenter(context),
                      const SizedBox(height: 20),
                      _buildResponseStatus(context),
                    ],
                    if (_selectedTab == 3) ...[
                      _buildReadinessChecklist(context),
                      const SizedBox(height: 20),
                      _buildReadinessScore(context),
                      const SizedBox(height: 20),
                      _buildCoordinationAlerts(context),
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
            colorScheme.secondary,
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
                  Icons.handshake_rounded,
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
                      'SMART',
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
            'Smart Exchange Coordination',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Coordinate people, schedules and handover details before every exchange.',
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
                '96%',
                'Match',
              ),
              _heroMetric(
                context,
                '91%',
                'Ready',
              ),
              _heroMetric(
                context,
                '87%',
                'Confirm',
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
        'Coordinating',
        '3',
        Icons.handshake_rounded,
      ),
      (
        'Confirmed',
        '7',
        Icons.verified_rounded,
      ),
      (
        'Waiting',
        '2',
        Icons.hourglass_top_rounded,
      ),
      (
        'Conflicts',
        '1',
        Icons.warning_amber_rounded,
      ),
    ];

    return SizedBox(
      height: 106,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final stat = stats[index];

          return Container(
            width: 126,
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
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSmartOverview(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Coordination Intelligence',
      icon: Icons.auto_awesome_rounded,
      trailing: TextButton(
        onPressed: _showCoordinationScore,
        child: const Text('Details'),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 82,
                height: 82,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 82,
                      height: 82,
                      child: CircularProgressIndicator(
                        value: 0.91,
                        strokeWidth: 8,
                        backgroundColor:
                            colorScheme.surfaceContainerHighest,
                      ),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '91',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'score',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
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
                      'Excellent coordination readiness',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Participants, location and schedule are highly compatible.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _miniMetric(
            context,
            Icons.people_alt_rounded,
            'Participants',
            '2 / 2 confirmed',
          ),
          const SizedBox(height: 11),
          _miniMetric(
            context,
            Icons.location_on_rounded,
            'Location',
            'Compatible • 3.8 km',
          ),
          const SizedBox(height: 11),
          _miniMetric(
            context,
            Icons.schedule_rounded,
            'Schedule',
            'No conflicts detected',
          ),
        ],
      ),
    );
  }

  Widget _miniMetric(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveCoordination(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Active Coordination',
      icon: Icons.sync_rounded,
      trailing: TextButton(
        onPressed: () {
          setState(() {
            _selectedTab = 2;
          });
        },
        child: const Text('Participants'),
      ),
      child: Column(
        children: [
          for (final item in _coordinationItems)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _coordinationCard(
                context,
                item,
              ),
            ),
        ],
      ),
    );
  }

  Widget _coordinationCard(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    final score = item['score'] as int;
    final status = item['status'] as String;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showCoordinationDetails(item),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.38,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _resourceIcon(
                  context,
                  item['icon'] as IconData,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['resource'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusChip(
                  context,
                  status,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  '$score% coordination score',
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  item['response'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: score / 100,
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartSuggestions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final suggestions = [
      (
        Icons.schedule_rounded,
        'Best time',
        '4:30 PM today has the highest availability overlap.',
      ),
      (
        Icons.location_on_rounded,
        'Best location',
        'Katpadi Community Hall minimizes travel for both sides.',
      ),
      (
        Icons.notifications_active_rounded,
        'Reminder',
        'Send confirmation reminder 2 hours before handover.',
      ),
    ];

    return _sectionCard(
      context,
      title: 'Smart Suggestions',
      icon: Icons.lightbulb_rounded,
      child: Column(
        children: [
          for (final suggestion in suggestions)
            Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(
                    alpha: 0.38,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      suggestion.$1,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            suggestion.$2,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            suggestion.$3,
                            style: const TextStyle(
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
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

  Widget _buildCoordinationTimeline(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Coordination Timeline',
      icon: Icons.timeline_rounded,
      child: Column(
        children: [
          _timelineItem(
            context,
            'Match created',
            'Today, 9:20 AM',
            'Smart Match identified compatible participants.',
            true,
          ),
          _timelineItem(
            context,
            'Provider confirmed',
            'Today, 9:35 AM',
            'VIT Resource Hub accepted the exchange.',
            true,
          ),
          _timelineItem(
            context,
            'Receiver confirmed',
            'Today, 10:05 AM',
            'Community Learning Center confirmed.',
            true,
          ),
          _timelineItem(
            context,
            'Handover scheduled',
            'Today, 10:20 AM',
            '4:30 PM slot selected by both parties.',
            true,
          ),
          _timelineItem(
            context,
            'Exchange pending',
            'Upcoming',
            'Waiting for final handover completion.',
            false,
          ),
        ],
      ),
    );
  }

  Widget _timelineItem(
    BuildContext context,
    String title,
    String time,
    String description,
    bool completed,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: completed
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: completed
                        ? colorScheme.primary
                        : colorScheme.outline,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 2,
                height: 45,
                color: colorScheme.outlineVariant,
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
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformance(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Coordination Performance',
      icon: Icons.analytics_rounded,
      child: Column(
        children: [
          _performanceRow(
            context,
            'Confirmation rate',
            0.87,
            '87%',
          ),
          const SizedBox(height: 16),
          _performanceRow(
            context,
            'Participant response',
            0.91,
            '91%',
          ),
          const SizedBox(height: 16),
          _performanceRow(
            context,
            'Schedule compatibility',
            0.94,
            '94%',
          ),
          const SizedBox(height: 16),
          _performanceRow(
            context,
            'Successful coordination',
            0.96,
            '96%',
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
                '+6% improvement this month',
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

  Widget _buildSchedulePlanner(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Smart Schedule Planner',
      icon: Icons.calendar_month_rounded,
      trailing: IconButton(
        onPressed: _selectDate,
        icon: const Icon(Icons.calendar_today_rounded),
      ),
      child: Column(
        children: [
          _scheduleCard(
            context,
            'Today',
            '4:30 PM',
            'Laptop Donation',
            'Best overlap • 96%',
            true,
          ),
          const SizedBox(height: 12),
          _scheduleCard(
            context,
            'Tomorrow',
            '10:00 AM',
            'Study Material Exchange',
            'Good overlap • 89%',
            false,
          ),
          const SizedBox(height: 12),
          _scheduleCard(
            context,
            'Sep 8',
            '2:00 PM',
            'Furniture Redistribution',
            'Good overlap • 84%',
            false,
          ),
        ],
      ),
    );
  }

  Widget _scheduleCard(
    BuildContext context,
    String date,
    String time,
    String title,
    String subtitle,
    bool recommended,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: recommended
            ? colorScheme.primaryContainer.withValues(alpha: 0.42)
            : colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.35,
              ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: recommended
              ? colorScheme.primary.withValues(alpha: 0.35)
              : colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
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
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (recommended)
            Icon(
              Icons.auto_awesome_rounded,
              color: colorScheme.primary,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildAvailability(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Participant Availability',
      icon: Icons.people_alt_rounded,
      child: Column(
        children: [
          _availabilityRow(
            context,
            'VIT Resource Hub',
            'Provider',
            'Available today',
            0.95,
          ),
          const SizedBox(height: 14),
          _availabilityRow(
            context,
            'Community Learning Center',
            'Receiver',
            'Available today',
            0.91,
          ),
          const SizedBox(height: 14),
          Divider(
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Availability overlap detected',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '92%',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _availabilityRow(
    BuildContext context,
    String name,
    String role,
    String status,
    double score,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            role == 'Provider'
                ? Icons.inventory_2_rounded
                : Icons.person_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$role • $status',
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${(score * 100).round()}%',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedSlots(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Recommended Time Slots',
      icon: Icons.auto_awesome_rounded,
      child: Wrap(
        spacing: 9,
        runSpacing: 9,
        children: [
          '4:00 - 5:00 PM',
          '5:00 - 6:00 PM',
          '10:00 - 11:00 AM',
          '2:00 - 3:00 PM',
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
    );
  }

  Widget _buildParticipants(BuildContext context) {
    return _sectionCard(
      context,
      title: 'Exchange Participants',
      icon: Icons.people_alt_rounded,
      trailing: TextButton(
        onPressed: _inviteParticipant,
        child: const Text('Invite'),
      ),
      child: Column(
        children: [
          _participantCard(
            context,
            'VIT Resource Hub',
            'Resource Provider',
            'Verified organization',
            true,
          ),
          const SizedBox(height: 12),
          _participantCard(
            context,
            'Community Learning Center',
            'Resource Receiver',
            'Verified community',
            true,
          ),
          const SizedBox(height: 12),
          _participantCard(
            context,
            'ResourceX Coordination',
            'Exchange Coordinator',
            'System coordination',
            true,
          ),
        ],
      ),
    );
  }

  Widget _participantCard(
    BuildContext context,
    String name,
    String role,
    String subtitle,
    bool confirmed,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(
              role.contains('Provider')
                  ? Icons.inventory_2_rounded
                  : role.contains('Receiver')
                      ? Icons.school_rounded
                      : Icons.hub_rounded,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (confirmed)
            const Icon(
              Icons.verified_rounded,
              size: 21,
            ),
        ],
      ),
    );
  }

  Widget _buildCommunicationCenter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Communication Center',
      icon: Icons.chat_bubble_rounded,
      child: Column(
        children: [
          _communicationTile(
            context,
            Icons.mark_chat_unread_rounded,
            'Confirmation reminder',
            'Receiver has not confirmed the updated schedule.',
            'Send',
          ),
          const SizedBox(height: 10),
          _communicationTile(
            context,
            Icons.location_on_rounded,
            'Location confirmation',
            'Handover point is confirmed by both parties.',
            'View',
          ),
          const SizedBox(height: 10),
          _communicationTile(
            context,
            Icons.notifications_active_rounded,
            'Exchange reminder',
            'Automatic reminder is scheduled for 2:30 PM.',
            'Edit',
          ),
          const SizedBox(height: 14),
          Divider(
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _openConversation,
              icon: const Icon(Icons.forum_rounded),
              label: const Text('Open Exchange Conversation'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _communicationTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String action,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
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
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.35,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showMessage('$action action opened');
            },
            child: Text(action),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseStatus(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Response Status',
      icon: Icons.mark_email_read_rounded,
      child: Column(
        children: [
          _responseRow(
            context,
            'Provider',
            'Confirmed',
            1,
          ),
          const SizedBox(height: 14),
          _responseRow(
            context,
            'Receiver',
            'Confirmed',
            1,
          ),
          const SizedBox(height: 14),
          _responseRow(
            context,
            'Coordinator',
            'Ready',
            1,
          ),
          const SizedBox(height: 14),
          Divider(
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 8),
          const Text(
            'All required participants are ready for the planned exchange.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _responseRow(
    BuildContext context,
    String name,
    String status,
    double value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          status,
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildReadinessChecklist(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      ('Resource prepared', true),
      ('Provider confirmed', true),
      ('Receiver confirmed', true),
      ('Location confirmed', true),
      ('Schedule confirmed', true),
      ('Handover instructions acknowledged', false),
    ];

    final completed = items.where((item) => item.$2).length;

    return _sectionCard(
      context,
      title: 'Exchange Readiness Checklist',
      icon: Icons.checklist_rounded,
      trailing: Text(
        '$completed / ${items.length}',
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
                  fontSize: 12,
                  fontWeight: item.$2
                      ? FontWeight.w500
                      : FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReadinessScore(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Readiness Score',
      icon: Icons.speed_rounded,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: CircularProgressIndicator(
                        value: 0.91,
                        strokeWidth: 9,
                        backgroundColor:
                            colorScheme.surfaceContainerHighest,
                      ),
                    ),
                    const Text(
                      '91%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Text(
                  'The exchange is almost ready. Complete the final handover acknowledgement before the scheduled time.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _readinessRow(
            context,
            'People',
            1.0,
          ),
          const SizedBox(height: 11),
          _readinessRow(
            context,
            'Schedule',
            1.0,
          ),
          const SizedBox(height: 11),
          _readinessRow(
            context,
            'Location',
            1.0,
          ),
          const SizedBox(height: 11),
          _readinessRow(
            context,
            'Handover',
            0.55,
          ),
        ],
      ),
    );
  }

  Widget _readinessRow(
    BuildContext context,
    String title,
    double value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${(value * 100).round()}%',
          style: TextStyle(
            fontSize: 10,
            color: colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildCoordinationAlerts(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Coordination Alerts',
      icon: Icons.notifications_active_rounded,
      child: Column(
        children: [
          _alertCard(
            context,
            Icons.check_circle_rounded,
            'Everything looks good',
            'No major coordination conflicts were detected.',
            false,
          ),
          const SizedBox(height: 11),
          _alertCard(
            context,
            Icons.access_time_rounded,
            'Final reminder pending',
            'Handover instructions should be acknowledged before 2:30 PM.',
            false,
          ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withValues(
                alpha: 0.4,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.error,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'One exchange is waiting for participant confirmation.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _sendReminder,
                  child: const Text('Remind'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool error,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: error
            ? colorScheme.errorContainer.withValues(alpha: 0.4)
            : colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: error
                ? colorScheme.error
                : colorScheme.primary,
          ),
          const SizedBox(width: 10),
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
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.35,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
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
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
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

    final isWaiting = status.toLowerCase().contains('waiting');

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isWaiting
            ? colorScheme.tertiaryContainer
            : colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: isWaiting
              ? colorScheme.onTertiaryContainer
              : colorScheme.onSecondaryContainer,
        ),
      ),
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
              fontSize: 11,
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

  Future<void> _refreshData() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    _showMessage('Coordination data refreshed');
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

  void _showCoordinationDetails(
    Map<String, dynamic> item,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _resourceIcon(
                      context,
                      item['icon'] as IconData,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['resource'] as String,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _detailRow(
                  context,
                  Icons.people_alt_rounded,
                  'Provider',
                  item['provider'] as String,
                ),
                _detailRow(
                  context,
                  Icons.person_rounded,
                  'Receiver',
                  item['receiver'] as String,
                ),
                _detailRow(
                  context,
                  Icons.location_on_rounded,
                  'Location',
                  item['location'] as String,
                ),
                _detailRow(
                  context,
                  Icons.route_rounded,
                  'Distance',
                  item['distance'] as String,
                ),
                _detailRow(
                  context,
                  Icons.schedule_rounded,
                  'Schedule',
                  item['time'] as String,
                ),
                _detailRow(
                  context,
                  Icons.auto_awesome_rounded,
                  'Score',
                  '${item['score']}% compatibility',
                ),
                const SizedBox(height: 12),
                Text(
                  'Coordination Readiness',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 9),
                LinearProgressIndicator(
                  value: (item['score'] as int) / 100,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _sendReminder();
                        },
                        child: const Text('Send Reminder'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _openConversation();
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
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 11),
          SizedBox(
            width: 78,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCoordinationScore() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Coordination Score'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ResourceX calculates coordination readiness using multiple signals.',
              ),
              SizedBox(height: 16),
              Text('• Participant availability'),
              SizedBox(height: 7),
              Text('• Schedule compatibility'),
              SizedBox(height: 7),
              Text('• Location compatibility'),
              SizedBox(height: 7),
              Text('• Response reliability'),
              SizedBox(height: 7),
              Text('• Exchange readiness'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
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
          'Coordination date selected: '
          '${date.day}/${date.month}/${date.year}',
        );
      }
    });
  }

  void _startCoordination() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Start Exchange Coordination',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                _bottomAction(
                  context,
                  Icons.inventory_2_rounded,
                  'Select Exchange',
                  'Choose a matched exchange to coordinate',
                  () {
                    Navigator.pop(context);
                    _showMessage('Exchange selector opened');
                  },
                ),
                _bottomAction(
                  context,
                  Icons.people_alt_rounded,
                  'Invite Participants',
                  'Add provider, receiver or coordinator',
                  () {
                    Navigator.pop(context);
                    _inviteParticipant();
                  },
                ),
                _bottomAction(
                  context,
                  Icons.calendar_month_rounded,
                  'Plan Schedule',
                  'Find the best available time',
                  () {
                    Navigator.pop(context);
                    _selectDate();
                  },
                ),
                _bottomAction(
                  context,
                  Icons.location_on_rounded,
                  'Choose Location',
                  'Find a suitable handover point',
                  () {
                    Navigator.pop(context);
                    _showMessage('Location planner opened');
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

  void _openConversation() {
    _showMessage('Exchange conversation opened');
  }

  void _sendReminder() {
    _showMessage('Coordination reminder sent');
  }

  void _inviteParticipant() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.person_add_rounded),
                title: const Text('Invite provider'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Provider invitation sent');
                },
              ),
              ListTile(
                leading: const Icon(Icons.school_rounded),
                title: const Text('Invite receiver'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Receiver invitation sent');
                },
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings_rounded),
                title: const Text('Invite coordinator'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Coordinator invitation sent');
                },
              ),
            ],
          ),
        );
      },
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
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              25,
            ),
            children: const [
              Text(
                'Coordination Notifications',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  Icons.mark_chat_unread_rounded,
                ),
                title: Text('Confirmation pending'),
                subtitle: Text(
                  'Study Material Exchange',
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.schedule_rounded,
                ),
                title: Text('Exchange approaching'),
                subtitle: Text(
                  'Laptop Donation starts today at 4:30 PM',
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.auto_awesome_rounded,
                ),
                title: Text('Smart suggestion available'),
                subtitle: Text(
                  'A better schedule overlap was detected.',
                ),
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
                title: const Text('Coordination History'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Coordination history opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics_rounded),
                title: const Text('Coordination Report'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Coordination report opened');
                },
              ),
              ListTile(
                leading: const Icon(Icons.tune_rounded),
                title: const Text('Matching Preferences'),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Matching preferences opened',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}