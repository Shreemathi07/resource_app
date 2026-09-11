import 'package:flutter/material.dart';

class CommunityCollaborationScreen extends StatefulWidget {
  const CommunityCollaborationScreen({super.key});

  @override
  State<CommunityCollaborationScreen> createState() =>
      _CommunityCollaborationScreenState();
}

class _CommunityCollaborationScreenState
    extends State<CommunityCollaborationScreen> {
  int selectedTab = 0;
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<Map<String, dynamic>> collaborations = [
    {
      'title': 'Campus Stationery Drive',
      'description':
          'Collect unused notebooks, pens and study materials for students who need them.',
      'category': 'Education',
      'members': 28,
      'needed': 8,
      'status': 'Active',
      'location': 'VIT Campus',
      'time': 'Ends in 6 days',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Community Laptop Sharing',
      'description':
          'Coordinate temporary laptop access for students working on academic projects.',
      'category': 'Technology',
      'members': 19,
      'needed': 5,
      'status': 'Growing',
      'location': 'Vellore',
      'time': 'Starts Sep 12',
      'icon': Icons.laptop_mac_outlined,
    },
    {
      'title': 'Zero Waste Resource Week',
      'description':
          'Help redirect reusable items away from waste through local community exchanges.',
      'category': 'Sustainability',
      'members': 42,
      'needed': 12,
      'status': 'Active',
      'location': 'Vellore',
      'time': 'Ends in 12 days',
      'icon': Icons.recycling_outlined,
    },
    {
      'title': 'Student Skill Exchange',
      'description':
          'Connect students who can teach practical skills with people who want to learn.',
      'category': 'Skills',
      'members': 34,
      'needed': 10,
      'status': 'Popular',
      'location': 'Online',
      'time': 'Open now',
      'icon': Icons.lightbulb_outline_rounded,
    },
    {
      'title': 'Emergency Study Kit Network',
      'description':
          'Build a ready-to-share collection of essential academic supplies.',
      'category': 'Community',
      'members': 17,
      'needed': 6,
      'status': 'New',
      'location': 'VIT Campus',
      'time': 'Starts Sep 15',
      'icon': Icons.volunteer_activism_outlined,
    },
  ];

  final List<Map<String, dynamic>> announcements = [
    {
      'title': 'ResourceX Community Day',
      'description':
          'A platform-wide collaboration event is coming this weekend.',
      'time': '2 hours ago',
      'icon': Icons.campaign_outlined,
    },
    {
      'title': 'New sustainability challenge',
      'description':
          'Help the community reuse 100 resources this month.',
      'time': 'Yesterday',
      'icon': Icons.eco_outlined,
    },
    {
      'title': 'Community milestone reached',
      'description':
          'ResourceX members have completed more than 1,000 exchanges.',
      'time': '2 days ago',
      'icon': Icons.emoji_events_outlined,
    },
  ];

  final List<Map<String, dynamic>> members = [
    {
      'name': 'Ananya R.',
      'role': 'Community Organizer',
      'contributions': 86,
      'rating': 4.9,
      'badge': 'Top Contributor',
    },
    {
      'name': 'Vikram S.',
      'role': 'Resource Coordinator',
      'contributions': 71,
      'rating': 4.8,
      'badge': 'Trusted',
    },
    {
      'name': 'Priya M.',
      'role': 'Student Volunteer',
      'contributions': 64,
      'rating': 4.8,
      'badge': 'Active Helper',
    },
    {
      'name': 'Arjun K.',
      'role': 'Technology Mentor',
      'contributions': 52,
      'rating': 4.7,
      'badge': 'Skill Mentor',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Community Hub',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          IconButton(
            onPressed: refreshCommunity,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshCommunity,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          children: [
            buildCommunityHero(),
            const SizedBox(height: 18),
            buildSearchBar(),
            const SizedBox(height: 14),
            buildTabSelector(),
            const SizedBox(height: 18),
            if (selectedTab == 0) ...[
              buildCommunityStats(),
              const SizedBox(height: 18),
              buildTrendingCollaboration(),
              const SizedBox(height: 18),
              buildCollaborationList(),
              const SizedBox(height: 18),
              buildAnnouncements(),
            ] else if (selectedTab == 1) ...[
              buildCollaborationList(),
              const SizedBox(height: 18),
              buildCollaborationTips(),
            ] else if (selectedTab == 2) ...[
              buildMemberStats(),
              const SizedBox(height: 18),
              buildMembersList(),
              const SizedBox(height: 18),
              buildRecognitionCard(),
            ] else ...[
              buildChallenges(),
              const SizedBox(height: 18),
              buildCommunityImpact(),
              const SizedBox(height: 18),
              buildIdeas(),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showCreateOptions,
        backgroundColor: const Color(0xFF18202A),
        icon: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        label: const Text(
          'Create',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget buildCommunityHero() {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF18202A),
            Color(0xFF52677D),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'ResourceX Community',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 23),
          const Text(
            'Build together.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Share resources, skills and ideas with people around you.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              heroStat('2.4K', 'Members'),
              heroStat('186', 'Projects'),
              heroStat('94', 'Communities'),
            ],
          ),
        ],
      ),
    );
  }

  Widget heroStat(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE3E7EC),
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
        decoration: const InputDecoration(
          hintText: 'Search collaborations, members or ideas...',
          hintStyle: TextStyle(
            fontSize: 10,
            color: Color(0xFF9AA3AE),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: Color(0xFF687382),
          ),
          suffixIcon: Icon(
            Icons.tune_rounded,
            size: 19,
            color: Color(0xFF687382),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget buildTabSelector() {
    final tabs = [
      'Overview',
      'Collaborate',
      'Members',
      'Impact',
    ];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final selected = selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: selected
                          ? const Color(0xFF18202A)
                          : const Color(0xFF7A8491),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCommunityStats() {
    return Row(
      children: [
        Expanded(
          child: communityStat(
            'Active',
            '186',
            Icons.bolt_rounded,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: communityStat(
            'Members',
            '2.4K',
            Icons.people_outline_rounded,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: communityStat(
            'Resources',
            '8.7K',
            Icons.inventory_2_outlined,
          ),
        ),
      ],
    );
  }

  Widget communityStat(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: 108,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF3867D6),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrendingCollaboration() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Color(0xFFE46A2B),
              size: 23,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending collaboration',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF3867D6),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Student Skill Exchange',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '34 members are currently sharing skills and learning together.',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.4,
                    color: Color(0xFF687382),
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'Explore collaboration →',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3867D6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCollaborationList() {
    final filtered = collaborations.where((item) {
      final matchesSearch =
          searchQuery.isEmpty ||
          item['title'].toString().toLowerCase().contains(searchQuery) ||
          item['description']
              .toString()
              .toLowerCase()
              .contains(searchQuery) ||
          item['category']
              .toString()
              .toLowerCase()
              .contains(searchQuery);

      final matchesFilter =
          selectedFilter == 'All' ||
          item['category'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Collaboration opportunities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF18202A),
                ),
              ),
            ),
            IconButton(
              onPressed: showFilters,
              icon: const Icon(
                Icons.filter_list_rounded,
                size: 20,
                color: Color(0xFF687382),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (filtered.isEmpty)
          buildEmptyState()
        else
          ...filtered.map(buildCollaborationCard),
      ],
    );
  }

  Widget buildCollaborationCard(
    Map<String, dynamic> item,
  ) {
    return GestureDetector(
      onTap: () => showCollaborationDetails(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5FF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFF3867D6),
                    size: 21,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['category'].toString(),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF3867D6),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                statusChip(item['status'].toString()),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item['description'].toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                height: 1.45,
                color: Color(0xFF687382),
              ),
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                infoItem(
                  Icons.people_outline_rounded,
                  '${item['members']} members',
                ),
                const SizedBox(width: 13),
                infoItem(
                  Icons.location_on_outlined,
                  item['location'].toString(),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 19,
                  color: Color(0xFF9AA3AE),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7EF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w900,
          color: Color(0xFF23844D),
        ),
      ),
    );
  }

  Widget infoItem(
    IconData icon,
    String text,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: const Color(0xFF8C96A2),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 7,
            color: Color(0xFF7A8491),
          ),
        ),
      ],
    );
  }

  Widget buildAnnouncements() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Community announcements',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              TextButton(
                onPressed: showAllAnnouncements,
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ...announcements.map(
            (announcement) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: Icon(
                      announcement['icon'] as IconData,
                      size: 17,
                      color: const Color(0xFF596573),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement['title'].toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF18202A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          announcement['description']
                              .toString(),
                          style: const TextStyle(
                            fontSize: 8,
                            height: 1.4,
                            color: Color(0xFF7A8491),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          announcement['time'].toString(),
                          style: const TextStyle(
                            fontSize: 7,
                            color: Color(0xFF9AA3AE),
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

  Widget buildCollaborationTips() {
    final tips = [
      [
        'Start with a clear goal',
        'Define exactly what the collaboration should achieve.',
        Icons.flag_outlined,
      ],
      [
        'Invite the right people',
        'Look for members with matching skills or resources.',
        Icons.person_add_alt_outlined,
      ],
      [
        'Keep progress visible',
        'Update milestones so everyone knows what is happening.',
        Icons.timeline_outlined,
      ],
      [
        'Celebrate contributions',
        'Recognize members who consistently help the community.',
        Icons.emoji_events_outlined,
      ],
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Smart collaboration guide',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 15),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5FF),
                      borderRadius:
                          BorderRadius.circular(11),
                    ),
                    child: Icon(
                      tip[2] as IconData,
                      size: 18,
                      color: const Color(0xFF3867D6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip[0] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF18202A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          tip[1] as String,
                          style: const TextStyle(
                            fontSize: 8,
                            height: 1.4,
                            color: Color(0xFF7A8491),
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

  Widget buildMemberStats() {
    return Row(
      children: [
        Expanded(
          child: communityStat(
            'Active Today',
            '486',
            Icons.online_prediction_rounded,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: communityStat(
            'New This Week',
            '126',
            Icons.person_add_alt_outlined,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: communityStat(
            'Top Helpers',
            '38',
            Icons.star_outline_rounded,
          ),
        ),
      ],
    );
  }

  Widget buildMembersList() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Community members',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 14),
          ...members.map(buildMemberCard),
        ],
      ),
    );
  }

  Widget buildMemberCard(
    Map<String, dynamic> member,
  ) {
    return InkWell(
      onTap: () => showMemberDetails(member),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE1E8F3),
              child: Text(
                member['name'].toString()[0],
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF52677D),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'].toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    member['role'].toString(),
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${member['contributions']} contributions',
                    style: const TextStyle(
                      fontSize: 7,
                      color: Color(0xFF3867D6),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Color(0xFFB27600),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      member['rating'].toString(),
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  member['badge'].toString(),
                  style: const TextStyle(
                    fontSize: 7,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecognitionCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF0E2BD),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.workspace_premium_rounded,
            color: Color(0xFFB27600),
            size: 28,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Community recognition',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Recognize members who consistently make ResourceX more useful for everyone.',
                  style: TextStyle(
                    fontSize: 8,
                    height: 1.4,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChallenges() {
    final challenges = [
      [
        '100 Resources Reused',
        'Community goal',
        0.78,
        '78 / 100',
        Icons.recycling_outlined,
      ],
      [
        '1,000 People Helped',
        'Monthly challenge',
        0.64,
        '640 / 1,000',
        Icons.people_alt_outlined,
      ],
      [
        '500 Hours Saved',
        'Impact challenge',
        0.52,
        '260 / 500',
        Icons.schedule_outlined,
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community challenges',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Color(0xFF18202A),
          ),
        ),
        const SizedBox(height: 12),
        ...challenges.map(
          (challenge) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE5E9EF),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5FF),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Icon(
                    challenge[4] as IconData,
                    color: const Color(0xFF3867D6),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge[0] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        challenge[1] as String,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                      const SizedBox(height: 9),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: challenge[2] as double,
                          minHeight: 6,
                          backgroundColor:
                              const Color(0xFFECEFF3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  challenge[3] as String,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3867D6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCommunityImpact() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Community impact',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              impactMetric(
                '8,742',
                'Resources reused',
                Icons.autorenew_rounded,
              ),
              impactMetric(
                '4,286',
                'People supported',
                Icons.favorite_border_rounded,
              ),
              impactMetric(
                '12.6K',
                'Hours saved',
                Icons.schedule_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget impactMetric(
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFF23844D),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIdeas() {
    final ideas = [
      [
        'Create a shared study-material library',
        '12 votes',
        Icons.menu_book_outlined,
      ],
      [
        'Campus equipment lending circle',
        '9 votes',
        Icons.devices_outlined,
      ],
      [
        'Weekend community repair event',
        '7 votes',
        Icons.build_outlined,
      ],
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Community ideas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              TextButton(
                onPressed: showIdeaDialog,
                child: const Text(
                  'Suggest',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ...ideas.map(
            (idea) => Container(
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                children: [
                  Icon(
                    idea[2] as IconData,
                    size: 19,
                    color: const Color(0xFF3867D6),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      idea[0] as String,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF18202A),
                      ),
                    ),
                  ),
                  Text(
                    idea[1] as String,
                    style: const TextStyle(
                      fontSize: 7,
                      color: Color(0xFF7A8491),
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

  Widget buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 38,
            color: Color(0xFF9AA3AE),
          ),
          SizedBox(height: 10),
          Text(
            'No collaborations found',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Try another search or category.',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  void showCollaborationDetails(
    Map<String, dynamic> item,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F5FF),
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: const Color(0xFF3867D6),
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Text(
                          item['title'].toString(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF18202A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Text(
                    item['description'].toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.5,
                      color: Color(0xFF687382),
                    ),
                  ),
                  const SizedBox(height: 18),
                  detailRow(
                    'Category',
                    item['category'].toString(),
                  ),
                  detailRow(
                    'Location',
                    item['location'].toString(),
                  ),
                  detailRow(
                    'Members',
                    '${item['members']} participants',
                  ),
                  detailRow(
                    'Looking for',
                    '${item['needed']} more members',
                  ),
                  detailRow(
                    'Timeline',
                    item['time'].toString(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Collaboration saved.',
                                ),
                                behavior:
                                    SnackBarBehavior
                                        .floating,
                              ),
                            );
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            joinCollaboration(
                              item['title'].toString(),
                            );
                          },
                          child: const Text(
                            'Join',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget detailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF7A8491),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18202A),
            ),
          ),
        ],
      ),
    );
  }

  void showMemberDetails(
    Map<String, dynamic> member,
  ) {
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
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: const Color(0xFFE1E8F3),
                  child: Text(
                    member['name'].toString()[0],
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF52677D),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  member['name'].toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member['role'].toString(),
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 17),
                Row(
                  children: [
                    miniMemberStat(
                      '${member['contributions']}',
                      'Contributions',
                    ),
                    miniMemberStat(
                      member['rating'].toString(),
                      'Rating',
                    ),
                    miniMemberStat(
                      member['badge'].toString(),
                      'Recognition',
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            'Connection request sent to ${member['name']}.',
                          ),
                          behavior:
                              SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_add_alt_1_rounded,
                    ),
                    label: const Text(
                      'Connect',
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
  }

  Widget miniMemberStat(
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  void showFilters() {
    final filters = [
      'All',
      'Education',
      'Technology',
      'Sustainability',
      'Skills',
      'Community',
    ];

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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter collaborations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ...filters.map(
                  (filter) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      selectedFilter == filter
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selectedFilter == filter
                          ? const Color(0xFF3867D6)
                          : const Color(0xFF9AA3AE),
                    ),
                    title: Text(
                      filter,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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

  void showCreateOptions() {
    final options = [
      [
        'Create Collaboration',
        'Start a new community project.',
        Icons.groups_outlined,
      ],
      [
        'Create Challenge',
        'Set a goal for the community.',
        Icons.emoji_events_outlined,
      ],
      [
        'Share an Idea',
        'Suggest something ResourceX can improve.',
        Icons.lightbulb_outline_rounded,
      ],
      [
        'Post Announcement',
        'Share an important community update.',
        Icons.campaign_outlined,
      ],
    ];

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
              children: [
                const Text(
                  'Create something new',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ...options.map(
                  (option) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5FF),
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                      child: Icon(
                        option[2] as IconData,
                        color: const Color(0xFF3867D6),
                      ),
                    ),
                    title: Text(
                      option[0] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      option[1] as String,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF7A8491),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            '${option[0]} selected.',
                          ),
                          behavior:
                              SnackBarBehavior.floating,
                        ),
                      );
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

  void showIdeaDialog() {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Suggest a community idea',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'What should the community build next?',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.dispose();
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.dispose();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Your community idea has been submitted.',
                    ),
                    behavior:
                        SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void showNotifications() {
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Community notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.groups_rounded,
                    color: Color(0xFF3867D6),
                  ),
                  title: Text(
                    '3 new collaboration invites',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    'Check your collaboration requests.',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.emoji_events_outlined,
                    color: Color(0xFFB27600),
                  ),
                  title: Text(
                    'New community challenge',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    'A new sustainability goal is live.',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(sheetContext),
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

  void showAllAnnouncements() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'All community announcements are up to date.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void joinCollaboration(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'You joined "$title".',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> refreshCommunity() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Community data refreshed successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}