import 'package:flutter/material.dart';

class RequirementCollaborationScreen extends StatefulWidget {
  const RequirementCollaborationScreen({super.key});

  @override
  State<RequirementCollaborationScreen> createState() =>
      _RequirementCollaborationScreenState();
}

class _RequirementCollaborationScreenState
    extends State<RequirementCollaborationScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Offers',
    'Discussion',
    'Confirmed',
  ];

  final List<String> filters = [
    'All',
    'New',
    'Best Match',
    'Negotiating',
    'Ready',
  ];

  final List<Map<String, dynamic>> offers = [
    {
      'provider': 'TechCare Foundation',
      'resource': 'Refurbished Laptops',
      'quantity': 12,
      'condition': 'Good',
      'distance': '4.2 km',
      'match': 96,
      'status': 'Best Match',
      'response': '10 min ago',
      'verified': true,
    },
    {
      'provider': 'Campus Digital Hub',
      'resource': 'Dell & HP Laptops',
      'quantity': 8,
      'condition': 'Very Good',
      'distance': '6.8 km',
      'match': 91,
      'status': 'New',
      'response': '25 min ago',
      'verified': true,
    },
    {
      'provider': 'Community Tech Network',
      'resource': 'Student Laptops',
      'quantity': 15,
      'condition': 'Fair',
      'distance': '11.4 km',
      'match': 84,
      'status': 'Negotiating',
      'response': '1 hr ago',
      'verified': true,
    },
    {
      'provider': 'Local Resource Center',
      'resource': 'Mixed Computer Devices',
      'quantity': 6,
      'condition': 'Good',
      'distance': '8.1 km',
      'match': 78,
      'status': 'Ready',
      'response': '2 hrs ago',
      'verified': false,
    },
  ];

  final List<Map<String, dynamic>> discussions = [
    {
      'name': 'TechCare Foundation',
      'message':
          'We can provide 12 laptops. Would you prefer pickup tomorrow morning?',
      'time': '10 min ago',
      'unread': true,
    },
    {
      'name': 'Campus Digital Hub',
      'message':
          'We have 8 devices available immediately. All are tested and working.',
      'time': '25 min ago',
      'unread': true,
    },
    {
      'name': 'Community Tech Network',
      'message':
          'Can increase the quantity to 15 if the handover is scheduled next week.',
      'time': '1 hr ago',
      'unread': false,
    },
  ];

  List<Map<String, dynamic>> get filteredOffers {
    return offers.where((offer) {
      final matchesSearch = offer['provider']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          offer['resource']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      final matchesFilter =
          selectedFilter == 'All' || offer['status'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text(
          'Requirement Collaboration',
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
            _buildSearchBar(),
            _buildTabs(scheme),
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  _buildOverview(scheme),
                  _buildOffers(scheme),
                  _buildDiscussion(scheme),
                  _buildConfirmed(scheme),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateRequirement,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Requirement'),
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
          hintText: 'Search providers or offers...',
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

  Widget _buildTabs(ColorScheme scheme) {
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? scheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
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
        _sectionTitle('Smart Collaboration Insight', 'View insights'),
        const SizedBox(height: 10),
        _buildInsight(
          scheme,
          Icons.auto_awesome_rounded,
          'Best provider identified',
          'TechCare Foundation has the strongest combination of compatibility, quantity and proximity.',
        ),
        const SizedBox(height: 12),
        _buildInsight(
          scheme,
          Icons.compare_arrows_rounded,
          'Multiple offers available',
          'You can compare 4 provider offers before confirming the requirement.',
        ),
        const SizedBox(height: 20),
        _sectionTitle('Top Provider Offers', 'Compare all'),
        const SizedBox(height: 10),
        ...filteredOffers.take(3).map(
              (offer) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _offerCard(offer, scheme),
              ),
            ),
        const SizedBox(height: 20),
        _sectionTitle('Latest Discussions', 'Open messages'),
        const SizedBox(height: 10),
        ...discussions.take(2).map(
              (discussion) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _discussionCard(discussion, scheme),
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
                  Icons.handshake_rounded,
                  color: Colors.white,
                  size: 26,
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
                  'COLLABORATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Compare, Discuss\nand Confirm Resources',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Bring providers and seekers together to agree on the best resource exchange.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _heroMetric('4', 'Offers'),
              _heroMetric('3', 'Discussions'),
              _heroMetric('1', 'Best Match'),
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

  Widget _buildStats(ColorScheme scheme) {
    final stats = [
      ('4', 'Provider Offers', Icons.inventory_2_rounded),
      ('39', 'Resources Offered', Icons.layers_rounded),
      ('92%', 'Avg Match', Icons.auto_awesome_rounded),
      ('1', 'Ready to Confirm', Icons.check_circle_rounded),
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
            border: Border.all(color: const Color(0xFFE6EAF0)),
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

  Widget _buildOffers(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFilterChips(),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Provider Offers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(
              '${filteredOffers.length} offers',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...filteredOffers.map(
          (offer) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _offerCard(offer, scheme),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];

          return ChoiceChip(
            label: Text(filter),
            selected: selectedFilter == filter,
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

  Widget _offerCard(
    Map<String, dynamic> offer,
    ColorScheme scheme,
  ) {
    return InkWell(
      onTap: () => _showOfferDetails(offer),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE5E9EF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: scheme.primary.withValues(alpha: 0.10),
                  child: Icon(
                    Icons.business_rounded,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              offer['provider'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          if (offer['verified'] == true) ...[
                            const SizedBox(width: 5),
                            Icon(
                              Icons.verified_rounded,
                              color: scheme.primary,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer['resource'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(offer['status'].toString()),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                _offerStat(
                  Icons.inventory_2_outlined,
                  '${offer['quantity']}',
                  'Quantity',
                ),
                _offerStat(
                  Icons.verified_outlined,
                  offer['condition'].toString(),
                  'Condition',
                ),
                _offerStat(
                  Icons.location_on_outlined,
                  offer['distance'].toString(),
                  'Distance',
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  '${offer['match']}% compatibility',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  offer['response'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (offer['match'] as int) / 100,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showDiscussion(offer),
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    label: const Text('Discuss'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _confirmOffer(offer),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Select'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _offerStat(IconData icon, String value, String label) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
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

  Widget _statusBadge(String status) {
    Color background;
    Color foreground;

    if (status == 'Best Match') {
      background = Colors.green.withValues(alpha: 0.10);
      foreground = Colors.green.shade700;
    } else if (status == 'Negotiating') {
      background = Colors.orange.withValues(alpha: 0.10);
      foreground = Colors.orange.shade700;
    } else if (status == 'Ready') {
      background = Colors.blue.withValues(alpha: 0.10);
      foreground = Colors.blue.shade700;
    } else {
      background = Colors.purple.withValues(alpha: 0.10);
      foreground = Colors.purple.shade700;
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

  Widget _buildDiscussion(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildDiscussionHeader(scheme),
        const SizedBox(height: 16),
        ...discussions.map(
          (discussion) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _discussionCard(discussion, scheme),
          ),
        ),
        const SizedBox(height: 20),
        _sectionTitle('Negotiation Tips', 'Learn more'),
        const SizedBox(height: 10),
        _tipCard(
          scheme,
          Icons.inventory_2_rounded,
          'Clarify quantity',
          'Confirm the exact number of resources available before accepting an offer.',
        ),
        _tipCard(
          scheme,
          Icons.fact_check_rounded,
          'Verify condition',
          'Ask providers to confirm resource condition and important specifications.',
        ),
        _tipCard(
          scheme,
          Icons.schedule_rounded,
          'Agree on timing',
          'Confirm a convenient handover date and location with the provider.',
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildDiscussionHeader(ColorScheme scheme) {
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.forum_rounded,
              color: scheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Active Discussions',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Continue conversations and finalize exchange details.',
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

  Widget _discussionCard(
    Map<String, dynamic> discussion,
    ColorScheme scheme,
  ) {
    return InkWell(
      onTap: () => _showConversation(discussion),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE6EAF0)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: scheme.primary.withValues(alpha: 0.10),
                  child: Icon(
                    Icons.business_rounded,
                    color: scheme.primary,
                  ),
                ),
                if (discussion['unread'] == true)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          discussion['name'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        discussion['time'].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    discussion['message'].toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }

  Widget _tipCard(
    ColorScheme scheme,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmed(ColorScheme scheme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.green.withValues(alpha: 0.18),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green.shade700,
                  size: 36,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Requirement Ready for Fulfillment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'TechCare Foundation has been selected as the preferred provider.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _sectionTitle('Confirmed Exchange', 'View details'),
        const SizedBox(height: 10),
        _confirmedCard(scheme),
        const SizedBox(height: 20),
        _sectionTitle('Next Steps', ''),
        const SizedBox(height: 10),
        _nextStep(
          scheme,
          'Schedule handover',
          'Choose a suitable date and location.',
          Icons.event_available_rounded,
        ),
        _nextStep(
          scheme,
          'Verify resources',
          'Confirm quantity and condition at handover.',
          Icons.fact_check_rounded,
        ),
        _nextStep(
          scheme,
          'Complete exchange',
          'Record the successful resource transfer.',
          Icons.handshake_rounded,
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _confirmedCard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Column(
        children: [
          _detailRow(
            Icons.business_rounded,
            'Provider',
            'TechCare Foundation',
          ),
          _detailRow(
            Icons.inventory_2_rounded,
            'Resource',
            'Refurbished Laptops',
          ),
          _detailRow(
            Icons.numbers_rounded,
            'Quantity',
            '12 units',
          ),
          _detailRow(
            Icons.verified_rounded,
            'Condition',
            'Good',
          ),
          _detailRow(
            Icons.location_on_rounded,
            'Distance',
            '4.2 km',
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Exchange scheduling opened'),
                  ),
                );
              },
              icon: const Icon(Icons.event_rounded),
              label: const Text('Schedule Handover'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nextStep(
    ColorScheme scheme,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
              color: scheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
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
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
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
                  style: const TextStyle(fontWeight: FontWeight.w800),
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
                SnackBar(content: Text('$action opened')),
              );
            },
            child: Text(action),
          ),
      ],
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

  void _showOfferDetails(Map<String, dynamic> offer) {
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
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.business_rounded),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      offer['provider'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.inventory_2_rounded,
                'Resource',
                offer['resource'].toString(),
              ),
              _detailRow(
                Icons.numbers_rounded,
                'Quantity',
                '${offer['quantity']} units',
              ),
              _detailRow(
                Icons.verified_rounded,
                'Condition',
                offer['condition'].toString(),
              ),
              _detailRow(
                Icons.location_on_rounded,
                'Distance',
                offer['distance'].toString(),
              ),
              _detailRow(
                Icons.auto_awesome_rounded,
                'Compatibility',
                '${offer['match']}%',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showDiscussion(offer);
                      },
                      icon: const Icon(Icons.chat_rounded),
                      label: const Text('Discuss'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _confirmOffer(offer);
                      },
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Select Offer'),
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

  void _showDiscussion(Map<String, dynamic> offer) {
    final controller = TextEditingController();

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discuss with ${offer['provider']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                offer['resource'].toString(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F4F8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Hi! We are interested in your offer. Could you confirm the resource condition and preferred handover time?',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Write your message...',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.message_rounded),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Message sent successfully'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Send Message'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConversation(Map<String, dynamic> discussion) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SizedBox(
          height: MediaQuery.of(sheetContext).size.height * 0.72,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              8,
              20,
              MediaQuery.of(sheetContext).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.business_rounded),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        discussion['name'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const Icon(Icons.verified_rounded),
                  ],
                ),
                const Divider(height: 25),
                Expanded(
                  child: ListView(
                    children: [
                      _messageBubble(
                        'Hi! We can provide the requested resources.',
                        false,
                      ),
                      _messageBubble(
                        'Great. Could you confirm the quantity and condition?',
                        true,
                      ),
                      _messageBubble(
                        discussion['message'].toString(),
                        false,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Message sent'),
                          ),
                        );
                        controller.clear();
                      },
                      icon: const Icon(Icons.send_rounded),
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

  Widget _messageBubble(String text, bool mine) {
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 290),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mine
              ? Theme.of(context).colorScheme.primary
              : const Color(0xFFF0F3F7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: mine ? Colors.white : Colors.black87,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  void _confirmOffer(Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Select this provider?',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: Text(
            'You are selecting ${offer['provider']} for ${offer['quantity']} ${offer['resource']}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${offer['provider']} selected successfully',
                    ),
                  ),
                );
                setState(() {
                  selectedTab = 3;
                });
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Offers',
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
                      setState(() {
                        selectedFilter = filter;
                      });
                      Navigator.pop(sheetContext);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  void _showCreateRequirement() {
    final controller = TextEditingController();

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
                  'Create Requirement',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Describe what your community needs.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Requirement name',
                    prefixIcon: Icon(Icons.inventory_2_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: 'Technology',
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_rounded),
                  ),
                  items: const [
                    'Technology',
                    'Education',
                    'Food',
                    'Furniture',
                    'Clothing',
                    'Other',
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
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity needed',
                    prefixIcon: Icon(Icons.numbers_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Additional details',
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
                            'Requirement created successfully',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Create Requirement'),
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
          children: [
            const Text(
              'Collaboration Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.local_offer_rounded),
              ),
              title: Text('New provider offer'),
              subtitle: Text(
                'Campus Digital Hub submitted an offer',
              ),
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.chat_rounded),
              ),
              title: Text('New discussion message'),
              subtitle: Text(
                'TechCare Foundation replied to your requirement',
              ),
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.auto_awesome_rounded),
              ),
              title: Text('Best match identified'),
              subtitle: Text(
                'A provider with 96% compatibility was found',
              ),
            ),
          ],
        );
      },
    );
  }
}