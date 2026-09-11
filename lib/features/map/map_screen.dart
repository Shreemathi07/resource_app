import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedFilter = 0;
  String _searchQuery = '';
  String _radius = '10 km';

  final List<_NearbyPlace> _places = const [
    _NearbyPlace(
      name: 'Community Food Hub',
      type: 'Resource',
      category: 'Food',
      distance: '0.8 km',
      location: 'Gandhi Nagar',
      quantity: '120 meal packs',
      status: 'Available',
      icon: Icons.restaurant_rounded,
      description:
          'Surplus meal packs available for verified community organizations and local seekers.',
    ),
    _NearbyPlace(
      name: 'GreenCycle Foundation',
      type: 'Organization',
      category: 'Recycling',
      distance: '1.4 km',
      location: 'Katpadi Road',
      quantity: '35 kg materials',
      status: 'Active',
      icon: Icons.recycling_rounded,
      description:
          'A local organization connecting reusable materials with community projects.',
    ),
    _NearbyPlace(
      name: 'Student Support Centre',
      type: 'Requirement',
      category: 'Education',
      distance: '2.1 km',
      location: 'Vellore Town',
      quantity: '25 notebooks',
      status: 'Urgent',
      icon: Icons.school_rounded,
      description:
          'A verified educational requirement supporting students through community donations.',
    ),
    _NearbyPlace(
      name: 'TechShare Lab',
      type: 'Resource',
      category: 'Technology',
      distance: '2.7 km',
      location: 'Sathuvachari',
      quantity: '8 laptops',
      status: 'Available',
      icon: Icons.laptop_mac_rounded,
      description:
          'Refurbished laptops available for educational and community technology programs.',
    ),
    _NearbyPlace(
      name: 'Hope Community Kitchen',
      type: 'Resource',
      category: 'Food',
      distance: '3.2 km',
      location: 'Bagayam',
      quantity: '75 meal packs',
      status: 'Available',
      icon: Icons.volunteer_activism_rounded,
      description:
          'Surplus food collected from local partners for community distribution.',
    ),
    _NearbyPlace(
      name: 'Learning Bridge',
      type: 'Requirement',
      category: 'Education',
      distance: '4.1 km',
      location: 'Thorapadi',
      quantity: '40 books',
      status: 'Open',
      icon: Icons.menu_book_rounded,
      description:
          'Looking for educational books and learning materials for an after-school program.',
    ),
    _NearbyPlace(
      name: 'EcoBuild Collective',
      type: 'Organization',
      category: 'Construction',
      distance: '4.8 km',
      location: 'Old Katpadi',
      quantity: 'Community project',
      status: 'Active',
      icon: Icons.home_work_rounded,
      description:
          'Community initiative connecting reusable construction materials with local projects.',
    ),
  ];

  List<_NearbyPlace> get _filteredPlaces {
    List<_NearbyPlace> result = List.from(_places);

    if (_selectedFilter == 1) {
      result = result.where((place) => place.type == 'Resource').toList();
    } else if (_selectedFilter == 2) {
      result = result.where((place) => place.type == 'Requirement').toList();
    } else if (_selectedFilter == 3) {
      result = result.where((place) => place.type == 'Organization').toList();
    }

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      result = result.where((place) {
        return place.name.toLowerCase().contains(query) ||
            place.category.toLowerCase().contains(query) ||
            place.location.toLowerCase().contains(query);
      }).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                children: [
                  _buildSearch(),
                  const SizedBox(height: 14),
                  _buildFilters(),
                  const SizedBox(height: 18),
                  _buildMapCard(),
                  const SizedBox(height: 20),
                  _buildNearbyHeader(),
                  const SizedBox(height: 12),
                  _buildPlaces(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showLocationSheet,
        icon: const Icon(Icons.my_location_rounded),
        label: const Text('My Location'),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3155D8),
                  Color(0xFF6A5AE0),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.explore_rounded,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nearby Discovery',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Discover opportunities around you',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showLocationSheet,
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Discovery settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search resources, needs or places...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: _showFilterSheet,
          icon: const Icon(Icons.filter_list_rounded),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Color(0xFF3155D8),
            width: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    const labels = [
      'Everything',
      'Resources',
      'Requirements',
      'Organizations',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedFilter == index;

          return ChoiceChip(
            label: Text(labels[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = index;
              });
            },
            selectedColor: const Color(0xFF3155D8),
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selected
                  ? const Color(0xFF3155D8)
                  : Colors.grey.shade200,
            ),
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.grey.shade700,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapCard() {
    return Container(
      height: 270,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, 270),
            painter: _MapPainter(),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: _mapBadge(
              Icons.location_on_rounded,
              'Vellore',
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: _showFilterSheet,
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.layers_rounded),
                ),
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 88,
            child: _mapPin(
              Icons.restaurant_rounded,
              const Color(0xFFE45757),
            ),
          ),
          Positioned(
            left: 155,
            top: 130,
            child: _mapPin(
              Icons.laptop_mac_rounded,
              const Color(0xFF3155D8),
            ),
          ),
          Positioned(
            right: 70,
            top: 80,
            child: _mapPin(
              Icons.school_rounded,
              const Color(0xFFE2A33B),
            ),
          ),
          Positioned(
            right: 105,
            bottom: 55,
            child: _mapPin(
              Icons.recycling_rounded,
              const Color(0xFF2F9D68),
            ),
          ),
          Positioned(
            left: 171,
            bottom: 38,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3155D8).withValues(alpha: 0.15),
              ),
              child: Center(
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3155D8),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.radar_rounded,
                    color: Color(0xFF3155D8),
                    size: 17,
                  ),
                  SizedBox(width: 7),
                  Text(
                    '12 opportunities nearby',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
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

  Widget _mapBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF3155D8),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapPin(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        final place = _places.firstWhere(
          (item) => item.icon == icon,
          orElse: () => _places.first,
        );
        _showPlaceDetails(place);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildNearbyHeader() {
    final count = _filteredPlaces.length;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nearby opportunities',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count opportunities within your discovery area',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: _showFilterSheet,
          icon: const Icon(
            Icons.tune_rounded,
            size: 17,
          ),
          label: const Text('Filter'),
        ),
      ],
    );
  }

  Widget _buildPlaces() {
    final places = _filteredPlaces;

    if (places.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 46,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            const Text(
              'No nearby opportunities',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try another category or search term.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: places.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildPlaceCard(places[index]);
      },
    );
  }

  Widget _buildPlaceCard(_NearbyPlace place) {
    final statusColor = _statusColor(place.status);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _showPlaceDetails(place),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  place.icon,
                  color: statusColor,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            place.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            place.status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 9.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${place.category} • ${place.quantity}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            place.location,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 10.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.near_me_outlined,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          place.distance,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    if (status == 'Urgent') {
      return const Color(0xFFD94A4A);
    }

    if (status == 'Available') {
      return const Color(0xFF2F9D68);
    }

    return const Color(0xFF3155D8);
  }

  void _showPlaceDetails(_NearbyPlace place) {
    final statusColor = _statusColor(place.status);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
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
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        place.icon,
                        color: statusColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            place.type,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
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
                        color: statusColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        place.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  place.description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.45,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _detailBox(
                        Icons.near_me_outlined,
                        'Distance',
                        place.distance,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _detailBox(
                        Icons.inventory_2_outlined,
                        'Quantity',
                        place.quantity,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _detailBox(
                  Icons.place_outlined,
                  'Location',
                  place.location,
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage('Directions opened.');
                        },
                        icon: const Icon(Icons.directions_rounded),
                        label: const Text('Directions'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage(
                            'Connection request sent to ${place.name}.',
                          );
                        },
                        icon: const Icon(Icons.handshake_rounded),
                        label: const Text('Connect'),
                      ),
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

  Widget _detailBox(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF3155D8),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
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
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Discovery Radius',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Show opportunities within your selected distance.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        '2 km',
                        '5 km',
                        '10 km',
                        '25 km',
                        '50 km',
                      ].map(
                        (value) {
                          final selected = _radius == value;

                          return ChoiceChip(
                            label: Text(value),
                            selected: selected,
                            onSelected: (_) {
                              setSheetState(() {
                                _radius = value;
                              });
                              setState(() {});
                            },
                            selectedColor: const Color(0xFF3155D8),
                            labelStyle: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Quick filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _quickFilter(
                      Icons.verified_rounded,
                      'Verified opportunities',
                      'Prioritize trusted ResourceX members',
                    ),
                    _quickFilter(
                      Icons.priority_high_rounded,
                      'Urgent requirements',
                      'Show time-sensitive needs first',
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showMessage(
                            'Discovery filters updated for $_radius.',
                          );
                        },
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _quickFilter(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF3155D8).withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF3155D8),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 11,
        ),
      ),
      trailing: Switch(
        value: true,
        onChanged: (_) {
          _showMessage('Filter preference updated.');
        },
      ),
    );
  }

  void _showLocationSheet() {
    showModalBottomSheet<void>(
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
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Discovery Location',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Choose where ResourceX should discover opportunities.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 15),
                _locationTile(
                  Icons.my_location_rounded,
                  'Use current location',
                  'Vellore, Tamil Nadu',
                ),
                _locationTile(
                  Icons.edit_location_alt_rounded,
                  'Choose another area',
                  'Explore resources in a different location',
                ),
                _locationTile(
                  Icons.public_rounded,
                  'Explore globally',
                  'Discover opportunities beyond your area',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _locationTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.pop(context);
        _showMessage('$title selected.');
      },
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF3155D8).withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF3155D8),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 11,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey,
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _NearbyPlace {
  final String name;
  final String type;
  final String category;
  final String distance;
  final String location;
  final String quantity;
  final String status;
  final IconData icon;
  final String description;

  const _NearbyPlace({
    required this.name,
    required this.type,
    required this.category,
    required this.distance,
    required this.location,
    required this.quantity,
    required this.status,
    required this.icon,
    required this.description,
  });
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = const Color(0xFFEAF0E9)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Offset.zero & size,
      backgroundPaint,
    );

    final greenPaint = Paint()
      ..color = const Color(0xFFD5E7D3)
      ..style = PaintingStyle.fill;

    final waterPaint = Paint()
      ..color = const Color(0xFFCFE4F1)
      ..style = PaintingStyle.fill;

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 13
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final smallRoadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final park = Path()
      ..moveTo(size.width * 0.04, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.16,
        size.height * 0.40,
        size.width * 0.29,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.20,
        size.height * 0.70,
        size.width * 0.04,
        size.height * 0.68,
      )
      ..close();

    canvas.drawPath(park, greenPaint);

    final water = Path()
      ..moveTo(size.width * 0.71, 0)
      ..quadraticBezierTo(
        size.width * 0.62,
        size.height * 0.20,
        size.width * 0.74,
        size.height * 0.40,
      )
      ..quadraticBezierTo(
        size.width * 0.84,
        size.height * 0.58,
        size.width * 0.76,
        size.height,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(water, waterPaint);

    final mainRoad = Path()
      ..moveTo(-20, size.height * 0.78)
      ..cubicTo(
        size.width * 0.20,
        size.height * 0.63,
        size.width * 0.45,
        size.height * 0.75,
        size.width * 1.03,
        size.height * 0.40,
      );

    canvas.drawPath(mainRoad, roadPaint);

    final verticalRoad = Path()
      ..moveTo(size.width * 0.35, -20)
      ..cubicTo(
        size.width * 0.42,
        size.height * 0.25,
        size.width * 0.28,
        size.height * 0.55,
        size.width * 0.38,
        size.height + 20,
      );

    canvas.drawPath(verticalRoad, roadPaint);

    final diagonalRoad = Path()
      ..moveTo(size.width * 0.05, size.height * 0.16)
      ..quadraticBezierTo(
        size.width * 0.40,
        size.height * 0.32,
        size.width * 0.66,
        size.height * 0.18,
      );

    canvas.drawPath(diagonalRoad, smallRoadPaint);

    final lowerRoad = Path()
      ..moveTo(size.width * 0.05, size.height * 0.92)
      ..quadraticBezierTo(
        size.width * 0.46,
        size.height * 0.62,
        size.width * 0.95,
        size.height * 0.84,
      );

    canvas.drawPath(lowerRoad, smallRoadPaint);

    final blockPaint = Paint()
      ..color = const Color(0xFFE1E8DF)
      ..style = PaintingStyle.fill;

    final blocks = [
      Rect.fromLTWH(
        size.width * 0.05,
        size.height * 0.05,
        75,
        42,
      ),
      Rect.fromLTWH(
        size.width * 0.43,
        size.height * 0.08,
        78,
        38,
      ),
      Rect.fromLTWH(
        size.width * 0.44,
        size.height * 0.52,
        82,
        45,
      ),
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.76,
        72,
        40,
      ),
    ];

    for (final block in blocks) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          block,
          const Radius.circular(7),
        ),
        blockPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}