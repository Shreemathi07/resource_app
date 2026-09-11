import 'package:flutter/material.dart';

class ExchangeRouteScreen extends StatefulWidget {
  const ExchangeRouteScreen({super.key});

  @override
  State<ExchangeRouteScreen> createState() => _ExchangeRouteScreenState();
}

class _ExchangeRouteScreenState extends State<ExchangeRouteScreen> {
  int selectedMode = 0;
  int selectedExchange = 0;

  final List<String> travelModes = [
    'Walk',
    'Cycle',
    'Vehicle',
  ];

  final List<Map<String, dynamic>> exchanges = [
    {
      'title': 'Textbook Handover',
      'resource': 'Data Structures Textbooks',
      'location': 'VIT Library Entrance',
      'distance': '0.8 km',
      'time': '10 min',
      'status': 'Next',
      'provider': 'Aarav Kumar',
      'timeSlot': '04:30 PM',
    },
    {
      'title': 'Laptop Accessories',
      'resource': 'Laptop Stand + Keyboard',
      'location': 'Technology Tower Lobby',
      'distance': '1.4 km',
      'time': '18 min',
      'status': 'Upcoming',
      'provider': 'Rahul Dev',
      'timeSlot': '06:00 PM',
    },
    {
      'title': 'Arduino Kit',
      'resource': 'Arduino Starter Kit',
      'location': 'Innovation Lab',
      'distance': '2.1 km',
      'time': '25 min',
      'status': 'Tomorrow',
      'provider': 'VIT Innovation Club',
      'timeSlot': '10:30 AM',
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
          'Smart Routes',
          style: TextStyle(
            color: Color(0xFF18202A),
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showRouteOptions,
            icon: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshRoutes,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          children: [
            buildRouteHero(),
            const SizedBox(height: 18),
            buildTravelModes(),
            const SizedBox(height: 20),
            buildMapPreview(),
            const SizedBox(height: 22),
            buildRouteSummary(),
            const SizedBox(height: 22),
            buildExchangeSelector(),
            const SizedBox(height: 14),
            buildSelectedExchange(),
            const SizedBox(height: 20),
            buildSmartRecommendation(),
            const SizedBox(height: 20),
            buildNearbyPickupPoints(),
            const SizedBox(height: 20),
            buildLogisticsPerformance(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showOptimizeRoute,
        backgroundColor: const Color(0xFF18202A),
        icon: const Icon(Icons.route_rounded),
        label: const Text(
          'Optimize Route',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget buildRouteHero() {
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
                  Icons.alt_route_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Smart Exchange Logistics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Recommended route',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Library → Technology Tower',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            '2 handovers • 2.2 km total • approximately 28 min',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 0.86,
                    minHeight: 7,
                    backgroundColor: Color(0x334A5564),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFB8F2D0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                '86%',
                style: TextStyle(
                  color: Color(0xFFB8F2D0),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Route efficiency',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTravelModes() {
    return Container(
      height: 49,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: List.generate(
          travelModes.length,
          (index) {
            final selected = selectedMode == index;

            final icons = [
              Icons.directions_walk_rounded,
              Icons.directions_bike_rounded,
              Icons.directions_car_rounded,
            ];

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMode = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF18202A)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 17,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF7A8491),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        travelModes[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: selected
                              ? Colors.white
                              : const Color(0xFF7A8491),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildMapPreview() {
    return Container(
      height: 245,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFDDE3E9),
        ),
      ),
      child: Stack(
        children: [
          CustomPaint(
            painter: RouteMapPainter(),
            size: const Size(double.infinity, 245),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.my_location_rounded,
                    size: 16,
                    color: Color(0xFF3867D6),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Current location',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF18202A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 14,
            bottom: 14,
            child: Column(
              children: [
                routeMapButton(
                  Icons.add_rounded,
                  () {},
                ),
                const SizedBox(height: 6),
                routeMapButton(
                  Icons.remove_rounded,
                  () {},
                ),
              ],
            ),
          ),
          Positioned(
            left: 18,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '2.2 km route',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF18202A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget routeMapButton(
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xFF18202A),
          ),
        ),
      ),
    );
  }

  Widget buildRouteSummary() {
    return Row(
      children: [
        Expanded(
          child: routeStat(
            '2.2 km',
            'Distance',
            Icons.straighten_rounded,
            const Color(0xFF3867D6),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: routeStat(
            '28 min',
            'Travel time',
            Icons.schedule_rounded,
            const Color(0xFF23844D),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: routeStat(
            '2',
            'Stops',
            Icons.location_on_outlined,
            const Color(0xFF8A5A00),
          ),
        ),
      ],
    );
  }

  Widget routeStat(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF7A8491),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExchangeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exchange stops',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF18202A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Manage locations for your upcoming handovers',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF7A8491),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 105,
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
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFFDCE7FF)
                                  : const Color(0xFFF0F3F6),
                              borderRadius:
                                  BorderRadius.circular(9),
                            ),
                            child: Icon(
                              Icons.inventory_2_outlined,
                              size: 17,
                              color: selected
                                  ? const Color(0xFF3867D6)
                                  : const Color(0xFF687382),
                            ),
                          ),
                          const SizedBox(width: 8),
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
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Color(0xFF7A8491),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              exchange['location'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 9,
                                color: Color(0xFF7A8491),
                              ),
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
        ),
      ],
    );
  }

  Widget buildSelectedExchange() {
    final exchange = exchanges[selectedExchange];

    return InkWell(
      onTap: () => showExchangeDetails(exchange),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E9EF),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.navigation_outlined,
                    color: Color(0xFF3867D6),
                    size: 23,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18202A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exchange['resource'].toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF7A8491),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F8EF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    exchange['status'].toString(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF23844D),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                routeDetail(
                  Icons.access_time_rounded,
                  exchange['timeSlot'].toString(),
                ),
                const SizedBox(width: 12),
                routeDetail(
                  Icons.straighten_rounded,
                  exchange['distance'].toString(),
                ),
                const SizedBox(width: 12),
                routeDetail(
                  Icons.directions_walk_rounded,
                  exchange['time'].toString(),
                ),
              ],
            ),
            const SizedBox(height: 13),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 17,
                  color: Color(0xFF7A8491),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    exchange['location'].toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF596573),
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9AA3AE),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget routeDetail(
    IconData icon,
    String text,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: const Color(0xFF7A8491),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF596573),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmartRecommendation() {
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
            Icons.auto_awesome_rounded,
            color: Color(0xFF3867D6),
            size: 24,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart route recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Combining your first two exchanges can save approximately 14 minutes of travel time.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyPickupPoints() {
    final points = [
      {
        'name': 'VIT Library Entrance',
        'distance': '0.8 km',
        'availability': 'Open',
      },
      {
        'name': 'Student Activity Centre',
        'distance': '1.1 km',
        'availability': 'Open',
      },
      {
        'name': 'Innovation Lab',
        'distance': '2.1 km',
        'availability': 'Busy',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nearby pickup points',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF18202A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Safe and convenient locations for handovers',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF7A8491),
          ),
        ),
        const SizedBox(height: 12),
        ...points.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: pickupPointCard(point),
          ),
        ),
      ],
    );
  }

  Widget pickupPointCard(Map<String, String> point) {
    final open = point['availability'] == 'Open';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E9EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3F6),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.place_outlined,
              color: Color(0xFF3867D6),
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
                  point['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  point['distance']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7A8491),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: open
                  ? const Color(0xFFE8F8EF)
                  : const Color(0xFFFFF3DD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              point['availability']!,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: open
                    ? const Color(0xFF23844D)
                    : const Color(0xFFB27600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogisticsPerformance() {
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
            'Logistics performance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF18202A),
            ),
          ),
          const SizedBox(height: 15),
          performanceRow(
            'Route efficiency',
            '92%',
            0.92,
          ),
          const SizedBox(height: 13),
          performanceRow(
            'On-time arrivals',
            '95%',
            0.95,
          ),
          const SizedBox(height: 13),
          performanceRow(
            'Location reliability',
            '97%',
            0.97,
          ),
          const SizedBox(height: 13),
          performanceRow(
            'Travel optimization',
            '89%',
            0.89,
          ),
        ],
      ),
    );
  }

  Widget performanceRow(
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
                fontWeight: FontWeight.w800,
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
            backgroundColor: const Color(0xFFECEFF3),
          ),
        ),
      ],
    );
  }

  void showExchangeDetails(Map<String, dynamic> exchange) {
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
            padding: const EdgeInsets.fromLTRB(
              20,
              14,
              20,
              20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8DDE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    exchange['title'].toString(),
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF18202A),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    exchange['resource'].toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A8491),
                    ),
                  ),
                  const SizedBox(height: 20),
                  detailItem(
                    Icons.location_on_outlined,
                    'Handover location',
                    exchange['location'].toString(),
                  ),
                  detailItem(
                    Icons.access_time_rounded,
                    'Time',
                    exchange['timeSlot'].toString(),
                  ),
                  detailItem(
                    Icons.straighten_rounded,
                    'Distance',
                    exchange['distance'].toString(),
                  ),
                  detailItem(
                    Icons.directions_walk_rounded,
                    'Travel time',
                    exchange['time'].toString(),
                  ),
                  detailItem(
                    Icons.person_outline_rounded,
                    'Provider',
                    exchange['provider'].toString(),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            showChangeLocation(exchange);
                          },
                          icon: const Icon(
                            Icons.edit_location_alt_outlined,
                          ),
                          label: const Text('Change'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            openNavigation(exchange);
                          },
                          icon: const Icon(
                            Icons.navigation_rounded,
                          ),
                          label: const Text('Navigate'),
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

  Widget detailItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF7A8491),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 105,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF7A8491),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF18202A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showChangeLocation(Map<String, dynamic> exchange) {
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
                  'Choose a convenient pickup point.',
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
                            'Handover location changed to $location.',
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

  void openNavigation(Map<String, dynamic> exchange) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Navigation started to ${exchange['location']}.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showOptimizeRoute() {
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
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: Color(0xFF3867D6),
                  size: 32,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Optimize your route',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'ResourceX can arrange your upcoming exchanges in the most efficient order.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: Color(0xFF687382),
                  ),
                ),
                const SizedBox(height: 18),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.timer_outlined,
                    color: Color(0xFF23844D),
                  ),
                  title: Text('Save travel time'),
                  subtitle: Text(
                    'Estimated saving: 14 minutes',
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.route_outlined,
                    color: Color(0xFF3867D6),
                  ),
                  title: Text('Reduce route distance'),
                  subtitle: Text(
                    'Estimated reduction: 0.7 km',
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Route optimized successfully.',
                          ),
                          behavior:
                              SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text(
                      'Apply Smart Route',
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

  void showRouteOptions() {
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
                  'Route Preferences',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18202A),
                  ),
                ),
                const SizedBox(height: 14),
                const ListTile(
                  leading: Icon(
                    Icons.speed_outlined,
                  ),
                  title: Text('Fastest route'),
                  subtitle: Text(
                    'Prioritize travel time',
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.route_outlined,
                  ),
                  title: Text('Shortest route'),
                  subtitle: Text(
                    'Prioritize distance',
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.security_outlined,
                  ),
                  title: Text('Safer locations'),
                  subtitle: Text(
                    'Prefer verified handover points',
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshRoutes() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Routes and locations updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class RouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFD1D8DF)
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final secondaryPaint = Paint()
      ..color = const Color(0xFFDCE2E7)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final routePaint = Paint()
      ..color = const Color(0xFF3867D6)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final routePath = Path()
      ..moveTo(size.width * 0.12, size.height * 0.76)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.60,
        size.width * 0.42,
        size.height * 0.66,
      )
      ..quadraticBezierTo(
        size.width * 0.58,
        size.height * 0.73,
        size.width * 0.68,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.77,
        size.height * 0.27,
        size.width * 0.91,
        size.height * 0.23,
      );

    canvas.drawLine(
      Offset(0, size.height * 0.20),
      Offset(size.width, size.height * 0.66),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.22, 0),
      Offset(size.width * 0.73, size.height),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.05, size.height * 0.84),
      Offset(size.width * 0.96, size.height * 0.08),
      secondaryPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.05, size.height * 0.45),
      Offset(size.width * 0.95, size.height * 0.87),
      secondaryPaint,
    );

    canvas.drawPath(routePath, routePaint);

    drawMarker(
      canvas,
      Offset(
        size.width * 0.12,
        size.height * 0.76,
      ),
      const Color(0xFF23844D),
    );

    drawMarker(
      canvas,
      Offset(
        size.width * 0.68,
        size.height * 0.48,
      ),
      const Color(0xFF3867D6),
    );

    drawMarker(
      canvas,
      Offset(
        size.width * 0.91,
        size.height * 0.23,
      ),
      const Color(0xFFB27600),
    );
  }

  void drawMarker(
    Canvas canvas,
    Offset center,
    Color color,
  ) {
    final paint = Paint()..color = color;

    canvas.drawCircle(
      center,
      10,
      paint,
    );

    final innerPaint = Paint()..color = Colors.white;

    canvas.drawCircle(
      center,
      4,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}