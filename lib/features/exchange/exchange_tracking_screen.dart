import 'package:flutter/material.dart';

class ExchangeTrackingScreen extends StatefulWidget {
  const ExchangeTrackingScreen({super.key});

  @override
  State<ExchangeTrackingScreen> createState() =>
      _ExchangeTrackingScreenState();
}

class _ExchangeTrackingScreenState
    extends State<ExchangeTrackingScreen> {
  int selectedExchange = 0;

  final List<Map<String, dynamic>> exchanges = [
    {
      'title': 'Textbook Handover',
      'resource': 'Data Structures Textbooks',
      'participant': 'Aarav Kumar',
      'location': 'VIT Library Entrance',
      'eta': '8 min',
      'distance': '0.6 km',
      'status': 'On the way',
      'progress': 0.72,
    },
    {
      'title': 'Laptop Accessories',
      'resource': 'Laptop Stand + Keyboard',
      'participant': 'Rahul Dev',
      'location': 'Technology Tower Lobby',
      'eta': '24 min',
      'distance': '1.4 km',
      'status': 'Confirmed',
      'progress': 0.42,
    },
    {
      'title': 'Arduino Kit',
      'resource': 'Arduino Starter Kit',
      'participant': 'VIT Innovation Club',
      'location': 'Innovation Lab',
      'eta': 'Tomorrow',
      'distance': '2.1 km',
      'status': 'Scheduled',
      'progress': 0.18,
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
          'Exchange Tracking',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showTrackingNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          IconButton(
            onPressed: showTrackingOptions,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshTracking,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          children: [
            buildTrackingHero(exchange),
            const SizedBox(height: 18),
            buildExchangeSelector(),
            const SizedBox(height: 20),
            buildLiveStatus(exchange),
            const SizedBox(height: 20),
            buildProgressTimeline(exchange),
            const SizedBox(height: 20),
            buildLocationCard(exchange),
            const SizedBox(height: 20),
            buildParticipantCard(exchange),
            const SizedBox(height: 20),
            buildSmartDelayCard(),
            const SizedBox(height: 20),
            buildSafetyCard(),
            const SizedBox(height: 20),
            buildProofCard(),
            const SizedBox(height: 20),
            buildReliabilityCard(),
            const SizedBox(height: 20),
            buildQuickActions(exchange),
          ],
        ),
      ),
    );
  }

  Widget buildTrackingHero(
    Map<String, dynamic> exchange,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF18202A),
            Color(0xFF3D4E61),
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
                  Icons.local_shipping_outlined,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Live Exchange Tracking',
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
                  color: const Color(0xFFB8F2D0)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: Color(0xFFB8F2D0),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: Color(0xFFB8F2D0),
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 21),
          Text(
            exchange['title'].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            exchange['resource'].toString(),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              trackingMetric(
                Icons.access_time_rounded,
                exchange['eta'].toString(),
                'ETA',
              ),
              const SizedBox(width: 20),
              trackingMetric(
                Icons.straighten_rounded,
                exchange['distance'].toString(),
                'Distance',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget trackingMetric(
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildExchangeSelector() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: exchanges.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final exchange = exchanges[index];
          final selected = selectedExchange == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedExchange = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 220,
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
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.swap_horizontal_circle_outlined,
                        size: 19,
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
                            fontSize: 12,
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
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF23844D)
                              : const Color(0xFFB27600),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        exchange['status'].toString(),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF687382),
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

  Widget buildLiveStatus(
    Map<String, dynamic> exchange,
  ) {
    final progress =
        (exchange['progress'] as num).toDouble();

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
                  'Current status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              statusBadge(
                exchange['status'].toString(),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8EF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.directions_walk_rounded,
                  color: Color(0xFF23844D),
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
                      'Participant is heading to the location',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: Color(0xFF18202A),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Location signal updated 1 minute ago',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF7A8491),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor:
                        const Color(0xFFECEFF3),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF18202A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget statusBadge(String status) {
    Color background;
    Color foreground;

    if (status == 'On the way') {
      background = const Color(0xFFE8F8EF);
      foreground = const Color(0xFF23844D);
    } else if (status == 'Confirmed') {
      background = const Color(0xFFF0F5FF);
      foreground = const Color(0xFF3867D6);
    } else {
      background = const Color(0xFFFFF3DD);
      foreground = const Color(0xFFB27600);
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
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: foreground,
        ),
      ),
    );
  }

  Widget buildProgressTimeline(
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
            'Exchange journey',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 17),
          journeyStep(
            'Exchange scheduled',
            'Completed',
            Icons.event_available_rounded,
            true,
            true,
          ),
          journeyStep(
            'Participant confirmed',
            'Completed',
            Icons.verified_outlined,
            true,
            true,
          ),
          journeyStep(
            'Heading to handover',
            exchange['status'] == 'On the way'
                ? 'In progress'
                : 'Waiting',
            Icons.navigation_outlined,
            exchange['status'] == 'On the way',
            true,
          ),
          journeyStep(
            'Resource handed over',
            'Waiting',
            Icons.inventory_2_outlined,
            false,
            true,
          ),
          journeyStep(
            'Exchange completed',
            'Waiting',
            Icons.task_alt_rounded,
            false,
            false,
          ),
        ],
      ),
    );
  }

  Widget journeyStep(
    String title,
    String status,
    IconData icon,
    bool active,
    bool showLine,
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
                  color: active
                      ? const Color(0xFFE8F0FF)
                      : const Color(0xFFF0F3F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: active
                      ? const Color(0xFF3867D6)
                      : const Color(0xFF9AA3AE),
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(
                      vertical: 3,
                    ),
                    color: active
                        ? const Color(0xFFDCE7FF)
                        : const Color(0xFFE5E9EF),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: active
                                ? const Color(0xFF18202A)
                                : const Color(0xFF7A8491),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 10,
                            color: active
                                ? const Color(0xFF23844D)
                                : const Color(0xFF9AA3AE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (active)
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 17,
                      color: Color(0xFF23844D),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationCard(
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
                  'Handover location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => changeLocation(exchange),
                child: const Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Container(
            height: 145,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDF2),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  painter: TrackingMapPainter(),
                  size: const Size(
                    double.infinity,
                    145,
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 17,
                  child: mapPin(
                    Icons.my_location_rounded,
                    const Color(0xFF3867D6),
                  ),
                ),
                Positioned(
                  right: 45,
                  bottom: 28,
                  child: mapPin(
                    Icons.location_on_rounded,
                    const Color(0xFF23844D),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      exchange['distance'].toString(),
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF3867D6),
                size: 19,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  exchange['location'].toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => openDirections(exchange),
                icon: const Icon(
                  Icons.directions_outlined,
                  color: Color(0xFF3867D6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mapPin(
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 18,
        color: color,
      ),
    );
  }

  Widget buildParticipantCard(
    Map<String, dynamic> exchange,
  ) {
    final participant =
        exchange['participant'].toString();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFFE8F0FF),
            child: Text(
              participant.substring(0, 1),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF3867D6),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  participant,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      size: 13,
                      color: Color(0xFF23844D),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Verified participant',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF23844D),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => contactParticipant(participant),
            icon: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: Color(0xFF3867D6),
            ),
          ),
          IconButton(
            onPressed: () => callParticipant(participant),
            icon: const Icon(
              Icons.phone_outlined,
              color: Color(0xFF23844D),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmartDelayCard() {
    return Container(
      padding: const EdgeInsets.all(17),
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
          const Icon(
            Icons.psychology_alt_outlined,
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
                  'Smart delay prediction',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Current route conditions suggest your handover is likely to remain on time.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'On-time probability: 94%',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
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

  Widget buildSafetyCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
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
                  color: const Color(0xFFE8F8EF),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: Color(0xFF23844D),
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Exchange safety',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Text(
                'Good',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF23844D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          safetyItem(
            'Verified participant',
            true,
          ),
          safetyItem(
            'Verified handover point',
            true,
          ),
          safetyItem(
            'Exchange details confirmed',
            true,
          ),
          safetyItem(
            'Public location recommended',
            true,
          ),
        ],
      ),
    );
  }

  Widget safetyItem(
    String title,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 17,
            color: completed
                ? const Color(0xFF23844D)
                : const Color(0xFF9AA3AE),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF596573),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProofCard() {
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
            'Proof of handover',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Confirm the exchange after the resource is received.',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF7A8491),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.photo_camera_outlined,
                  color: Color(0xFF3867D6),
                  size: 24,
                ),
                SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photo confirmation',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Optional evidence for completed exchanges',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9AA3AE),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: showProofOptions,
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 18,
              ),
              label: const Text(
                'Add Handover Proof',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReliabilityCard() {
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
                  'Delivery reliability',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
              ),
              const Icon(
                Icons.trending_up_rounded,
                color: Color(0xFF23844D),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          reliabilityMetric(
            'On-time exchanges',
            '95%',
            0.95,
          ),
          const SizedBox(height: 13),
          reliabilityMetric(
            'Successful handovers',
            '98%',
            0.98,
          ),
          const SizedBox(height: 13),
          reliabilityMetric(
            'Participant confirmation',
            '97%',
            0.97,
          ),
        ],
      ),
    );
  }

  Widget reliabilityMetric(
    String title,
    String value,
    double progress,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF596573),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Color(0xFF18202A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor:
                const Color(0xFFECEFF3),
          ),
        ),
      ],
    );
  }

  Widget buildQuickActions(
    Map<String, dynamic> exchange,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick actions',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF18202A),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: actionCard(
                Icons.navigation_outlined,
                'Navigate',
                () => openDirections(exchange),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: actionCard(
                Icons.chat_bubble_outline_rounded,
                'Message',
                () => contactParticipant(
                  exchange['participant'].toString(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: actionCard(
                Icons.report_problem_outlined,
                'Report',
                showDelayReport,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget actionCard(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFF3867D6),
              size: 22,
            ),
            const SizedBox(height: 7),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF18202A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeLocation(
    Map<String, dynamic> exchange,
  ) {
    final locations = [
      'VIT Library Entrance',
      'Student Activity Centre',
      'Technology Tower Lobby',
      'Innovation Lab',
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
                  'Change handover location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Select a verified pickup point.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7A8491),
                  ),
                ),
                const SizedBox(height: 14),
                ...locations.map(
                  (location) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF3867D6),
                    ),
                    title: Text(
                      location,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
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
                            'Location changed to $location.',
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

  void openDirections(
    Map<String, dynamic> exchange,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Navigation opened for ${exchange['location']}.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void contactParticipant(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening conversation with $name.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void callParticipant(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Calling $name.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showProofOptions() {
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
                  'Add handover proof',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text('Take a photo'),
                  subtitle: const Text(
                    'Capture the completed handover',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    showProofAdded();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text('Choose from gallery'),
                  subtitle: const Text(
                    'Select an existing photo',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    showProofAdded();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit_note_rounded,
                    color: Color(0xFF3867D6),
                  ),
                  title: const Text('Add confirmation note'),
                  subtitle: const Text(
                    'Record a short handover note',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    showProofAdded();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showProofAdded() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Handover proof added successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showDelayReport() {
    final reasons = [
      'Participant is delayed',
      'Location is crowded',
      'Resource is not ready',
      'Unable to reach participant',
      'Other issue',
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
                  'Tell us what is affecting the handover.',
                  style: TextStyle(
                    fontSize: 11,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Issue reported. Support will review it.',
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

  void showTrackingNotifications() {
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
                  'Tracking alerts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 12),
                const ListTile(
                  leading: Icon(
                    Icons.navigation_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: Text('Participant is on the way'),
                  subtitle: Text(
                    'Estimated arrival in 8 minutes.',
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF23844D),
                  ),
                  title: Text('Handover point verified'),
                  subtitle: Text(
                    'Your selected location is currently open.',
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(sheetContext),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showTrackingOptions() {
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
                  'Tracking options',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 12),
                const ListTile(
                  leading: Icon(
                    Icons.share_location_outlined,
                  ),
                  title: Text('Share live location'),
                  subtitle: Text(
                    'Share your arrival status with the participant',
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.notifications_active_outlined,
                  ),
                  title: Text('Manage alerts'),
                  subtitle: Text(
                    'Choose when ResourceX notifies you',
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.history_rounded,
                  ),
                  title: Text('View tracking history'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(sheetContext),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshTracking() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Live exchange status updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class TrackingMapPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final roadPaint = Paint()
      ..color = const Color(0xFFD1D8DF)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final secondaryPaint = Paint()
      ..color = const Color(0xFFDDE3E8)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final routePaint = Paint()
      ..color = const Color(0xFF3867D6)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height * 0.28),
      Offset(size.width, size.height * 0.78),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.25, 0),
      Offset(size.width * 0.78, size.height),
      roadPaint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.82),
      Offset(size.width, size.height * 0.12),
      secondaryPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.05, size.height * 0.08),
      Offset(size.width * 0.94, size.height * 0.92),
      secondaryPaint,
    );

    final route = Path()
      ..moveTo(
        size.width * 0.18,
        size.height * 0.22,
      )
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.48,
        size.width * 0.48,
        size.height * 0.43,
      )
      ..quadraticBezierTo(
        size.width * 0.67,
        size.height * 0.38,
        size.width * 0.82,
        size.height * 0.73,
      );

    canvas.drawPath(
      route,
      routePaint,
    );

    drawPoint(
      canvas,
      Offset(
        size.width * 0.18,
        size.height * 0.22,
      ),
      const Color(0xFF3867D6),
    );

    drawPoint(
      canvas,
      Offset(
        size.width * 0.82,
        size.height * 0.73,
      ),
      const Color(0xFF23844D),
    );
  }

  void drawPoint(
    Canvas canvas,
    Offset center,
    Color color,
  ) {
    final outer = Paint()..color = color;

    canvas.drawCircle(
      center,
      9,
      outer,
    );

    final inner = Paint()..color = Colors.white;

    canvas.drawCircle(
      center,
      3.5,
      inner,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}