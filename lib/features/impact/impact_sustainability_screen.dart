import 'package:flutter/material.dart';

class ImpactSustainabilityScreen extends StatefulWidget {
  const ImpactSustainabilityScreen({super.key});

  @override
  State<ImpactSustainabilityScreen> createState() =>
      _ImpactSustainabilityScreenState();
}

class _ImpactSustainabilityScreenState
    extends State<ImpactSustainabilityScreen> {
  int _selectedPeriod = 0;

  final List<String> _periods = [
    'This Month',
    '3 Months',
    'This Year',
    'All Time',
  ];

  final List<_ImpactCategory> _categories = [
    _ImpactCategory(
      title: 'Education',
      value: '42%',
      subtitle: 'of total impact',
      icon: Icons.school_outlined,
      progress: 0.84,
      metric: '126 resources reused',
    ),
    _ImpactCategory(
      title: 'Technology',
      value: '28%',
      subtitle: 'of total impact',
      icon: Icons.devices_other_outlined,
      progress: 0.67,
      metric: '84 devices reused',
    ),
    _ImpactCategory(
      title: 'Community',
      value: '18%',
      subtitle: 'of total impact',
      icon: Icons.groups_outlined,
      progress: 0.52,
      metric: '51 community exchanges',
    ),
    _ImpactCategory(
      title: 'Sustainability',
      value: '12%',
      subtitle: 'of total impact',
      icon: Icons.eco_outlined,
      progress: 0.39,
      metric: '36 reusable items',
    ),
  ];

  final List<_ImpactActivity> _recentImpact = [
    _ImpactActivity(
      title: 'Engineering equipment reused',
      subtitle: '12 lab kits transferred',
      impact: '+18 kg CO₂e',
      time: 'Today',
      icon: Icons.precision_manufacturing_outlined,
      type: 'Environmental',
    ),
    _ImpactActivity(
      title: 'Laptops redirected',
      subtitle: '8 devices provided for learning',
      impact: '+8 beneficiaries',
      time: 'Yesterday',
      icon: Icons.laptop_mac_outlined,
      type: 'Social',
    ),
    _ImpactActivity(
      title: 'Event materials reused',
      subtitle: '35 reusable items exchanged',
      impact: '+11 kg waste',
      time: 'Aug 23',
      icon: Icons.recycling_outlined,
      type: 'Environmental',
    ),
    _ImpactActivity(
      title: 'Community resource exchange',
      subtitle: 'Medical supplies delivered',
      impact: '+24 beneficiaries',
      time: 'Aug 21',
      icon: Icons.volunteer_activism_outlined,
      type: 'Social',
    ),
  ];

  void _showImpactDetails(
    String title,
    String description,
    IconData icon,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.green.shade700,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                _detailMetric(
                  Icons.public_outlined,
                  'Impact contribution',
                  'Verified community activity',
                ),
                _detailMetric(
                  Icons.analytics_outlined,
                  'Measurement',
                  'Calculated from completed exchanges',
                ),
                _detailMetric(
                  Icons.verified_outlined,
                  'Status',
                  'Impact recorded',
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage('Impact details recorded');
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailMetric(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green.shade700,
            size: 20,
          ),
          const SizedBox(width: 11),
          Expanded(
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
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
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
                    'Select impact period',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              ..._periods.asMap().entries.map(
                    (entry) {
                      final selected = entry.key == _selectedPeriod;

                      return ListTile(
                        leading: Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: selected
                              ? Colors.green.shade700
                              : Colors.grey,
                        ),
                        title: Text(entry.value),
                        onTap: () {
                          setState(() {
                            _selectedPeriod = entry.key;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Impact Report',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'Your ResourceX impact report will include resource reuse, environmental savings, social beneficiaries and exchange history.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Impact report generation started');
              },
              child: const Text('Generate'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Impact & Sustainability',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Measure the difference your resources create',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showReportDialog,
            tooltip: 'Impact report',
            icon: const Icon(Icons.description_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        children: [
          _buildImpactHero(),
          const SizedBox(height: 18),
          _buildPeriodSelector(),
          const SizedBox(height: 20),
          _buildEnvironmentalSection(),
          const SizedBox(height: 20),
          _buildSocialSection(),
          const SizedBox(height: 20),
          _buildImpactBreakdown(),
          const SizedBox(height: 20),
          _buildMonthlyTrend(),
          const SizedBox(height: 20),
          _buildMilestoneCard(),
          const SizedBox(height: 20),
          _buildRecentImpact(),
          const SizedBox(height: 20),
          _buildSustainabilityTips(),
        ],
      ),
    );
  }

  Widget _buildImpactHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade800,
            Colors.teal.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.17),
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
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Your Sustainability Impact',
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
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'VERIFIED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            '38.6 kg',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'estimated CO₂e avoided',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Expanded(
                child: _heroMetric(
                  '214',
                  'Resources reused',
                ),
              ),
              Expanded(
                child: _heroMetric(
                  '86',
                  'Beneficiaries',
                ),
              ),
              Expanded(
                child: _heroMetric(
                  '31',
                  'Exchanges',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(
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
            fontSize: 20,
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

  Widget _buildPeriodSelector() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Impact period',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: _showPeriodSheet,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                Text(
                  _periods[_selectedPeriod],
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
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
      ],
    );
  }

  Widget _buildEnvironmentalSection() {
    return _sectionCard(
      title: 'Environmental contribution',
      subtitle: 'Resources kept in circulation instead of being discarded.',
      icon: Icons.public_outlined,
      child: Column(
        children: [
          _impactMetricTile(
            Icons.cloud_outlined,
            'CO₂e avoided',
            '38.6 kg',
            '+18% this period',
            Colors.green,
          ),
          _impactMetricTile(
            Icons.delete_outline_rounded,
            'Waste diverted',
            '74.2 kg',
            '+24% this period',
            Colors.teal,
          ),
          _impactMetricTile(
            Icons.recycling_outlined,
            'Items reused',
            '214',
            '+31 this period',
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _impactMetricTile(
    IconData icon,
    String title,
    String value,
    String growth,
    MaterialColor color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color.shade700,
              size: 21,
            ),
          ),
          const SizedBox(width: 11),
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
                  growth,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color.shade700,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSection() {
    return _sectionCard(
      title: 'Social contribution',
      subtitle: 'People and communities benefiting from resource reuse.',
      icon: Icons.groups_outlined,
      child: Row(
        children: [
          Expanded(
            child: _socialMetric(
              '86',
              'Beneficiaries',
              Icons.person_outline,
            ),
          ),
          Expanded(
            child: _socialMetric(
              '17',
              'Communities',
              Icons.location_city_outlined,
            ),
          ),
          Expanded(
            child: _socialMetric(
              '31',
              'Exchanges',
              Icons.handshake_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialMetric(
    String value,
    String label,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.teal.shade700,
          size: 22,
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildImpactBreakdown() {
    return _sectionCard(
      title: 'Impact by category',
      subtitle: 'Where your contribution is creating the most value.',
      icon: Icons.donut_large_outlined,
      trailing: TextButton(
        onPressed: () {
          _showMessage('Detailed category analytics opened');
        },
        child: const Text('Details'),
      ),
      child: Column(
        children: _categories.map(
          (category) {
            return InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                _showImpactDetails(
                  category.title,
                  category.metric,
                  category.icon,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            category.icon,
                            size: 19,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                category.subtitle,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          category.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: category.progress,
                        minHeight: 7,
                        backgroundColor: Colors.grey.shade100,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildMonthlyTrend() {
    final values = [0.38, 0.52, 0.45, 0.68, 0.74, 0.91];

    return _sectionCard(
      title: 'Impact growth',
      subtitle: 'Your monthly contribution is trending upward.',
      icon: Icons.trending_up_rounded,
      child: SizedBox(
        height: 175,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: values.asMap().entries.map(
                  (entry) {
                    final labels = [
                      'Mar',
                      'Apr',
                      'May',
                      'Jun',
                      'Jul',
                      'Aug',
                    ];

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${(entry.value * 45).round()}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: FractionallySizedBox(
                                  heightFactor: entry.value,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(7),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              labels[entry.key],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 8.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.77,
                  strokeWidth: 6,
                  backgroundColor: Colors.green.withValues(alpha: 0.10),
                  color: Colors.green.shade600,
                ),
                const Text(
                  '77%',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next milestone',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '50 kg CO₂e avoided',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Only 11.4 kg more to reach your next sustainability milestone.',
                  style: TextStyle(
                    fontSize: 10,
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

  Widget _buildRecentImpact() {
    return _sectionCard(
      title: 'Recent impact',
      subtitle: 'Latest contributions recorded by ResourceX.',
      icon: Icons.history_rounded,
      child: Column(
        children: _recentImpact.map(
          (activity) {
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showImpactDetails(
                  activity.title,
                  activity.subtitle,
                  activity.icon,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        activity.icon,
                        color: Colors.green.shade700,
                        size: 21,
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
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
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
                          const SizedBox(height: 4),
                          Text(
                            activity.time,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 8.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      activity.impact,
                      style: TextStyle(
                        color: activity.type == 'Social'
                            ? Colors.teal.shade700
                            : Colors.green.shade700,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildSustainabilityTips() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.green.shade700,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Increase your impact',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Prioritize resources with high reuse potential and connect them with urgent community requirements.',
                  style: TextStyle(
                    fontSize: 10.5,
                    height: 1.45,
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
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
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
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.green.shade700,
                  size: 20,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _ImpactCategory {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final double progress;
  final String metric;

  const _ImpactCategory({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.progress,
    required this.metric,
  });
}

class _ImpactActivity {
  final String title;
  final String subtitle;
  final String impact;
  final String time;
  final IconData icon;
  final String type;

  const _ImpactActivity({
    required this.title,
    required this.subtitle,
    required this.impact,
    required this.time,
    required this.icon,
    required this.type,
  });
}