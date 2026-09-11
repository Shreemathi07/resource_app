import 'package:flutter/material.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'All';
  String _selectedSort = 'Best Match';

  final List<String> _filters = [
    'All',
    'Urgent',
    'Nearby',
    'Food',
    'Education',
    'Medical',
  ];

  final List<_RequestItem> _requests = [
    _RequestItem(
      title: 'School Supplies for Community Centre',
      requester: 'Hope Community Centre',
      category: 'Education',
      icon: Icons.school_rounded,
      quantity: '120 kits',
      location: 'Vellore · 2.4 km',
      neededBy: 'Needed by 28 Aug',
      urgency: 'High',
      matchScore: 96,
      status: 'Open',
      description:
          'Looking for notebooks, pens, pencils and basic learning materials for students attending the community centre.',
    ),
    _RequestItem(
      title: 'Surplus Food for Student Volunteers',
      requester: 'Green Campus Network',
      category: 'Food',
      icon: Icons.restaurant_rounded,
      quantity: '80 meals',
      location: 'Katpadi · 3.1 km',
      neededBy: 'Needed tomorrow',
      urgency: 'Urgent',
      matchScore: 93,
      status: 'Open',
      description:
          'Fresh surplus meals are requested for student volunteers working on a weekend community initiative.',
    ),
    _RequestItem(
      title: 'First-Aid Materials',
      requester: 'CareLink Volunteers',
      category: 'Medical',
      icon: Icons.medical_services_rounded,
      quantity: '25 kits',
      location: 'Vellore · 4.8 km',
      neededBy: 'Needed by 30 Aug',
      urgency: 'Medium',
      matchScore: 88,
      status: 'Open',
      description:
          'Basic first-aid supplies are required for community outreach and local volunteer activities.',
    ),
    _RequestItem(
      title: 'Laptops for Digital Learning',
      requester: 'Future Skills Foundation',
      category: 'Education',
      icon: Icons.laptop_mac_rounded,
      quantity: '15 devices',
      location: 'Sathuvachari · 6.2 km',
      neededBy: 'Needed by 05 Sep',
      urgency: 'Medium',
      matchScore: 84,
      status: 'Open',
      description:
          'Working laptops are needed to create a small digital learning space for students.',
    ),
    _RequestItem(
      title: 'Dry Ration Support',
      requester: 'Neighbourhood Relief Group',
      category: 'Food',
      icon: Icons.shopping_basket_rounded,
      quantity: '60 packs',
      location: 'Vellore · 7.4 km',
      neededBy: 'Needed by 01 Sep',
      urgency: 'High',
      matchScore: 81,
      status: 'Open',
      description:
          'Essential dry ration items are requested for families receiving short-term community support.',
    ),
  ];

  List<_RequestItem> get _filteredRequests {
    final query = _searchController.text.trim().toLowerCase();

    List<_RequestItem> result = _requests.where((request) {
      final matchesSearch =
          query.isEmpty ||
          request.title.toLowerCase().contains(query) ||
          request.requester.toLowerCase().contains(query) ||
          request.category.toLowerCase().contains(query);

      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Urgent' &&
              (request.urgency == 'Urgent' || request.urgency == 'High')) ||
          (_selectedFilter == 'Nearby' &&
              double.parse(
                    request.location
                        .split('·')
                        .last
                        .replaceAll('km', '')
                        .trim(),
                  ) <=
                  5) ||
          request.category == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    if (_selectedSort == 'Highest Match') {
      result.sort((a, b) => b.matchScore.compareTo(a.matchScore));
    } else if (_selectedSort == 'Nearest') {
      result.sort(
        (a, b) => _distance(a).compareTo(_distance(b)),
      );
    } else if (_selectedSort == 'Most Urgent') {
      result.sort(
        (a, b) => _urgencyValue(b).compareTo(_urgencyValue(a)),
      );
    }

    return result;
  }

  double _distance(_RequestItem request) {
    return double.parse(
      request.location
          .split('·')
          .last
          .replaceAll('km', '')
          .trim(),
    );
  }

  int _urgencyValue(_RequestItem request) {
    switch (request.urgency) {
      case 'Urgent':
        return 3;
      case 'High':
        return 2;
      default:
        return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
  }

  void _refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  void _showRequestDetails(_RequestItem request) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _RequestIcon(
                        icon: request.icon,
                        category: request.category,
                        size: 58,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              request.requester,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _DetailRow(
                    icon: Icons.category_outlined,
                    title: 'Category',
                    value: request.category,
                  ),
                  _DetailRow(
                    icon: Icons.inventory_2_outlined,
                    title: 'Quantity',
                    value: request.quantity,
                  ),
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: request.location,
                  ),
                  _DetailRow(
                    icon: Icons.event_outlined,
                    title: 'Timeline',
                    value: request.neededBy,
                  ),
                  _DetailRow(
                    icon: Icons.auto_awesome_rounded,
                    title: 'ResourceX match',
                    value: '${request.matchScore}% compatible',
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Why this request matters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    request.description,
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showMessage(
                              'Request saved to your watchlist.',
                            );
                          },
                          icon: const Icon(Icons.bookmark_border_rounded),
                          label: const Text('Save'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showMessage(
                              'Connection request sent to ${request.requester}.',
                            );
                          },
                          icon: const Icon(Icons.handshake_outlined),
                          label: const Text('Offer Help'),
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

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request filters',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Sort requests by',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Best Match',
                        'Highest Match',
                        'Nearest',
                        'Most Urgent',
                      ].map((sort) {
                        return ChoiceChip(
                          label: Text(sort),
                          selected: _selectedSort == sort,
                          onSelected: (_) {
                            setSheetState(() {
                              _selectedSort = sort;
                            });
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Discovery radius',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Showing requests within your selected discovery area.',
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Apply filters'),
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

  void _createRequest() {
    final titleController = TextEditingController();
    final quantityController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              4,
              20,
              MediaQuery.viewInsetsOf(context).bottom + 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create a resource request',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Tell the ResourceX community what you need.',
                  ),
                  const SizedBox(height: 22),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'What do you need?',
                      hintText: 'Example: 20 laptops for a learning centre',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      hintText: 'Example: 20',
                      prefixIcon: Icon(Icons.inventory_2_outlined),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: 'Education',
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Education',
                        child: Text('Education'),
                      ),
                      DropdownMenuItem(
                        value: 'Food',
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: 'Medical',
                        child: Text('Medical'),
                      ),
                      DropdownMenuItem(
                        value: 'Technology',
                        child: Text('Technology'),
                      ),
                    ],
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: 'Medium',
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      prefixIcon: Icon(Icons.flag_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Low',
                        child: Text('Low'),
                      ),
                      DropdownMenuItem(
                        value: 'Medium',
                        child: Text('Medium'),
                      ),
                      DropdownMenuItem(
                        value: 'High',
                        child: Text('High'),
                      ),
                      DropdownMenuItem(
                        value: 'Urgent',
                        child: Text('Urgent'),
                      ),
                    ],
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMessage(
                          'Request created successfully.',
                        );
                      },
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Publish Request'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      titleController.dispose();
      quantityController.dispose();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requests = _filteredRequests;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createRequest,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Request'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: _buildHeader(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildSearch(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildFilters(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
                child: _buildInsightCard(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      '${requests.length} requests found',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _selectedSort,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            if (requests.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyState(context),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList.separated(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return _buildRequestCard(
                      context,
                      requests[index],
                    );
                  },
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resource Requests',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Discover needs where your resources can make a difference.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: _showFilterSheet,
          icon: const Icon(Icons.tune_rounded),
          tooltip: 'Filters',
        ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search requests, organisations or categories',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
                onPressed: _searchController.clear,
                icon: const Icon(Icons.clear_rounded),
              ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];

          return ChoiceChip(
            label: Text(filter),
            selected: _selectedFilter == filter,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 8),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ResourceX Intelligence',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '12 requests near you may match resources you can provide.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
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

  Widget _buildRequestCard(
    BuildContext context,
    _RequestItem request,
  ) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => _showRequestDetails(request),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RequestIcon(
                    icon: request.icon,
                    category: request.category,
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _StatusPill(
                              label: request.urgency,
                              isUrgent: request.urgency == 'Urgent' ||
                                  request.urgency == 'High',
                            ),
                            const Spacer(),
                            _MatchPill(
                              score: request.matchScore,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          request.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          request.requester,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(height: 1),
              const SizedBox(height: 14),
              Wrap(
                spacing: 14,
                runSpacing: 10,
                children: [
                  _InfoItem(
                    icon: Icons.inventory_2_outlined,
                    text: request.quantity,
                  ),
                  _InfoItem(
                    icon: Icons.location_on_outlined,
                    text: request.location,
                  ),
                  _InfoItem(
                    icon: Icons.event_outlined,
                    text: request.neededBy,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      request.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No matching requests',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Try another category or search term.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestItem {
  final String title;
  final String requester;
  final String category;
  final IconData icon;
  final String quantity;
  final String location;
  final String neededBy;
  final String urgency;
  final int matchScore;
  final String status;
  final String description;

  const _RequestItem({
    required this.title,
    required this.requester,
    required this.category,
    required this.icon,
    required this.quantity,
    required this.location,
    required this.neededBy,
    required this.urgency,
    required this.matchScore,
    required this.status,
    required this.description,
  });
}

class _RequestIcon extends StatelessWidget {
  final IconData icon;
  final String category;
  final double size;

  const _RequestIcon({
    required this.icon,
    required this.category,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: theme.colorScheme.primary,
        size: size * 0.48,
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final bool isUrgent;

  const _StatusPill({
    required this.label,
    required this.isUrgent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isUrgent
            ? theme.colorScheme.errorContainer
            : theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: isUrgent
              ? theme.colorScheme.onErrorContainer
              : theme.colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class _MatchPill extends StatelessWidget {
  final int score;

  const _MatchPill({
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.auto_awesome_rounded,
          size: 14,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          '$score% match',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 15,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 21,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
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
}