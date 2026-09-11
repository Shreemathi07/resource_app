import 'package:flutter/material.dart';

class ImpactScreen extends StatefulWidget {
  const ImpactScreen({super.key});

  @override
  State<ImpactScreen> createState() => _ImpactScreenState();
}

class _ImpactScreenState extends State<ImpactScreen> {
  String _selectedPeriod = 'This Year';

  final List<_ImpactActivity> _activities = const [
    _ImpactActivity(
      title: '120 meal packs redirected',
      subtitle: 'Community Food Hub',
      date: 'Today',
      value: '+120',
      icon: Icons.restaurant_rounded,
    ),
    _ImpactActivity(
      title: '8 laptops matched',
      subtitle: 'TechShare Learning Program',
      date: '3 days ago',
      value: '+8',
      icon: Icons.laptop_mac_rounded,
    ),
    _ImpactActivity(
      title: '35 kg materials reused',
      subtitle: 'GreenCycle Foundation',
      date: '1 week ago',
      value: '+35 kg',
      icon: Icons.recycling_rounded,
    ),
    _ImpactActivity(
      title: '25 books contributed',
      subtitle: 'Student Support Centre',
      date: '2 weeks ago',
      value: '+25',
      icon: Icons.menu_book_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 110),
          children: [
            _buildHeader(),
            const SizedBox(height: 18),
            _buildHeroCard(),
            const SizedBox(height: 20),
            _buildPeriodSelector(),
            const SizedBox(height: 20),
            _buildOverview(),
            const SizedBox(height: 22),
            _buildTrendCard(),
            const SizedBox(height: 22),
            _buildCategoryImpact(),
            const SizedBox(height: 22),
            _buildSuccessCard(),
            const SizedBox(height: 22),
            _buildMilestone(),
            const SizedBox(height: 22),
            _buildActivitySection(),
            const SizedBox(height: 22),
            _buildBadges(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF3155D8),
                Color(0xFF6A5AE0),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.insights_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(width: 13),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Impact Analytics',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'See the difference your actions create',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _showReportDialog,
          icon: const Icon(Icons.download_rounded),
          tooltip: 'Impact report',
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF263EAA),
            Color(0xFF6A5AE0),
          ],
        ),
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3155D8).withValues(alpha: 0.25),
            blurRadius: 22,
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.public_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Text(
                  'Your ResourceX Impact',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '+24%',
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
          const SizedBox(height: 25),
          const Text(
            '1,284',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'total impact points',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.78,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.16),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '78% of annual goal',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 11,
                ),
              ),
              const Text(
                '1,650 goal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    const periods = [
      'This Month',
      'This Year',
      'All Time',
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: periods.map((period) {
          final selected = _selectedPeriod == period;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF3155D8)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Impact Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: Icons.inventory_2_rounded,
                title: 'Resources',
                value: '186',
                change: '+18%',
                description: 'shared or recovered',
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: _statCard(
                icon: Icons.handshake_rounded,
                title: 'Exchanges',
                value: '74',
                change: '+12%',
                description: 'successfully completed',
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: Icons.people_alt_rounded,
                title: 'People Helped',
                value: '328',
                change: '+26%',
                description: 'direct beneficiaries',
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: _statCard(
                icon: Icons.delete_sweep_rounded,
                title: 'Waste Diverted',
                value: '486 kg',
                change: '+31%',
                description: 'from disposal',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required String change,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
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
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF3155D8).withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF3155D8),
                  size: 18,
                ),
              ),
              const Spacer(),
              Text(
                change,
                style: const TextStyle(
                  color: Color(0xFF2F9D68),
                  fontWeight: FontWeight.w800,
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 9.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendCard() {
    final values = [35.0, 46.0, 42.0, 58.0, 52.0, 71.0, 84.0];

    return _sectionCard(
      title: 'Impact Growth',
      subtitle: 'Your contribution over the last 7 months',
      trailing: const Icon(
        Icons.more_horiz_rounded,
        color: Colors.grey,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                values.length,
                (index) {
                  final value = values[index];
                  final selected = index == values.length - 1;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${value.toInt()}',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: selected
                                  ? const Color(0xFF3155D8)
                                  : Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: value * 1.35,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: selected
                                    ? const [
                                        Color(0xFF3155D8),
                                        Color(0xFF6A5AE0),
                                      ]
                                    : [
                                        const Color(0xFFB7C4F3),
                                        const Color(0xFFD9DFF7),
                                      ],
                              ),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            [
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                            ][index],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryImpact() {
    return _sectionCard(
      title: 'Impact by Category',
      subtitle: 'Where your contributions make the most difference',
      child: Column(
        children: [
          const SizedBox(height: 7),
          _categoryRow(
            icon: Icons.restaurant_rounded,
            title: 'Food',
            amount: '42%',
            value: 0.42,
            count: '548 points',
          ),
          _categoryRow(
            icon: Icons.school_rounded,
            title: 'Education',
            amount: '27%',
            value: 0.27,
            count: '347 points',
          ),
          _categoryRow(
            icon: Icons.devices_rounded,
            title: 'Technology',
            amount: '18%',
            value: 0.18,
            count: '231 points',
          ),
          _categoryRow(
            icon: Icons.recycling_rounded,
            title: 'Materials',
            amount: '13%',
            value: 0.13,
            count: '158 points',
          ),
        ],
      ),
    );
  }

  Widget _categoryRow({
    required IconData icon,
    required String title,
    required String amount,
    required double value,
    required String count,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: const Color(0xFF3155D8).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF3155D8),
              size: 19,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE9EDF7),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF3155D8),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.track_changes_rounded,
                color: Color(0xFF3155D8),
              ),
              SizedBox(width: 9),
              Text(
                'Exchange Performance',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 94,
                      height: 94,
                      child: CircularProgressIndicator(
                        value: 0.92,
                        strokeWidth: 9,
                        backgroundColor: const Color(0xFFE8ECF7),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF3155D8),
                        ),
                      ),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '92%',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'success',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Column(
                  children: [
                    _performanceRow(
                      'Completed',
                      '74',
                      Icons.check_circle_rounded,
                    ),
                    _performanceRow(
                      'In progress',
                      '6',
                      Icons.timelapse_rounded,
                    ),
                    _performanceRow(
                      'Cancelled',
                      '2',
                      Icons.cancel_rounded,
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

  Widget _performanceRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF3155D8),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestone() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF2FF),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFDCE2FF),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3155D8).withValues(alpha: 0.12),
                  blurRadius: 12,
                ),
              ],
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: Color(0xFFE0A72D),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next milestone',
                  style: TextStyle(
                    color: Color(0xFF3155D8),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Community Champion',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '366 more impact points to unlock',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF3155D8),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return _sectionCard(
      title: 'Recent Impact',
      subtitle: 'Your latest measurable contributions',
      trailing: TextButton(
        onPressed: () {
          _showMessage('Full impact history opened.');
        },
        child: const Text('View all'),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          ..._activities.map(_activityTile),
        ],
      ),
    );
  }

  Widget _activityTile(_ImpactActivity activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: const Color(0xFF3155D8).withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              activity.icon,
              color: const Color(0xFF3155D8),
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 11.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity.subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                activity.value,
                style: const TextStyle(
                  color: Color(0xFF2F9D68),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                activity.date,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadges() {
    return _sectionCard(
      title: 'Impact Badges',
      subtitle: 'Milestones earned through your activity',
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _badge(
                  Icons.eco_rounded,
                  'Eco Starter',
                  '100 kg diverted',
                  true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _badge(
                  Icons.handshake_rounded,
                  'Connector',
                  '50 exchanges',
                  true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _badge(
                  Icons.groups_rounded,
                  'Community',
                  '250 people helped',
                  true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _badge(
                  Icons.workspace_premium_rounded,
                  'Champion',
                  '1,650 points',
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(
    IconData icon,
    String title,
    String subtitle,
    bool unlocked,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: unlocked
            ? const Color(0xFFF8F9FE)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked
              ? const Color(0xFFE0E5F8)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked
                  ? const Color(0xFF3155D8).withValues(alpha: 0.10)
                  : Colors.grey.shade200,
            ),
            child: Icon(
              icon,
              color: unlocked
                  ? const Color(0xFF3155D8)
                  : Colors.grey.shade400,
              size: 21,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    color: unlocked
                        ? Colors.black87
                        : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8.5,
                    color: Colors.grey.shade500,
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
    required String subtitle,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
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
              ?trailing,
            ],
          ),
          child,
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Impact Report'),
          content: const Text(
            'Your detailed ResourceX impact report is ready. '
            'In the connected version, this report can include '
            'resource history, exchange records and measurable impact.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Impact report generation started.');
              },
              child: const Text('Generate'),
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
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _ImpactActivity {
  final String title;
  final String subtitle;
  final String date;
  final String value;
  final IconData icon;

  const _ImpactActivity({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.value,
    required this.icon,
  });
}