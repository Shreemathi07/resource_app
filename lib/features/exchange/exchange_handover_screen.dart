import 'dart:math' as math;

import 'package:flutter/material.dart';

class ExchangeHandoverScreen extends StatefulWidget {
  const ExchangeHandoverScreen({super.key});

  @override
  State<ExchangeHandoverScreen> createState() =>
      _ExchangeHandoverScreenState();
}

class _ExchangeHandoverScreenState
    extends State<ExchangeHandoverScreen> {
  int selectedExchange = 0;
  int selectedTab = 0;
  bool identityVerified = true;
  bool resourceChecked = false;
  bool conditionConfirmed = false;
  bool handoverConfirmed = false;

  final List<Map<String, dynamic>> exchanges = [
    {
      'title': 'Data Structures Textbooks',
      'code': 'RX-48291',
      'provider': 'Aarav Kumar',
      'seeker': 'You',
      'location': 'VIT Library Entrance',
      'time': 'Today • 4:30 PM',
      'quantity': '5 books',
      'condition': 'Good',
      'category': 'Education',
    },
    {
      'title': 'Laptop Stand + Keyboard',
      'code': 'RX-73924',
      'provider': 'Rahul Dev',
      'seeker': 'You',
      'location': 'Technology Tower Lobby',
      'time': 'Tomorrow • 11:00 AM',
      'quantity': '2 items',
      'condition': 'Excellent',
      'category': 'Electronics',
    },
    {
      'title': 'Arduino Starter Kit',
      'code': 'RX-19563',
      'provider': 'VIT Innovation Club',
      'seeker': 'You',
      'location': 'Innovation Lab',
      'time': 'Sep 9 • 2:00 PM',
      'quantity': '1 kit',
      'condition': 'Good',
      'category': 'Technology',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final exchange = exchanges[selectedExchange];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Handover Verification',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showSecurityInfo,
            icon: const Icon(
              Icons.shield_outlined,
              color: Color(0xFF18202A),
            ),
          ),
          IconButton(
            onPressed: refreshVerification,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshVerification,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          children: [
            buildHero(exchange),
            const SizedBox(height: 18),
            buildExchangeSelector(),
            const SizedBox(height: 20),
            buildTabSelector(),
            const SizedBox(height: 18),
            if (selectedTab == 0) ...[
              buildVerificationStatus(),
              const SizedBox(height: 18),
              buildQrVerification(exchange),
              const SizedBox(height: 18),
              buildIdentityCard(exchange),
              const SizedBox(height: 18),
              buildChecklist(),
              const SizedBox(height: 18),
              buildDigitalReceipt(exchange),
            ] else if (selectedTab == 1) ...[
              buildChecklist(),
              const SizedBox(height: 18),
              buildConditionCard(exchange),
              const SizedBox(height: 18),
              buildResourceDetails(exchange),
            ] else if (selectedTab == 2) ...[
              buildHandoverTimeline(),
              const SizedBox(height: 18),
              buildSecurityCard(),
              const SizedBox(height: 18),
              buildTrustUpdate(),
            ] else ...[
              buildReceiptPreview(exchange),
              const SizedBox(height: 18),
              buildTrustUpdate(),
              const SizedBox(height: 18),
              buildSupportCard(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: buildBottomAction(exchange),
    );
  }

  Widget buildHero(Map<String, dynamic> exchange) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF18202A),
            Color(0xFF405268),
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
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Smart Handover Center',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFB8F2D0).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: Color(0xFFB8F2D0),
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'SECURE',
                      style: TextStyle(
                        color: Color(0xFFB8F2D0),
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            exchange['title'].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Exchange ID • ${exchange['code']}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              heroMetric(
                Icons.inventory_2_outlined,
                exchange['quantity'].toString(),
              ),
              const SizedBox(width: 18),
              heroMetric(
                Icons.event_outlined,
                exchange['time'].toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget heroMetric(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 18,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExchangeSelector() {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: exchanges.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final exchange = exchanges[index];
          final selected = selectedExchange == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedExchange = index;
                resourceChecked = false;
                conditionConfirmed = false;
                handoverConfirmed = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 225,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFF0F5FF)
                    : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF3867D6)
                      : const Color(0xFFE5E9EF),
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.swap_horizontal_circle_outlined,
                        size: 18,
                        color: selected
                            ? const Color(0xFF3867D6)
                            : const Color(0xFF7A8491),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          exchange['title'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF18202A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        size: 13,
                        color: Color(0xFF23844D),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        exchange['code'].toString(),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF7A8491),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTabSelector() {
    final tabs = [
      'Verify',
      'Resource',
      'Timeline',
      'Receipt',
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
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 5,
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
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

  Widget buildVerificationStatus() {
    final completed = [
      identityVerified,
      resourceChecked,
      conditionConfirmed,
      handoverConfirmed,
    ].where((value) => value).length;

    final progress = completed / 4;

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
                  'Verification status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              Text(
                '$completed/4',
                style: const TextStyle(
                  color: Color(0xFF3867D6),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFECEFF3),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            completed == 4
                ? 'All verification steps are complete.'
                : 'Complete the remaining checks before confirming the handover.',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF7A8491),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQrVerification(
    Map<String, dynamic> exchange,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Exchange verification code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF23844D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            'Both participants can scan or verify this exchange code at handover.',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 10,
              height: 1.4,
              color: Color(0xFF7A8491),
            ),
          ),
          const SizedBox(height: 17),
          Container(
            width: 190,
            height: 190,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFE0E5EB),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                ),
              ],
            ),
            child: CustomPaint(
              painter: ExchangeQrPainter(
                seed: exchange['code'].toString(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            exchange['code'].toString(),
            style: const TextStyle(
              letterSpacing: 2,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Verification code expires after handover',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF9AA3AE),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: scanExchangeCode,
                  icon: const Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 17,
                  ),
                  label: const Text(
                    'Scan Code',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: showCode,
                  icon: const Icon(
                    Icons.key_outlined,
                    size: 17,
                  ),
                  label: const Text(
                    'Show Code',
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
    );
  }

  Widget buildIdentityCard(
    Map<String, dynamic> exchange,
  ) {
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
                  'Participant verification',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              Icon(
                identityVerified
                    ? Icons.verified_rounded
                    : Icons.warning_amber_rounded,
                color: identityVerified
                    ? const Color(0xFF23844D)
                    : const Color(0xFFB27600),
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFE8F0FF),
                child: Text(
                  exchange['provider']
                      .toString()
                      .substring(0, 1),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3867D6),
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      exchange['provider'].toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF18202A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Resource Provider',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF7A8491),
                      ),
                    ),
                  ],
                ),
              ),
              if (identityVerified)
                const Text(
                  'Verified',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF23844D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 13),
          verificationSignal(
            Icons.badge_outlined,
            'Profile identity matched',
          ),
          verificationSignal(
            Icons.location_on_outlined,
            'Handover location matched',
          ),
          verificationSignal(
            Icons.swap_horizontal_circle_outlined,
            'Exchange ID matched',
          ),
        ],
      ),
    );
  }

  Widget verificationSignal(
    IconData icon,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF23844D),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF596573),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            size: 15,
            color: Color(0xFF23844D),
          ),
        ],
      ),
    );
  }

  Widget buildChecklist() {
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
          const Text(
            'Handover checklist',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Confirm each item before completing the exchange.',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF7A8491),
            ),
          ),
          const SizedBox(height: 15),
          checklistTile(
            'Participant identity verified',
            'Profile and exchange details match',
            identityVerified,
            false,
            () {
              setState(() {
                identityVerified = !identityVerified;
              });
            },
          ),
          checklistTile(
            'Resource received',
            'Quantity and requested resource are present',
            resourceChecked,
            true,
            () {
              setState(() {
                resourceChecked = !resourceChecked;
              });
            },
          ),
          checklistTile(
            'Resource condition confirmed',
            'Condition matches the exchange description',
            conditionConfirmed,
            true,
            () {
              setState(() {
                conditionConfirmed = !conditionConfirmed;
              });
            },
          ),
          checklistTile(
            'Handover completed',
            'Both participants agree the exchange is complete',
            handoverConfirmed,
            true,
            () {
              setState(() {
                handoverConfirmed = !handoverConfirmed;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget checklistTile(
    String title,
    String subtitle,
    bool checked,
    bool editable,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: editable ? onTap : null,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: checked
              ? const Color(0xFFF1FAF5)
              : const Color(0xFFF8F9FB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: checked
                ? const Color(0xFFD2EEDC)
                : const Color(0xFFE7EBEF),
          ),
        ),
        child: Row(
          children: [
            Icon(
              checked
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: checked
                  ? const Color(0xFF23844D)
                  : const Color(0xFF9AA3AE),
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
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: checked
                          ? const Color(0xFF18202A)
                          : const Color(0xFF596573),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                ],
              ),
            ),
            if (!editable)
              const Icon(
                Icons.lock_outline_rounded,
                size: 15,
                color: Color(0xFF9AA3AE),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildConditionCard(
    Map<String, dynamic> exchange,
  ) {
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
          const Text(
            'Condition verification',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Color(0xFF3867D6),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        exchange['title'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Expected condition: ${exchange['condition']}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF23844D),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Visual condition check',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF596573),
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              conditionChip('As described', true),
              const SizedBox(width: 7),
              conditionChip('Better', false),
              const SizedBox(width: 7),
              conditionChip('Needs review', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget conditionChip(
    String title,
    bool selected,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 9,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE8F8EF)
              : const Color(0xFFF6F8FB),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: selected
                ? const Color(0xFFCBE9D7)
                : const Color(0xFFE5E9EF),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w800,
            color: selected
                ? const Color(0xFF23844D)
                : const Color(0xFF7A8491),
          ),
        ),
      ),
    );
  }

  Widget buildResourceDetails(
    Map<String, dynamic> exchange,
  ) {
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
            'Resource details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 14),
          detailRow(
            Icons.category_outlined,
            'Category',
            exchange['category'].toString(),
          ),
          detailRow(
            Icons.inventory_2_outlined,
            'Quantity',
            exchange['quantity'].toString(),
          ),
          detailRow(
            Icons.star_border_rounded,
            'Condition',
            exchange['condition'].toString(),
          ),
          detailRow(
            Icons.location_on_outlined,
            'Location',
            exchange['location'].toString(),
          ),
          detailRow(
            Icons.confirmation_number_outlined,
            'Exchange ID',
            exchange['code'].toString(),
          ),
        ],
      ),
    );
  }

  Widget detailRow(
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
            color: const Color(0xFF3867D6),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF7A8491),
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF18202A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDigitalReceipt(
    Map<String, dynamic> exchange,
  ) {
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
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF3867D6),
              size: 24,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Digital receipt ready',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Receipt will be generated for ${exchange['code']}.',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: showReceipt,
            icon: const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF3867D6),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHandoverTimeline() {
    final events = [
      [
        'Exchange created',
        'Today • 9:15 AM',
        Icons.add_task_rounded,
        true,
      ],
      [
        'Provider confirmed',
        'Today • 9:32 AM',
        Icons.verified_outlined,
        true,
      ],
      [
        'Location confirmed',
        'Today • 10:05 AM',
        Icons.location_on_outlined,
        true,
      ],
      [
        'Participant arrived',
        'Today • 4:22 PM',
        Icons.directions_walk_rounded,
        true,
      ],
      [
        'Handover confirmation',
        'Waiting for completion',
        Icons.swap_horizontal_circle_outlined,
        false,
      ],
      [
        'Digital receipt issued',
        'Waiting for completion',
        Icons.receipt_long_outlined,
        false,
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
            'Handover timeline',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 17),
          ...List.generate(
            events.length,
            (index) {
              final event = events[index];
              return timelineItem(
                event[0] as String,
                event[1] as String,
                event[2] as IconData,
                event[3] as bool,
                index != events.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget timelineItem(
    String title,
    String subtitle,
    IconData icon,
    bool completed,
    bool line,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: completed
                      ? const Color(0xFFE8F8EF)
                      : const Color(0xFFF0F3F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: completed
                      ? const Color(0xFF23844D)
                      : const Color(0xFF9AA3AE),
                ),
              ),
              if (line)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(
                      vertical: 3,
                    ),
                    color: completed
                        ? const Color(0xFFD5EBDC)
                        : const Color(0xFFE5E9EF),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 14,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: completed
                          ? const Color(0xFF18202A)
                          : const Color(0xFF7A8491),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9,
                      color: completed
                          ? const Color(0xFF23844D)
                          : const Color(0xFF9AA3AE),
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

  Widget buildSecurityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FAF5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD5EBDC),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.security_rounded,
                color: Color(0xFF23844D),
                size: 23,
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Secure exchange protection',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Text(
                '98%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF23844D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          securityRow(
            'Participant verification',
            'Passed',
          ),
          securityRow(
            'Exchange code protection',
            'Active',
          ),
          securityRow(
            'Location verification',
            'Passed',
          ),
          securityRow(
            'Receipt integrity',
            'Ready',
          ),
        ],
      ),
    );
  }

  Widget securityRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 16,
            color: Color(0xFF23844D),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF596573),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Color(0xFF23844D),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrustUpdate() {
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
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3DD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Color(0xFFB27600),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Trust score update',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Text(
                '+4',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF23844D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Text(
            'A successful verified handover can improve your ResourceX reliability score.',
            style: TextStyle(
              fontSize: 10,
              height: 1.45,
              color: Color(0xFF687382),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              trustPoint('Verified exchange'),
              trustPoint('On-time handover'),
              trustPoint('Condition confirmed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget trustPoint(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: Color(0xFF596573),
          ),
        ),
      ),
    );
  }

  Widget buildReceiptPreview(
    Map<String, dynamic> exchange,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                  'Digital exchange receipt',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Icon(
                Icons.verified_rounded,
                color: Color(0xFF23844D),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                receiptRow(
                  'Exchange ID',
                  exchange['code'].toString(),
                ),
                receiptRow(
                  'Resource',
                  exchange['title'].toString(),
                ),
                receiptRow(
                  'Quantity',
                  exchange['quantity'].toString(),
                ),
                receiptRow(
                  'Provider',
                  exchange['provider'].toString(),
                ),
                receiptRow(
                  'Location',
                  exchange['location'].toString(),
                ),
                receiptRow(
                  'Status',
                  handoverConfirmed
                      ? 'Completed'
                      : 'Pending handover',
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: showReceipt,
                  icon: const Icon(
                    Icons.visibility_outlined,
                    size: 17,
                  ),
                  label: const Text(
                    'Preview',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: exportReceipt,
                  icon: const Icon(
                    Icons.ios_share_rounded,
                    size: 17,
                  ),
                  label: const Text(
                    'Export',
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
    );
  }

  Widget receiptRow(
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
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF18202A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupportCard() {
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
        children: [
          const Icon(
            Icons.support_agent_outlined,
            color: Color(0xFF3867D6),
            size: 25,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Need help with this exchange?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ResourceX support can review verification or dispute issues.',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: contactSupport,
            child: const Text(
              'Help',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomAction(
    Map<String, dynamic> exchange,
  ) {
    final canComplete =
        identityVerified &&
        resourceChecked &&
        conditionConfirmed;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: showReportIssue,
                icon: const Icon(
                  Icons.report_problem_outlined,
                  size: 18,
                ),
                label: const Text(
                  'Report',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: canComplete
                    ? confirmHandover
                    : showIncompleteChecklist,
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 18,
                ),
                label: Text(
                  handoverConfirmed
                      ? 'Handover Completed'
                      : 'Confirm Handover',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scanExchangeCode() {
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
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FF),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Color(0xFF3867D6),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'QR scanner ready',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'In the connected version, this area will open the device camera for exchange verification.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.5,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    showCodeVerified();
                  },
                  child: const Text(
                    'Simulate Successful Scan',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
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

  void showCode() {
    final exchange = exchanges[selectedExchange];

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Exchange Code',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.key_rounded,
                size: 42,
                color: Color(0xFF3867D6),
              ),
              const SizedBox(height: 14),
              Text(
                exchange['code'].toString(),
                style: const TextStyle(
                  fontSize: 23,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ask the other participant to verify this code before handover.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF7A8491),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showCodeVerified() {
    setState(() {
      identityVerified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Exchange code verified successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void confirmHandover() {
    setState(() {
      handoverConfirmed = true;
    });

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.verified_rounded,
            size: 46,
            color: Color(0xFF23844D),
          ),
          title: const Text(
            'Handover Confirmed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'The exchange has been marked as successfully completed. A digital receipt is now available.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showIncompleteChecklist() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Complete resource and condition checks before confirming.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showReceipt() {
    final exchange = exchanges[selectedExchange];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                const Icon(
                  Icons.receipt_long_rounded,
                  size: 38,
                  color: Color(0xFF3867D6),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ResourceX Digital Receipt',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 15),
                receiptRow(
                  'Exchange',
                  exchange['code'].toString(),
                ),
                receiptRow(
                  'Resource',
                  exchange['title'].toString(),
                ),
                receiptRow(
                  'Provider',
                  exchange['provider'].toString(),
                ),
                receiptRow(
                  'Quantity',
                  exchange['quantity'].toString(),
                ),
                receiptRow(
                  'Verification',
                  'Secure',
                ),
                receiptRow(
                  'Status',
                  handoverConfirmed
                      ? 'Completed'
                      : 'Pending',
                ),
                const SizedBox(height: 7),
                const Text(
                  'This receipt represents the ResourceX exchange record.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF9AA3AE),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(sheetContext),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
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

  void exportReceipt() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Digital receipt export prepared.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showReportIssue() {
    final reasons = [
      'Resource condition is different',
      'Wrong resource or quantity',
      'Participant verification issue',
      'Handover location problem',
      'Other exchange issue',
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
                  'Report exchange issue',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Select the issue that needs review.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 12),
                ...reasons.map(
                  (reason) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.warning_amber_outlined,
                      color: Color(0xFFB27600),
                    ),
                    title: Text(
                      reason,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Issue reported to ResourceX support.',
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

  void showSecurityInfo() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.shield_rounded,
            color: Color(0xFF23844D),
            size: 42,
          ),
          title: const Text(
            'Secure Handover',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'ResourceX uses participant verification, exchange IDs, handover checks and digital receipts to create a trusted exchange record.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  void contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Opening ResourceX exchange support.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> refreshVerification() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Handover verification status updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class ExchangeQrPainter extends CustomPainter {
  final String seed;

  ExchangeQrPainter({
    required this.seed,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final random = math.Random(seed.hashCode);

    final paint = Paint()
      ..color = const Color(0xFF18202A)
      ..style = PaintingStyle.fill;

    const cells = 21;
    final cellSize = size.width / cells;

    final matrix = List.generate(
      cells,
      (_) => List.generate(
        cells,
        (_) => random.nextBool(),
      ),
    );

    drawFinder(
      canvas,
      matrix,
      0,
      0,
    );

    drawFinder(
      canvas,
      matrix,
      cells - 7,
      0,
    );

    drawFinder(
      canvas,
      matrix,
      0,
      cells - 7,
    );

    for (int row = 0; row < cells; row++) {
      for (int column = 0; column < cells; column++) {
        if (isFinderArea(row, column, cells)) {
          continue;
        }

        if (matrix[row][column]) {
          canvas.drawRect(
            Rect.fromLTWH(
              column * cellSize,
              row * cellSize,
              cellSize,
              cellSize,
            ),
            paint,
          );
        }
      }
    }
  }

  bool isFinderArea(
    int row,
    int column,
    int cells,
  ) {
    final topLeft =
        row < 7 && column < 7;
    final topRight =
        row < 7 && column >= cells - 7;
    final bottomLeft =
        row >= cells - 7 && column < 7;

    return topLeft || topRight || bottomLeft;
  }

  void drawFinder(
    Canvas canvas,
    List<List<bool>> matrix,
    int startRow,
    int startColumn,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF18202A)
      ..style = PaintingStyle.fill;

    final size = 21.0 / 21.0;

    for (int row = 0; row < 7; row++) {
      for (int column = 0; column < 7; column++) {
        final outer =
            row == 0 ||
            row == 6 ||
            column == 0 ||
            column == 6;

        final inner =
            row >= 2 &&
            row <= 4 &&
            column >= 2 &&
            column <= 4;

        if (outer || inner) {
          final cellWidth = 1 / size;
          final cell = cellWidth;

          canvas.drawRect(
            Rect.fromLTWH(
              (startColumn + column) * cell,
              (startRow + row) * cell,
              cell,
              cell,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant ExchangeQrPainter oldDelegate,
  ) {
    return oldDelegate.seed != seed;
  }
}