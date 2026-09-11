import 'package:flutter/material.dart';

class ResourceIntelligenceScreen extends StatefulWidget {
  const ResourceIntelligenceScreen({super.key});

  @override
  State<ResourceIntelligenceScreen> createState() =>
      _ResourceIntelligenceScreenState();
}

class _ResourceIntelligenceScreenState
    extends State<ResourceIntelligenceScreen> {
  int _selectedView = 0;

  final List<String> _views = [
    'Overview',
    'Demand',
    'Supply',
    'Insights',
  ];

  final List<_DemandItem> _demandItems = [
    _DemandItem(
      title: 'Laptops',
      demand: 92,
      supply: 64,
      status: 'High demand',
      icon: Icons.laptop_mac_outlined,
    ),
    _DemandItem(
      title: 'Engineering Books',
      demand: 81,
      supply: 58,
      status: 'Growing demand',
      icon: Icons.menu_book_outlined,
    ),
    _DemandItem(
      title: 'Projectors',
      demand: 67,
      supply: 73,
      status: 'Balanced',
      icon: Icons.videocam_outlined,
    ),
    _DemandItem(
      title: 'Furniture',
      demand: 54,
      supply: 86,
      status: 'High supply',
      icon: Icons.chair_outlined,
    ),
  ];

  final List<_InsightItem> _insights = [
    _InsightItem(
      title: 'Laptop demand is increasing',
      description:
          'ResourceX detected a 24% increase in laptop requirements around your network.',
      icon: Icons.trending_up_rounded,
      label: 'Demand signal',
    ),
    _InsightItem(
      title: 'Unused resources detected',
      description:
          'Several available resources have remained unclaimed for more than 7 days.',
      icon: Icons.inventory_2_outlined,
      label: 'Optimization',
    ),
    _InsightItem(
      title: 'Books have strong reuse potential',
      description:
          'Educational materials are showing a high successful-exchange rate.',
      icon: Icons.auto_graph_rounded,
      label: 'Opportunity',
    ),
    _InsightItem(
      title: 'Nearby supply can satisfy urgent needs',
      description:
          'Four nearby resources closely match currently urgent requirements.',
      icon: Icons.near_me_outlined,
      label: 'Smart match',
    ),
  ];

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

  void _showInsightDetails(_InsightItem insight) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        insight.icon,
                        color: Colors.green.shade700,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        insight.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  insight.description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.analytics_outlined,
                  'Signal type',
                  insight.label,
                ),
                _detailRow(
                  Icons.psychology_outlined,
                  'Analysis',
                  'ResourceX intelligence engine',
                ),
                _detailRow(
                  Icons.check_circle_outline,
                  'Confidence',
                  'High',
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage('Insight added to your action plan');
                    },
                    child: const Text('Use This Insight'),
                  ),
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
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.green.shade700,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryDetails(_DemandItem item) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      item.icon,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _statLine(
                'Demand index',
                '${item.demand}/100',
                item.demand / 100,
              ),
              _statLine(
                'Supply index',
                '${item.supply}/100',
                item.supply / 100,
              ),
              const SizedBox(height: 12),
              Text(
                item.status,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Exploring ${item.title} opportunities',
                    );
                  },
                  child: const Text('Explore Category'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statLine(
    String title,
    String value,
    double progress,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: Colors.grey.shade100,
              color: Colors.green.shade600,
            ),
          ),
        ],
      ),
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
              'Resource Intelligence',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Understand supply, demand and opportunities',
              style: TextStyle(
                fontSize: 10.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showMessage('Intelligence data refreshed');
            },
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        children: [
          _buildHero(),
          const SizedBox(height: 18),
          _buildViewSelector(),
          const SizedBox(height: 20),
          if (_selectedView == 0) ...[
            _buildOverviewStats(),
            const SizedBox(height: 20),
            _buildDemandSignals(),
            const SizedBox(height: 20),
            _buildOpportunityCard(),
            const SizedBox(height: 20),
            _buildInsights(),
          ] else if (_selectedView == 1) ...[
            _buildDemandSignals(),
            const SizedBox(height: 20),
            _buildDemandAnalysis(),
          ] else if (_selectedView == 2) ...[
            _buildSupplyAnalysis(),
          ] else ...[
            _buildInsights(),
            const SizedBox(height: 20),
            _buildOpportunityCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildHero() {
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
        borderRadius: BorderRadius.circular(26),
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
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Text(
                  'ResourceX Intelligence',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
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
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Network Opportunity Score',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            '87 / 100',
            style: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Your network currently has strong potential for successful resource exchanges.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewSelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _views.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedView == index;

          return ChoiceChip(
            label: Text(
              _views[index],
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.grey.shade700,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedView = index;
              });
            },
            selectedColor: Colors.green.shade700,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selected
                  ? Colors.green.shade700
                  : Colors.grey.shade200,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewStats() {
    return Row(
      children: [
        Expanded(
          child: _overviewStat(
            '1,248',
            'Resources',
            Icons.inventory_2_outlined,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _overviewStat(
            '684',
            'Requirements',
            Icons.assignment_outlined,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _overviewStat(
            '76%',
            'Match rate',
            Icons.auto_awesome_outlined,
          ),
        ),
      ],
    );
  }

  Widget _overviewStat(
    String value,
    String label,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(11, 13, 11, 13),
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
            color: Colors.green.shade700,
            size: 19,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 8.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemandSignals() {
    return _sectionCard(
      title: 'Demand & supply signals',
      subtitle: 'Current network activity by resource category.',
      icon: Icons.bar_chart_rounded,
      child: Column(
        children: _demandItems.map(
          (item) {
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showCategoryDetails(item);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item.icon,
                            color: Colors.green.shade700,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.status,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          item.demand > item.supply
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          color: item.demand > item.supply
                              ? Colors.orange.shade700
                              : Colors.green.shade700,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _miniBar(
                            'Demand',
                            item.demand / 100,
                            Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _miniBar(
                            'Supply',
                            item.supply / 100,
                            Colors.green,
                          ),
                        ),
                      ],
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

  Widget _miniBar(
    String label,
    double value,
    MaterialColor color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 8,
                ),
              ),
            ),
            Text(
              '${(value * 100).round()}%',
              style: TextStyle(
                color: color.shade700,
                fontSize: 8,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 5,
            backgroundColor: Colors.grey.shade100,
            color: color.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildOpportunityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.18),
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
                  color: Colors.orange.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: Colors.orange.shade800,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Highest-value opportunity',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Connect unused laptops with active education requirements.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Potential impact: 14 beneficiaries • 8 resources • 3 nearby requirements',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 9.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                _showMessage(
                  'Opening high-value laptop opportunities',
                );
              },
              icon: const Icon(
                Icons.auto_awesome_rounded,
                size: 17,
              ),
              label: const Text('Explore Opportunity'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsights() {
    return _sectionCard(
      title: 'Intelligent insights',
      subtitle: 'Signals generated from ResourceX network activity.',
      icon: Icons.lightbulb_outline_rounded,
      child: Column(
        children: _insights.map(
          (insight) {
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showInsightDetails(insight);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        insight.icon,
                        color: Colors.green.shade700,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  insight.title,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                size: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            insight.description,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 9.5,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(
                                alpha: 0.07,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              insight.label,
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 7.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildDemandAnalysis() {
    return _sectionCard(
      title: 'Demand analysis',
      subtitle: 'Categories requiring additional resource supply.',
      icon: Icons.priority_high_rounded,
      child: Column(
        children: [
          _analysisRow(
            'Laptops',
            'Very High',
            '28 open requirements',
            0.92,
          ),
          _analysisRow(
            'Engineering Books',
            'High',
            '19 open requirements',
            0.81,
          ),
          _analysisRow(
            'Medical Supplies',
            'High',
            '14 open requirements',
            0.76,
          ),
          _analysisRow(
            'Lab Equipment',
            'Moderate',
            '9 open requirements',
            0.61,
          ),
        ],
      ),
    );
  }

  Widget _analysisRow(
    String title,
    String level,
    String details,
    double value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                level,
                style: TextStyle(
                  color: Colors.orange.shade800,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            details,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              backgroundColor: Colors.grey.shade100,
              color: Colors.orange.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplyAnalysis() {
    return _sectionCard(
      title: 'Supply intelligence',
      subtitle: 'Resources currently available across the network.',
      icon: Icons.inventory_2_outlined,
      child: Column(
        children: [
          _supplyRow(
            'Furniture',
            '86%',
            'High supply',
            Icons.chair_outlined,
          ),
          _supplyRow(
            'Projectors',
            '73%',
            'Healthy supply',
            Icons.videocam_outlined,
          ),
          _supplyRow(
            'Books',
            '58%',
            'Moderate supply',
            Icons.menu_book_outlined,
          ),
          _supplyRow(
            'Laptops',
            '64%',
            'Below demand',
            Icons.laptop_mac_outlined,
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tips_and_updates_outlined,
                  color: Colors.green.shade700,
                  size: 20,
                ),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Consider promoting laptops and books to increase successful exchanges.',
                    style: TextStyle(
                      fontSize: 9.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _supplyRow(
    String title,
    String percentage,
    String status,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
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
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  status,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              color: Colors.green.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w900,
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
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _DemandItem {
  final String title;
  final int demand;
  final int supply;
  final String status;
  final IconData icon;

  const _DemandItem({
    required this.title,
    required this.demand,
    required this.supply,
    required this.status,
    required this.icon,
  });
}

class _InsightItem {
  final String title;
  final String description;
  final IconData icon;
  final String label;

  const _InsightItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.label,
  });
}