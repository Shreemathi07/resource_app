import 'package:flutter/material.dart';

class RequirementAgreementScreen extends StatefulWidget {
  const RequirementAgreementScreen({super.key});

  @override
  State<RequirementAgreementScreen> createState() =>
      _RequirementAgreementScreenState();
}

class _RequirementAgreementScreenState
    extends State<RequirementAgreementScreen> {
  int selectedTab = 0;

  final List<String> tabs = [
    'Overview',
    'Agreements',
    'Terms',
    'History',
  ];

  final List<Map<String, dynamic>> agreements = [
    {
      'title': 'Laptop Resource Agreement',
      'provider': 'TechCare Foundation',
      'resource': 'Refurbished Laptops',
      'quantity': 12,
      'status': 'Ready',
      'progress': 92,
      'date': 'Today',
    },
    {
      'title': 'Food Support Agreement',
      'provider': 'Community Food Network',
      'resource': 'Packaged Food',
      'quantity': 80,
      'status': 'Review',
      'progress': 74,
      'date': 'Yesterday',
    },
    {
      'title': 'Education Material Agreement',
      'provider': 'Learning Resource Hub',
      'resource': 'Engineering Books',
      'quantity': 35,
      'status': 'Negotiating',
      'progress': 61,
      'date': '2 days ago',
    },
  ];

  final List<Map<String, dynamic>> terms = [
    {
      'title': 'Resource quantity',
      'value': '12 units',
      'icon': Icons.inventory_2_rounded,
    },
    {
      'title': 'Resource condition',
      'value': 'Good condition',
      'icon': Icons.verified_rounded,
    },
    {
      'title': 'Handover method',
      'value': 'Community pickup',
      'icon': Icons.local_shipping_rounded,
    },
    {
      'title': 'Handover location',
      'value': 'Vellore Community Hub',
      'icon': Icons.location_on_rounded,
    },
    {
      'title': 'Expected date',
      'value': '10 September 2026',
      'icon': Icons.event_rounded,
    },
  ];

  final List<Map<String, dynamic>> history = [
    {
      'title': 'Agreement created',
      'description': 'Requirement was matched with TechCare Foundation.',
      'time': 'Today, 9:10 AM',
      'icon': Icons.add_circle_rounded,
    },
    {
      'title': 'Terms discussed',
      'description': 'Quantity and condition were confirmed.',
      'time': 'Today, 9:28 AM',
      'icon': Icons.forum_rounded,
    },
    {
      'title': 'Provider confirmed',
      'description': 'Provider accepted the proposed exchange terms.',
      'time': 'Today, 10:02 AM',
      'icon': Icons.check_circle_rounded,
    },
    {
      'title': 'Ready for scheduling',
      'description': 'The agreement can now move to handover scheduling.',
      'time': 'Today, 10:15 AM',
      'icon': Icons.event_available_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text(
          'Requirement Agreement',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showNotifications,
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
            _buildTabs(scheme),
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  _buildOverview(scheme),
                  _buildAgreements(scheme),
                  _buildTerms(scheme),
                  _buildHistory(scheme),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateAgreement,
        icon: const Icon(Icons.handshake_rounded),
        label: const Text('New Agreement'),
      ),
    );
  }

  Widget _buildTabs(ColorScheme scheme) {
    return Container(
      height: 58,
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
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? scheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w700,
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
        _buildStats(scheme),
        const SizedBox(height: 20),
        _sectionTitle('Agreement Progress', 'View all'),
        const SizedBox(height: 10),
        ...agreements.take(2).map(
              (agreement) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _agreementCard(agreement, scheme),
              ),
            ),
        const SizedBox(height: 12),
        _sectionTitle('Smart Agreement Insight', 'Details'),
        const SizedBox(height: 10),
        _buildInsight(
          scheme,
          Icons.auto_awesome_rounded,
          'Agreement is almost ready',
          'Most important terms have already been confirmed. Only the handover schedule remains.',
        ),
        const SizedBox(height: 12),
        _buildInsight(
          scheme,
          Icons.security_rounded,
          'Trust signals are strong',
          'The selected provider has verified identity, strong reliability and positive community feedback.',
        ),
        const SizedBox(height: 20),
        _sectionTitle('Current Terms', ''),
        const SizedBox(height: 10),
        _termsCard(scheme),
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
            scheme.primary.withValues(alpha: 0.72),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
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
                  color: Colors.white.withValues(alpha: 0.17),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.description_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SMART AGREEMENT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Turn Provider Offers\ninto Clear Agreements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Define exchange terms, confirm expectations and prepare every requirement for successful fulfillment.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _heroMetric('3', 'Agreements'),
              _heroMetric('2', 'Confirmed'),
              _heroMetric('92%', 'Readiness'),
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
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(ColorScheme scheme) {
    final stats = [
      ('3', 'Agreements', Icons.description_rounded),
      ('2', 'Confirmed', Icons.check_circle_rounded),
      ('1', 'In Review', Icons.rate_review_rounded),
      ('92%', 'Readiness', Icons.speed_rounded),
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
            border: Border.all(
              color: const Color(0xFFE6EAF0),
            ),
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
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAgreements(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle(
          'Active Agreements',
          '${agreements.length} total',
        ),
        const SizedBox(height: 12),
        ...agreements.map(
          (agreement) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _agreementCard(agreement, scheme),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _agreementCard(
    Map<String, dynamic> agreement,
    ColorScheme scheme,
  ) {
    final progress = agreement['progress'] as int;

    return InkWell(
      onTap: () => _showAgreementDetails(agreement),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.handshake_rounded,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        agreement['title'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        agreement['provider'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(
                  agreement['status'].toString(),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                _miniInfo(
                  Icons.inventory_2_outlined,
                  agreement['resource'].toString(),
                ),
                _miniInfo(
                  Icons.numbers_rounded,
                  '${agreement['quantity']} units',
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Agreement readiness',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '$progress%',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress / 100,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 5),
                Text(
                  agreement['date'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color background;
    Color foreground;

    switch (status) {
      case 'Ready':
        background = Colors.green.withValues(alpha: 0.10);
        foreground = Colors.green.shade700;
        break;
      case 'Review':
        background = Colors.orange.withValues(alpha: 0.10);
        foreground = Colors.orange.shade700;
        break;
      default:
        background = Colors.blue.withValues(alpha: 0.10);
        foreground = Colors.blue.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildTerms(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTermsHero(scheme),
        const SizedBox(height: 18),
        _sectionTitle('Exchange Terms', 'Edit'),
        const SizedBox(height: 10),
        _termsCard(scheme),
        const SizedBox(height: 20),
        _sectionTitle('Confirmation Checklist', ''),
        const SizedBox(height: 10),
        _checkItem(
          scheme,
          'Provider identity verified',
          true,
        ),
        _checkItem(
          scheme,
          'Resource quantity confirmed',
          true,
        ),
        _checkItem(
          scheme,
          'Resource condition confirmed',
          true,
        ),
        _checkItem(
          scheme,
          'Handover location agreed',
          true,
        ),
        _checkItem(
          scheme,
          'Handover date scheduled',
          false,
        ),
        const SizedBox(height: 20),
        _buildAgreementAction(scheme),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildTermsHero(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.92,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade200,
                ),
                Text(
                  '92%',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agreement Readiness',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'All major exchange terms are confirmed. Complete scheduling to finalize.',
                  style: TextStyle(
                    color: Colors.grey,
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

  Widget _termsCard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
      ),
      child: Column(
        children: terms.map((term) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    term['icon'] as IconData,
                    color: scheme.primary,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    term['title'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    term['value'].toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _checkItem(
    ColorScheme scheme,
    String title,
    bool completed,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: completed
                ? Colors.green.shade600
                : Colors.grey.shade400,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: completed
                    ? Colors.black87
                    : Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
          if (!completed)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Scheduling opened'),
                  ),
                );
              },
              child: const Text('Complete'),
            ),
        ],
      ),
    );
  }

  Widget _buildAgreementAction(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ready to finalize?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Once the handover schedule is confirmed, this agreement can move to fulfillment.',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 11,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Agreement marked ready for fulfillment',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.check_rounded),
              label: const Text('Finalize Agreement'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistory(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Agreement History', 'Export'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFE6EAF0),
            ),
          ),
          child: Column(
            children: List.generate(
              history.length,
              (index) {
                final item = history[index];
                final last = index == history.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (!last)
                          Container(
                            width: 2,
                            height: 68,
                            color: scheme.primary.withValues(alpha: 0.15),
                          ),
                      ],
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'].toString(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['time'].toString(),
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      item['icon'] as IconData,
                      size: 18,
                      color: scheme.primary,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        _sectionTitle('Agreement Activity', ''),
        const SizedBox(height: 10),
        _activityTile(
          scheme,
          Icons.edit_note_rounded,
          'Terms updated',
          'Resource condition was changed from Fair to Good.',
          'Today, 9:40 AM',
        ),
        _activityTile(
          scheme,
          Icons.chat_rounded,
          'Provider message',
          'Provider confirmed availability for the requested date.',
          'Today, 9:52 AM',
        ),
        _activityTile(
          scheme,
          Icons.check_circle_rounded,
          'Provider approval',
          'All required terms were accepted.',
          'Today, 10:02 AM',
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _activityTile(
    ColorScheme scheme,
    IconData icon,
    String title,
    String description,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: scheme.primary,
          ),
          const SizedBox(width: 11),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade400,
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

  Widget _buildInsight(
    ColorScheme scheme,
    IconData icon,
    String title,
    String description,
  ) {
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
        if (action.isNotEmpty)
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$action opened'),
                ),
              );
            },
            child: Text(action),
          ),
      ],
    );
  }

  void _showAgreementDetails(Map<String, dynamic> agreement) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                agreement['title'].toString(),
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                agreement['provider'].toString(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              _detailRow(
                Icons.inventory_2_rounded,
                'Resource',
                agreement['resource'].toString(),
              ),
              _detailRow(
                Icons.numbers_rounded,
                'Quantity',
                '${agreement['quantity']} units',
              ),
              _detailRow(
                Icons.speed_rounded,
                'Readiness',
                '${agreement['progress']}%',
              ),
              _detailRow(
                Icons.info_outline_rounded,
                'Status',
                agreement['status'].toString(),
              ),
              _detailRow(
                Icons.event_rounded,
                'Created',
                agreement['date'].toString(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showEditTerms();
                      },
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text('Edit Terms'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Agreement moved to scheduling',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.event_available_rounded),
                      label: const Text('Schedule'),
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
            size: 19,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditTerms() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Exchange Terms',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: TextEditingController(text: '12'),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    prefixIcon: Icon(Icons.numbers_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'Good',
                  decoration: const InputDecoration(
                    labelText: 'Condition',
                    prefixIcon: Icon(Icons.verified_rounded),
                  ),
                  items: const [
                    'Excellent',
                    'Very Good',
                    'Good',
                    'Fair',
                  ]
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Handover location',
                    prefixIcon: Icon(Icons.location_on_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Additional notes',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.notes_rounded),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Agreement terms updated'),
                        ),
                      );
                    },
                    child: const Text('Save Terms'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCreateAgreement() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Agreement',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Define the terms for a new resource exchange.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Agreement title',
                    prefixIcon: Icon(Icons.description_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'TechCare Foundation',
                  decoration: const InputDecoration(
                    labelText: 'Provider',
                    prefixIcon: Icon(Icons.business_rounded),
                  ),
                  items: const [
                    'TechCare Foundation',
                    'Campus Digital Hub',
                    'Community Tech Network',
                    'Learning Resource Hub',
                  ]
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Resource',
                    prefixIcon: Icon(Icons.inventory_2_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    prefixIcon: Icon(Icons.numbers_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Agreement notes',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.notes_rounded),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'New agreement created successfully',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.handshake_rounded),
                    label: const Text('Create Agreement'),
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
      showDragHandle: true,
      builder: (sheetContext) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
          children: const [
            Text(
              'Agreement Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.check_circle_rounded),
              ),
              title: Text('Provider confirmed'),
              subtitle: Text(
                'TechCare Foundation accepted the exchange terms.',
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.event_rounded),
              ),
              title: Text('Scheduling required'),
              subtitle: Text(
                'Choose a handover date to complete the agreement.',
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.auto_awesome_rounded),
              ),
              title: Text('Agreement insight'),
              subtitle: Text(
                'Your current agreement has strong fulfillment readiness.',
              ),
            ),
          ],
        );
      },
    );
  }
}