import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _selectedSection = 0;

  final List<String> _sections = [
    'Overview',
    'Verification',
    'Reliability',
    'Badges',
  ];

  final List<_VerificationItem> _verificationItems = [
    _VerificationItem(
      icon: Icons.person_outline_rounded,
      title: 'Profile verification',
      subtitle: 'Your basic profile information',
      status: 'Verified',
      verified: true,
    ),
    _VerificationItem(
      icon: Icons.phone_outlined,
      title: 'Phone verification',
      subtitle: 'Verified mobile number',
      status: 'Verified',
      verified: true,
    ),
    _VerificationItem(
      icon: Icons.email_outlined,
      title: 'Email verification',
      subtitle: 'Verified email address',
      status: 'Verified',
      verified: true,
    ),
    _VerificationItem(
      icon: Icons.location_on_outlined,
      title: 'Location verification',
      subtitle: 'Confirm your operating location',
      status: 'Verified',
      verified: true,
    ),
    _VerificationItem(
      icon: Icons.badge_outlined,
      title: 'Identity verification',
      subtitle: 'Optional identity verification',
      status: 'Not completed',
      verified: false,
    ),
  ];

  final List<_BadgeItem> _badges = [
    _BadgeItem(
      icon: Icons.verified_rounded,
      title: 'Verified Member',
      subtitle: 'Completed profile verification',
      earned: true,
    ),
    _BadgeItem(
      icon: Icons.handshake_outlined,
      title: 'Reliable Partner',
      subtitle: 'Completed multiple exchanges',
      earned: true,
    ),
    _BadgeItem(
      icon: Icons.volunteer_activism_outlined,
      title: 'Community Contributor',
      subtitle: 'Shared resources with the community',
      earned: true,
    ),
    _BadgeItem(
      icon: Icons.bolt_outlined,
      title: 'Fast Responder',
      subtitle: 'Maintain a quick response rate',
      earned: false,
    ),
    _BadgeItem(
      icon: Icons.public_outlined,
      title: 'Impact Champion',
      subtitle: 'Reach 500 impact points',
      earned: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Trust Center',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: _showTrustInfo,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTrustHero(),
              const SizedBox(height: 20),
              _buildSectionSelector(),
              const SizedBox(height: 20),
              _buildSelectedSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF172554),
            Color(0xFF2563EB),
            Color(0xFF38BDF8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.20),
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
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Trusted',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Your Trust Score',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '92 / 100',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.92,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.18),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your strong verification and exchange history make ResourceX members more confident when connecting with you.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.45,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSelector() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _sections.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedSection == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedSection = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                color: selected ? Colors.blue.shade700 : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: selected
                      ? Colors.blue.shade700
                      : Colors.grey.shade200,
                ),
              ),
              child: Center(
                child: Text(
                  _sections[index],
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

  Widget _buildSelectedSection() {
    switch (_selectedSection) {
      case 1:
        return _buildVerificationSection();
      case 2:
        return _buildReliabilitySection();
      case 3:
        return _buildBadgesSection();
      default:
        return _buildOverviewSection();
    }
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Trust overview',
          'Everything that contributes to your ResourceX reputation.',
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                icon: Icons.verified_rounded,
                value: '4/5',
                label: 'Verified',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                icon: Icons.handshake_rounded,
                value: '28',
                label: 'Exchanges',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                icon: Icons.star_rounded,
                value: '4.9',
                label: 'Rating',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                icon: Icons.speed_rounded,
                value: '94%',
                label: 'Reliability',
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        _buildTrustFactors(),
        const SizedBox(height: 22),
        _buildImproveCard(),
      ],
    );
  }

  Widget _buildTrustFactors() {
    final factors = [
      ('Profile completeness', 0.95, '95%'),
      ('Verification', 0.80, '4 of 5'),
      ('Exchange reliability', 0.94, '94%'),
      ('Community feedback', 0.98, '4.9 / 5'),
    ];

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trust factors',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 18),
          ...factors.map(
            (factor) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          factor.$1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        factor.$3,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: factor.$2,
                      minHeight: 7,
                      backgroundColor: Colors.grey.shade100,
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

  Widget _buildImproveCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.amber.shade100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: Colors.amber.shade800,
            size: 28,
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Increase your trust score',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Complete identity verification to unlock a higher trust level.',
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
    );
  }

  Widget _buildVerificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Verification status',
          'Verified information helps members exchange resources with confidence.',
        ),
        const SizedBox(height: 14),
        ..._verificationItems.map(_buildVerificationTile),
        const SizedBox(height: 16),
        _buildSafetyCard(),
      ],
    );
  }

  Widget _buildVerificationTile(_VerificationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
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
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: item.verified
                  ? Colors.green.withValues(alpha: 0.10)
                  : Colors.orange.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item.icon,
              color: item.verified
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (item.verified)
            Icon(
              Icons.check_circle_rounded,
              color: Colors.green.shade600,
              size: 22,
            )
          else
            TextButton(
              onPressed: _startVerification,
              child: const Text(
                'Verify',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSafetyCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.security_rounded,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Safety first',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'ResourceX uses verification and community feedback to create safer and more reliable exchanges.',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: _showSafetyTips,
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('View safety tips'),
          ),
        ],
      ),
    );
  }

  Widget _buildReliabilitySection() {
    final stats = [
      ('Completed', '26', Icons.check_circle_outline_rounded),
      ('On time', '24', Icons.schedule_rounded),
      ('Cancelled', '2', Icons.cancel_outlined),
      ('Response', '94%', Icons.speed_rounded),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Exchange reliability',
          'Your past exchange behavior helps calculate trust.',
        ),
        const SizedBox(height: 14),
        _card(
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.handshake_rounded,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Excellent reliability',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'You consistently complete your exchanges.',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '94%',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.94,
                  minHeight: 9,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.55,
          ),
          itemBuilder: (context, index) {
            final stat = stats[index];

            return _metricCard(
              icon: stat.$3,
              value: stat.$2,
              label: stat.$1,
            );
          },
        ),
        const SizedBox(height: 18),
        _buildFeedbackCard(),
      ],
    );
  }

  Widget _buildFeedbackCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Community feedback',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                '4.9',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on 23 completed exchanges',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Your badges',
          'Build your reputation by contributing consistently.',
        ),
        const SizedBox(height: 14),
        ..._badges.map(_buildBadgeTile),
      ],
    );
  }

  Widget _buildBadgeTile(_BadgeItem badge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: badge.earned
              ? Colors.blue.shade100
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badge.earned
                  ? Colors.blue.withValues(alpha: 0.10)
                  : Colors.grey.shade100,
            ),
            child: Icon(
              badge.icon,
              color: badge.earned
                  ? Colors.blue.shade700
                  : Colors.grey.shade400,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  badge.subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          if (badge.earned)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Earned',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          else
            Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey.shade400,
              size: 20,
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
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _metricCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue.shade700,
            size: 23,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
      ),
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

  void _startVerification() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_user_outlined,
                    color: Colors.blue.shade700,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Identity Verification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Complete this optional verification to strengthen your ResourceX trust profile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                _verificationStep(
                  Icons.badge_outlined,
                  'Confirm your identity',
                ),
                _verificationStep(
                  Icons.security_outlined,
                  'Secure verification process',
                ),
                _verificationStep(
                  Icons.verified_outlined,
                  'Receive verification badge',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Verification flow will be connected to the backend later.',
                          ),
                        ),
                      );
                    },
                    child: const Text('Continue Verification'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _verificationStep(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue.shade700,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showTrustInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.shield_outlined),
              SizedBox(width: 10),
              Text('About Trust Score'),
            ],
          ),
          content: const Text(
            'Your ResourceX trust score represents a combination of profile verification, exchange reliability, community feedback, and responsible platform activity.',
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

  void _showSafetyTips() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final tips = [
          'Confirm resource details before accepting an exchange.',
          'Use ResourceX messaging for exchange coordination.',
          'Meet or exchange resources in appropriate locations.',
          'Report suspicious activity to the platform.',
          'Do not share unnecessary personal information.',
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Safe exchange tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                ...tips.map(
                  (tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.green.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            tip,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
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
}

class _VerificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final bool verified;

  const _VerificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.verified,
  });
}

class _BadgeItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool earned;

  const _BadgeItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.earned,
  });
}