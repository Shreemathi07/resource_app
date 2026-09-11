import 'package:flutter/material.dart';

class ContributionCreditsScreen extends StatefulWidget {
  const ContributionCreditsScreen({super.key});

  @override
  State<ContributionCreditsScreen> createState() =>
      _ContributionCreditsScreenState();
}

class _ContributionCreditsScreenState
    extends State<ContributionCreditsScreen> {
  int selectedPeriod = 1;
  int selectedTab = 0;

  final List<Map<String, dynamic>> activities = [
    {
      'title': 'Shared Data Structures Books',
      'subtitle': '5 resources • Education',
      'credits': 45,
      'date': 'Today',
      'icon': Icons.menu_book_rounded,
      'type': 'earned',
    },
    {
      'title': 'Completed Resource Handover',
      'subtitle': 'Verified exchange',
      'credits': 30,
      'date': 'Yesterday',
      'icon': Icons.handshake_outlined,
      'type': 'earned',
    },
    {
      'title': 'Helped a Nearby Seeker',
      'subtitle': 'Academic supplies',
      'credits': 20,
      'date': 'Sep 4',
      'icon': Icons.people_alt_outlined,
      'type': 'earned',
    },
    {
      'title': 'Community Challenge',
      'subtitle': 'Sustainable sharing goal',
      'credits': 50,
      'date': 'Sep 2',
      'icon': Icons.emoji_events_outlined,
      'type': 'earned',
    },
    {
      'title': 'Resource Reservation',
      'subtitle': 'Study equipment',
      'credits': 15,
      'date': 'Aug 30',
      'icon': Icons.bookmark_outline_rounded,
      'type': 'used',
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
          'Contribution Credits',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showCreditInfo,
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          IconButton(
            onPressed: refreshCredits,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshCredits,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          children: [
            buildCreditHero(),
            const SizedBox(height: 18),
            buildPeriodSelector(),
            const SizedBox(height: 18),
            buildTabSelector(),
            const SizedBox(height: 18),
            if (selectedTab == 0) ...[
              buildContributionOverview(),
              const SizedBox(height: 18),
              buildGoals(),
              const SizedBox(height: 18),
              buildActivityList(),
              const SizedBox(height: 18),
              buildSmartSuggestion(),
            ] else if (selectedTab == 1) ...[
              buildCreditBreakdown(),
              const SizedBox(height: 18),
              buildLevelProgress(),
              const SizedBox(height: 18),
              buildRecognition(),
            ] else if (selectedTab == 2) ...[
              buildAchievements(),
              const SizedBox(height: 18),
              buildMilestones(),
              const SizedBox(height: 18),
              buildCommunityRanking(),
            ] else ...[
              buildImpactSummary(),
              const SizedBox(height: 18),
              buildContributionInsights(),
              const SizedBox(height: 18),
              buildMonthlyTrend(),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showContributionActions,
        backgroundColor: const Color(0xFF18202A),
        icon: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        label: const Text(
          'Contribute',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget buildCreditHero() {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF18202A),
            Color(0xFF43556A),
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
                  Icons.stars_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'ResourceX Contribution Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '1,280',
            style: TextStyle(
              color: Colors.white,
              fontSize: 39,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Contribution Credits',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              creditMiniStat(
                'Earned',
                '+145',
                Icons.trending_up_rounded,
              ),
              const SizedBox(width: 18),
              creditMiniStat(
                'Used',
                '-15',
                Icons.swap_horiz_rounded,
              ),
              const SizedBox(width: 18),
              creditMiniStat(
                'Level',
                'Gold',
                Icons.workspace_premium_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget creditMiniStat(
    String title,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.white70,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPeriodSelector() {
    final periods = [
      '7 Days',
      '30 Days',
      '3 Months',
      '1 Year',
    ];

    return Row(
      children: List.generate(
        periods.length,
        (index) {
          final selected = selectedPeriod == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: index == periods.length - 1 ? 0 : 7,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF18202A)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF18202A)
                        : const Color(0xFFE4E8ED),
                  ),
                ),
                child: Text(
                  periods[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: selected
                        ? Colors.white
                        : const Color(0xFF697482),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTabSelector() {
    final tabs = [
      'Overview',
      'Wallet',
      'Achievements',
      'Insights',
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
                  duration: const Duration(milliseconds: 170),
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

  Widget buildContributionOverview() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: statCard(
                'Resources Shared',
                '38',
                '+12%',
                Icons.volunteer_activism_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: statCard(
                'People Helped',
                '64',
                '+18%',
                Icons.people_outline_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: statCard(
                'Hours Saved',
                '126',
                '+21%',
                Icons.schedule_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: statCard(
                'Trust Score',
                '94',
                '+4',
                Icons.verified_user_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget statCard(
    String title,
    String value,
    String growth,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 19,
                color: const Color(0xFF3867D6),
              ),
              const Spacer(),
              Text(
                growth,
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF23844D),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGoals() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Contribution goals',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              TextButton(
                onPressed: showAllGoals,
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
          const SizedBox(height: 6),
          goalItem(
            'Share 5 resources this month',
            '4 of 5 completed',
            0.80,
            Icons.inventory_2_outlined,
          ),
          goalItem(
            'Help 10 community members',
            '7 of 10 completed',
            0.70,
            Icons.people_alt_outlined,
          ),
          goalItem(
            'Earn 200 credits',
            '145 of 200 credits',
            0.725,
            Icons.stars_outlined,
          ),
        ],
      ),
    );
  }

  Widget goalItem(
    String title,
    String subtitle,
    double progress,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
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
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor:
                        const Color(0xFFECEFF3),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(progress * 100).round()}%',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: Color(0xFF3867D6),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActivityList() {
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
            'Credit activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 14),
          ...activities.map(
            (activity) => activityTile(activity),
          ),
        ],
      ),
    );
  }

  Widget activityTile(
    Map<String, dynamic> activity,
  ) {
    final earned = activity['type'] == 'earned';

    return InkWell(
      onTap: () => showActivityDetails(activity),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: earned
                    ? const Color(0xFFE8F8EF)
                    : const Color(0xFFFFF0F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                activity['icon'] as IconData,
                size: 19,
                color: earned
                    ? const Color(0xFF23844D)
                    : const Color(0xFFC74B50),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['title'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity['subtitle'].toString(),
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                Text(
                  '${earned ? '+' : '-'}${activity['credits']}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: earned
                        ? const Color(0xFF23844D)
                        : const Color(0xFFC74B50),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity['date'].toString(),
                  style: const TextStyle(
                    fontSize: 7,
                    color: Color(0xFF9AA3AE),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSmartSuggestion() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF0F5FF),
            Color(0xFFF8FAFF),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDCE7FF),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Color(0xFF3867D6),
              size: 21,
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart contribution suggestion',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'You are close to your monthly goal. Sharing one more useful resource could unlock the Community Helper badge.',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'Explore nearby needs →',
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

  Widget buildCreditBreakdown() {
    return Column(
      children: [
        walletCategory(
          'Resource Sharing',
          '38 contributions',
          620,
          0.78,
          Icons.inventory_2_outlined,
        ),
        walletCategory(
          'Verified Exchanges',
          '18 completed',
          320,
          0.52,
          Icons.handshake_outlined,
        ),
        walletCategory(
          'Community Support',
          '27 members helped',
          210,
          0.35,
          Icons.people_alt_outlined,
        ),
        walletCategory(
          'Challenges',
          '6 challenges',
          130,
          0.22,
          Icons.emoji_events_outlined,
        ),
      ],
    );
  }

  Widget walletCategory(
    String title,
    String subtitle,
    int credits,
    double progress,
    IconData icon,
  ) {
    return Container(
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF3867D6),
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor:
                        const Color(0xFFECEFF3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$credits',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLevelProgress() {
    return Container(
      padding: const EdgeInsets.all(19),
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
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3DD),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Color(0xFFB27600),
                  size: 24,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gold Contributor',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF18202A),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '1,280 / 1,500 credits',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF7A8491),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '85%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFB27600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.853,
              minHeight: 9,
              backgroundColor: Color(0xFFECEFF3),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '220 more credits to reach Platinum Contributor.',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF687382),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecognition() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF0E2BD),
        ),
      ),
      child:  Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Community recognition',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Your contributions place you in the top 8% of active ResourceX contributors this month.',
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              color: Color(0xFF687382),
            ),
          ),
          SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: recognitionItem(
                  'Top 10%',
                  Icons.leaderboard_outlined,
                ),
              ),
              Expanded(
                child: recognitionItem(
                  'Trusted',
                  Icons.verified_user_outlined,
                ),
              ),
              Expanded(
                child: recognitionItem(
                  'Active',
                  Icons.bolt_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAchievements() {
    final badges = [
      [
        'First Contribution',
        'Shared your first resource',
        Icons.flag_outlined,
        true,
      ],
      [
        'Community Helper',
        'Helped 25 members',
        Icons.people_alt_outlined,
        true,
      ],
      [
        'Reliable Partner',
        '20 successful exchanges',
        Icons.handshake_outlined,
        true,
      ],
      [
        'Resource Champion',
        'Shared 50 resources',
        Icons.inventory_2_outlined,
        false,
      ],
      [
        'Sustainability Star',
        'Reduce resource waste',
        Icons.eco_outlined,
        false,
      ],
      [
        'Platinum Contributor',
        'Reach 1,500 credits',
        Icons.workspace_premium_outlined,
        false,
      ],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: badges.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        final badge = badges[index];
        final unlocked = badge[3] as bool;

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: unlocked
                ? Colors.white
                : const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: unlocked
                  ? const Color(0xFFE5E9EF)
                  : const Color(0xFFECEFF3),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    badge[2] as IconData,
                    size: 24,
                    color: unlocked
                        ? const Color(0xFFB27600)
                        : const Color(0xFFB8BEC6),
                  ),
                  const Spacer(),
                  if (unlocked)
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: Color(0xFF23844D),
                    )
                  else
                    const Icon(
                      Icons.lock_outline_rounded,
                      size: 15,
                      color: Color(0xFFB8BEC6),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                badge[0] as String,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: unlocked
                      ? const Color(0xFF18202A)
                      : const Color(0xFF89929D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                badge[1] as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF7A8491),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMilestones() {
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
            'Contribution milestones',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 16),
          milestone(
            '100 Credits',
            'Completed',
            true,
          ),
          milestone(
            '500 Credits',
            'Completed',
            true,
          ),
          milestone(
            '1,000 Credits',
            'Completed',
            true,
          ),
          milestone(
            '1,500 Credits',
            '220 credits remaining',
            false,
          ),
          milestone(
            '2,500 Credits',
            'Future milestone',
            false,
          ),
        ],
      ),
    );
  }

  Widget milestone(
    String title,
    String subtitle,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: completed
                ? const Color(0xFF23844D)
                : const Color(0xFFB8BEC6),
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
          if (completed)
            const Text(
              'DONE',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: Color(0xFF23844D),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildCommunityRanking() {
    final members = [
      ['1', 'Ananya R.', '2,940', 'Platinum'],
      ['2', 'Vikram S.', '2,410', 'Platinum'],
      ['3', 'You', '1,280', 'Gold'],
      ['4', 'Priya M.', '1,170', 'Gold'],
      ['5', 'Arjun K.', '1,030', 'Gold'],
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
            'Community contribution ranking',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Based on verified contribution activity.',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF7A8491),
            ),
          ),
          const SizedBox(height: 15),
          ...members.map(
            (member) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: member[1] == 'You'
                    ? const Color(0xFFF0F5FF)
                    : const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    child: Text(
                      member[0],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF7A8491),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFFE4EAF2),
                    child: Text(
                      member[1][0],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF596573),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          member[1],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF18202A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          member[3],
                          style: const TextStyle(
                            fontSize: 7,
                            color: Color(0xFF7A8491),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    member[2],
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF18202A),
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

  Widget buildImpactSummary() {
    return Row(
      children: [
        Expanded(
          child: impactCard(
            'Waste Avoided',
            '42 kg',
            Icons.recycling_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: impactCard(
            'Resources Reused',
            '38',
            Icons.autorenew_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: impactCard(
            'Community Value',
            '94',
            Icons.favorite_border_rounded,
          ),
        ),
      ],
    );
  }

  Widget impactCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      height: 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFF23844D),
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
          const SizedBox(height: 3),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContributionInsights() {
    final insights = [
      [
        'Education is your strongest category',
        '62% of your contribution activity comes from educational resources.',
        Icons.school_outlined,
      ],
      [
        'Your reliability is improving',
        'Verified exchanges have increased consistently over the last 3 months.',
        Icons.trending_up_rounded,
      ],
      [
        'You are helping locally',
        'Most successful matches happened within 5 km of your location.',
        Icons.location_on_outlined,
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
            'Contribution intelligence',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 14),
          ...insights.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5FF),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: Icon(
                      item[2] as IconData,
                      size: 17,
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
                          item[0] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF18202A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item[1] as String,
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

  Widget buildMonthlyTrend() {
    final values = [42, 58, 46, 72, 64, 88, 96, 82];

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
            'Contribution activity trend',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Verified contribution activity over recent periods.',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF7A8491),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: values.map(
                (value) {
                  final height = value * 1.25;

                  return Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        children: [
                          Text(
                            '$value',
                            style: const TextStyle(
                              fontSize: 7,
                              fontWeight:
                                  FontWeight.w800,
                              color: Color(0xFF7A8491),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: height,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3867D6),
                              borderRadius:
                                  const BorderRadius.vertical(
                                top: Radius.circular(7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            'W${values.indexOf(value) + 1}',
                            style: const TextStyle(
                              fontSize: 7,
                              color: Color(0xFF9AA3AE),
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
    );
  }

  Widget recognitionItem(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: const Color(0xFFB27600),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: Color(0xFF596573),
            ),
          ),
        ),
      ],
    );
  }

  void showActivityDetails(
    Map<String, dynamic> activity,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F8EF),
                        borderRadius:
                            BorderRadius.circular(13),
                      ),
                      child: Icon(
                        activity['icon'] as IconData,
                        color: const Color(0xFF23844D),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Text(
                        activity['title'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF18202A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                detailLine(
                  'Activity',
                  activity['subtitle'].toString(),
                ),
                detailLine(
                  'Credits',
                  '+${activity['credits']}',
                ),
                detailLine(
                  'Date',
                  activity['date'].toString(),
                ),
                detailLine(
                  'Status',
                  'Verified',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(sheetContext),
                    child: const Text(
                      'Done',
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

  Widget detailLine(
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
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18202A),
            ),
          ),
        ],
      ),
    );
  }

  void showAllGoals() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Showing all active contribution goals.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showContributionActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        final actions = [
          [
            'Share a Resource',
            Icons.inventory_2_outlined,
          ],
          [
            'Help a Community Member',
            Icons.people_alt_outlined,
          ],
          [
            'Join a Challenge',
            Icons.emoji_events_outlined,
          ],
          [
            'Explore Nearby Needs',
            Icons.location_searching_outlined,
          ],
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Increase your contribution',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 14),
                ...actions.map(
                  (action) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5FF),
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                      child: Icon(
                        action[1] as IconData,
                        color: const Color(0xFF3867D6),
                      ),
                    ),
                    title: Text(
                      action[0] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
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
                            '${action[0]} selected.',
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

  void showCreditInfo() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.stars_rounded,
            color: Color(0xFFB27600),
            size: 42,
          ),
          title: const Text(
            'How Contribution Credits Work',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'ResourceX credits represent verified community contribution. They are designed to recognize helpful activity such as sharing resources, completing exchanges and supporting community members.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              color: Color(0xFF687382),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshCredits() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Contribution data refreshed successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}