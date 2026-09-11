import 'package:flutter/material.dart';

class ExchangeCenterScreen extends StatefulWidget {
  const ExchangeCenterScreen({super.key});

  @override
  State<ExchangeCenterScreen> createState() =>
      _ExchangeCenterScreenState();
}

class _ExchangeCenterScreenState
    extends State<ExchangeCenterScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Active',
    'Scheduled',
    'Completed',
    'Issues',
  ];

  final List<_Exchange> _exchanges = [
    _Exchange(
      title: 'Laptop Equipment Exchange',
      resource: 'Dell Latitude Laptops',
      partner: 'VIT Community Hub',
      status: 'Pickup scheduled',
      date: 'Today, 4:30 PM',
      location: 'VIT Campus • Main Block',
      icon: Icons.laptop_mac_rounded,
      progress: 0.75,
    ),
    _Exchange(
      title: 'Stationery Resource Exchange',
      resource: 'Notebooks & Study Kits',
      partner: 'Student Support Network',
      status: 'Awaiting confirmation',
      date: 'Tomorrow, 11:00 AM',
      location: 'Central Library',
      icon: Icons.menu_book_rounded,
      progress: 0.45,
    ),
    _Exchange(
      title: 'Community Food Donation',
      resource: 'Packaged Food Supplies',
      partner: 'Campus Care Group',
      status: 'Exchange confirmed',
      date: '28 Aug, 2:00 PM',
      location: 'Community Center',
      icon: Icons.inventory_2_outlined,
      progress: 0.90,
    ),
  ];

  final List<_Exchange> _completed = [
    _Exchange(
      title: 'Computer Accessories',
      resource: 'Keyboard & Mouse Sets',
      partner: 'Digital Learning Club',
      status: 'Completed',
      date: '18 Aug, 3:00 PM',
      location: 'Technology Lab',
      icon: Icons.devices_other_rounded,
      progress: 1.0,
    ),
    _Exchange(
      title: 'Furniture Reuse',
      resource: 'Study Tables',
      partner: 'Green Campus Team',
      status: 'Completed',
      date: '11 Aug, 10:30 AM',
      location: 'Block C',
      icon: Icons.chair_outlined,
      progress: 1.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Exchange Center',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showExchangeInfo,
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 20),
              _buildStats(),
              const SizedBox(height: 22),
              _buildTabs(),
              const SizedBox(height: 18),
              _buildSelectedContent(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNewExchange,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'New Exchange',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF064E3B),
            Color(0xFF059669),
            Color(0xFF34D399),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.20),
            blurRadius: 24,
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
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.handshake_rounded,
                  color: Colors.white,
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
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.sync_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.white,
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
          const Text(
            'Resource Exchange Center',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Coordinate, track and complete your resource exchanges in one place.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _heroStat('3', 'Active'),
              const SizedBox(width: 25),
              _heroStat('26', 'Completed'),
              const SizedBox(width: 25),
              _heroStat('94%', 'Success'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    final stats = [
      (
        Icons.schedule_rounded,
        '2',
        'Scheduled',
      ),
      (
        Icons.location_on_outlined,
        '1',
        'Today',
      ),
      (
        Icons.check_circle_outline_rounded,
        '26',
        'Completed',
      ),
      (
        Icons.star_outline_rounded,
        '4.9',
        'Rating',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];

        return Container(
          padding: const EdgeInsets.all(15),
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
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  stat.$1,
                  color: Colors.green.shade700,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat.$2,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stat.$3,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.green.shade700
                    : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: selected
                      ? Colors.green.shade700
                      : Colors.grey.shade200,
                ),
              ),
              child: Center(
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedTab) {
      case 1:
        return _buildScheduled();
      case 2:
        return _buildCompleted();
      case 3:
        return _buildIssues();
      default:
        return _buildActive();
    }
  }

  Widget _buildActive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Active exchanges',
          'Track exchanges that are currently in progress.',
        ),
        const SizedBox(height: 14),
        ..._exchanges.map(_buildExchangeCard),
      ],
    );
  }

  Widget _buildScheduled() {
    final scheduled = _exchanges.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Upcoming schedule',
          'Your next confirmed resource exchanges.',
        ),
        const SizedBox(height: 14),
        ...scheduled.map(_buildExchangeCard),
        const SizedBox(height: 10),
        _buildCalendarCard(),
      ],
    );
  }

  Widget _buildCompleted() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Exchange history',
          'Your successfully completed resource exchanges.',
        ),
        const SizedBox(height: 14),
        ..._completed.map(_buildExchangeCard),
        const SizedBox(height: 8),
        _buildHistorySummary(),
      ],
    );
  }

  Widget _buildIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Issues & support',
          'Manage problems related to your exchanges.',
        ),
        const SizedBox(height: 14),
        _buildIssueCard(
          Icons.location_off_outlined,
          'Pickup location changed',
          'One scheduled exchange needs a location update.',
          'Review',
          Colors.orange,
        ),
        _buildIssueCard(
          Icons.schedule_outlined,
          'Reschedule requested',
          'A partner has requested a different exchange time.',
          'Respond',
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildSupportCard(),
      ],
    );
  }

  Widget _buildExchangeCard(_Exchange exchange) {
    return GestureDetector(
      onTap: () => _showExchangeDetails(exchange),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    exchange.icon,
                    color: Colors.green.shade700,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        exchange.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exchange.resource,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: _statusBackground(exchange.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                exchange.status,
                style: TextStyle(
                  color: _statusColor(exchange.status),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 14),
            _detailRow(
              Icons.person_outline_rounded,
              exchange.partner,
            ),
            const SizedBox(height: 8),
            _detailRow(
              Icons.calendar_today_outlined,
              exchange.date,
            ),
            const SizedBox(height: 8),
            _detailRow(
              Icons.location_on_outlined,
              exchange.location,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: exchange.progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(exchange.progress * 100).round()}%',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return _card(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View exchange calendar',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Plan your upcoming resource handovers.',
                  style: TextStyle(fontSize: 10.5),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }

  Widget _buildHistorySummary() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exchange performance',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _performanceItem(
                  'On time',
                  '24',
                  Icons.schedule_rounded,
                ),
              ),
              Expanded(
                child: _performanceItem(
                  'Successful',
                  '26',
                  Icons.check_circle_outline_rounded,
                ),
              ),
              Expanded(
                child: _performanceItem(
                  'Rating',
                  '4.9',
                  Icons.star_outline_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _performanceItem(
    String title,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 21,
          color: Colors.green.shade700,
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildIssueCard(
    IconData icon,
    String title,
    String subtitle,
    String action,
    MaterialColor color,
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
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color.shade700,
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
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showMessage('$action action selected.');
            },
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.support_agent_rounded,
            color: Colors.blue.shade700,
            size: 28,
          ),
          const SizedBox(height: 10),
          const Text(
            'Need help with an exchange?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Our support workflow can help resolve exchange-related issues.',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 11,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _showMessage(
              'Support request created for this demo.',
            ),
            icon: const Icon(Icons.help_outline_rounded),
            label: const Text('Contact support'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
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
      child: child,
    );
  }

  Color _statusColor(String status) {
    if (status == 'Completed') {
      return Colors.green.shade700;
    }

    if (status == 'Awaiting confirmation') {
      return Colors.orange.shade700;
    }

    return Colors.blue.shade700;
  }

  Color _statusBackground(String status) {
    if (status == 'Completed') {
      return Colors.green.withValues(alpha: 0.10);
    }

    if (status == 'Awaiting confirmation') {
      return Colors.orange.withValues(alpha: 0.10);
    }

    return Colors.blue.withValues(alpha: 0.10);
  }

  void _showExchangeDetails(_Exchange exchange) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        exchange.icon,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Text(
                        exchange.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _timelineStep(
                  Icons.check_circle_rounded,
                  'Match accepted',
                  'Resource exchange was created.',
                  true,
                ),
                _timelineStep(
                  Icons.schedule_rounded,
                  'Exchange scheduled',
                  exchange.date,
                  true,
                ),
                _timelineStep(
                  Icons.location_on_outlined,
                  'Pickup / handover',
                  exchange.location,
                  exchange.progress >= 0.75,
                ),
                _timelineStep(
                  Icons.verified_outlined,
                  'Exchange completed',
                  'Confirm after the handover.',
                  exchange.progress >= 1,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage(
                            'Exchange schedule options opened.',
                          );
                        },
                        icon: const Icon(Icons.edit_calendar_outlined),
                        label: const Text('Reschedule'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage(
                            'Exchange marked for confirmation.',
                          );
                        },
                        icon: const Icon(
                          Icons.check_circle_outline_rounded,
                        ),
                        label: const Text('Confirm'),
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

  Widget _timelineStep(
    IconData icon,
    String title,
    String subtitle,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: completed
                ? Colors.green.shade700
                : Colors.grey.shade400,
            size: 22,
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
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNewExchange() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create exchange',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose how you want to start a resource exchange.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 18),
                _actionTile(
                  Icons.swap_horiz_rounded,
                  'From a smart match',
                  'Start an exchange with a matched member.',
                ),
                _actionTile(
                  Icons.inventory_2_outlined,
                  'From my resources',
                  'Select one of your available resources.',
                ),
                _actionTile(
                  Icons.add_task_rounded,
                  'From a requirement',
                  'Respond to an active community requirement.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 3),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: Colors.green.shade700,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        Navigator.pop(context);
        _showMessage('$title selected.');
      },
    );
  }

  void _showExchangeInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.handshake_outlined),
              SizedBox(width: 10),
              Text('Exchange Center'),
            ],
          ),
          content: const Text(
            'The Exchange Center helps members coordinate resource handovers, track exchange progress, manage schedules and maintain an exchange history.',
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
}

class _Exchange {
  final String title;
  final String resource;
  final String partner;
  final String status;
  final String date;
  final String location;
  final IconData icon;
  final double progress;

  const _Exchange({
    required this.title,
    required this.resource,
    required this.partner,
    required this.status,
    required this.date,
    required this.location,
    required this.icon,
    required this.progress,
  });
}