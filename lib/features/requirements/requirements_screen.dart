import 'package:flutter/material.dart';

class RequirementsScreen extends StatefulWidget {
  const RequirementsScreen({super.key});

  @override
  State<RequirementsScreen> createState() => _RequirementsScreenState();
}

class _RequirementsScreenState extends State<RequirementsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Active',
    'Urgent',
    'Education',
    'Food',
    'Technology',
    'Medical',
  ];

  final List<_Requirement> _requirements = [
    _Requirement(
      title: 'Digital Learning Lab',
      organization: 'Future Skills Foundation',
      category: 'Technology',
      icon: Icons.computer_rounded,
      quantity: '15 laptops',
      location: 'Sathuvachari · 6.2 km',
      deadline: '05 Sep 2026',
      priority: 'High',
      progress: 0.67,
      fulfilled: '10 of 15 fulfilled',
      status: 'Active',
      matchCount: 8,
      description:
          'A structured requirement for working laptops to establish a digital learning lab for students.',
    ),
    _Requirement(
      title: 'Community Meal Support',
      organization: 'Green Campus Network',
      category: 'Food',
      icon: Icons.restaurant_rounded,
      quantity: '80 meals',
      location: 'Katpadi · 3.1 km',
      deadline: '25 Aug 2026',
      priority: 'Urgent',
      progress: 0.45,
      fulfilled: '36 of 80 fulfilled',
      status: 'Active',
      matchCount: 14,
      description:
          'Fresh surplus meals are required for volunteers participating in a local community programme.',
    ),
    _Requirement(
      title: 'Student Learning Materials',
      organization: 'Hope Community Centre',
      category: 'Education',
      icon: Icons.menu_book_rounded,
      quantity: '120 kits',
      location: 'Vellore · 2.4 km',
      deadline: '28 Aug 2026',
      priority: 'High',
      progress: 0.78,
      fulfilled: '94 of 120 fulfilled',
      status: 'Active',
      matchCount: 11,
      description:
          'Basic educational materials are needed for students attending the community centre.',
    ),
    _Requirement(
      title: 'First-Aid Outreach Kits',
      organization: 'CareLink Volunteers',
      category: 'Medical',
      icon: Icons.medical_services_rounded,
      quantity: '25 kits',
      location: 'Vellore · 4.8 km',
      deadline: '30 Aug 2026',
      priority: 'Medium',
      progress: 0.32,
      fulfilled: '8 of 25 fulfilled',
      status: 'Active',
      matchCount: 5,
      description:
          'Basic first-aid kits are required for upcoming community outreach activities.',
    ),
    _Requirement(
      title: 'Dry Ration Distribution',
      organization: 'Neighbourhood Relief Group',
      category: 'Food',
      icon: Icons.shopping_basket_rounded,
      quantity: '60 packs',
      location: 'Vellore · 7.4 km',
      deadline: '01 Sep 2026',
      priority: 'Medium',
      progress: 1,
      fulfilled: '60 of 60 fulfilled',
      status: 'Fulfilled',
      matchCount: 19,
      description:
          'Essential dry ration packs were collected and distributed to families requiring temporary support.',
    ),
  ];

  List<_Requirement> get _filteredRequirements {
    final query = _searchController.text.trim().toLowerCase();

    return _requirements.where((requirement) {
      final matchesSearch =
          query.isEmpty ||
          requirement.title.toLowerCase().contains(query) ||
          requirement.organization.toLowerCase().contains(query) ||
          requirement.category.toLowerCase().contains(query);

      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Urgent' &&
              requirement.priority == 'Urgent') ||
          (_selectedFilter == 'Active' &&
              requirement.status == 'Active') ||
          requirement.category == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
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

  void _showRequirementDetails(_Requirement requirement) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RequirementIcon(
                        icon: requirement.icon,
                        size: 60,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requirement.title,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              requirement.organization,
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 9),
                            _PriorityBadge(
                              priority: requirement.priority,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Requirement progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: requirement.progress,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        requirement.fulfilled,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(requirement.progress * 100).round()}%',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _DetailRow(
                    icon: Icons.category_outlined,
                    title: 'Category',
                    value: requirement.category,
                  ),
                  _DetailRow(
                    icon: Icons.inventory_2_outlined,
                    title: 'Target quantity',
                    value: requirement.quantity,
                  ),
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: requirement.location,
                  ),
                  _DetailRow(
                    icon: Icons.event_outlined,
                    title: 'Deadline',
                    value: requirement.deadline,
                  ),
                  _DetailRow(
                    icon: Icons.people_outline_rounded,
                    title: 'Potential matches',
                    value: '${requirement.matchCount} resources',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Requirement description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    requirement.description,
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
                              'Requirement added to your saved list.',
                            );
                          },
                          icon: const Icon(Icons.bookmark_border_rounded),
                          label: const Text('Save'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: requirement.status == 'Fulfilled'
                              ? null
                              : () {
                                  Navigator.pop(context);
                                  _showMessage(
                                    'You can now offer a matching resource.',
                                  );
                                },
                          icon: const Icon(
                            Icons.volunteer_activism_outlined,
                          ),
                          label: const Text('Contribute'),
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

  void _createRequirement() {
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
              5,
              20,
              MediaQuery.viewInsetsOf(context).bottom + 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Define a requirement',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create a structured requirement so ResourceX can find suitable matches.',
                  ),
                  const SizedBox(height: 22),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Requirement name',
                      hintText: 'Example: Laptops for digital lab',
                      prefixIcon: Icon(Icons.title_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Required quantity',
                      hintText: 'Example: 15',
                      prefixIcon: Icon(Icons.numbers_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: 'Technology',
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Technology',
                        child: Text('Technology'),
                      ),
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
                  const SizedBox(height: 14),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Preferred location',
                      hintText: 'Example: Vellore',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMessage(
                          'Requirement created and ready for matching.',
                        );
                      },
                      icon: const Icon(Icons.auto_awesome_rounded),
                      label: const Text('Create Requirement'),
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
    final requirements = _filteredRequirements;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createRequirement,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Requirement'),
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
                child: _buildFilters(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                child: _buildSummary(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'Requirements',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${requirements.length} active view',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            if (requirements.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyState(context),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList.separated(
                  itemCount: requirements.length,
                  itemBuilder: (context, index) {
                    return _buildRequirementCard(
                      context,
                      requirements[index],
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
                'Requirements',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Track what communities need and how close each requirement is to being fulfilled.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: _createRequirement,
          icon: const Icon(Icons.add_rounded),
          tooltip: 'Create requirement',
        ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search requirements or organisations',
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

  Widget _buildFilters() {
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

  Widget _buildSummary(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(
          alpha: 0.55,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.track_changes_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Fulfilment overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(
                  value: '24',
                  label: 'Active',
                  icon: Icons.pending_actions_rounded,
                ),
              ),
              Expanded(
                child: _SummaryMetric(
                  value: '7',
                  label: 'Urgent',
                  icon: Icons.priority_high_rounded,
                ),
              ),
              Expanded(
                child: _SummaryMetric(
                  value: '68%',
                  label: 'Fulfilled',
                  icon: Icons.check_circle_outline_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementCard(
    BuildContext context,
    _Requirement requirement,
  ) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => _showRequirementDetails(requirement),
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
                  _RequirementIcon(
                    icon: requirement.icon,
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _PriorityBadge(
                              priority: requirement.priority,
                            ),
                            const Spacer(),
                            if (requirement.status == 'Fulfilled')
                              const Icon(
                                Icons.verified_rounded,
                                size: 20,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          requirement.title,
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
                          requirement.organization,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    requirement.fulfilled,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${(requirement.progress * 100).round()}%',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: requirement.progress,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 14,
                runSpacing: 9,
                children: [
                  _InfoItem(
                    icon: Icons.inventory_2_outlined,
                    text: requirement.quantity,
                  ),
                  _InfoItem(
                    icon: Icons.location_on_outlined,
                    text: requirement.location,
                  ),
                  _InfoItem(
                    icon: Icons.event_outlined,
                    text: requirement.deadline,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 17,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        '${requirement.matchCount} potential resources can help',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 17,
                    ),
                  ],
                ),
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
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.track_changes_rounded,
                size: 37,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No requirements found',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Try another category or search for a different requirement.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Requirement {
  final String title;
  final String organization;
  final String category;
  final IconData icon;
  final String quantity;
  final String location;
  final String deadline;
  final String priority;
  final double progress;
  final String fulfilled;
  final String status;
  final int matchCount;
  final String description;

  const _Requirement({
    required this.title,
    required this.organization,
    required this.category,
    required this.icon,
    required this.quantity,
    required this.location,
    required this.deadline,
    required this.priority,
    required this.progress,
    required this.fulfilled,
    required this.status,
    required this.matchCount,
    required this.description,
  });
}

class _RequirementIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const _RequirementIcon({
    required this.icon,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: theme.colorScheme.secondary,
        size: size * 0.48,
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isUrgent = priority == 'Urgent';
    final isHigh = priority == 'High';

    final background = isUrgent
        ? theme.colorScheme.errorContainer
        : isHigh
            ? theme.colorScheme.tertiaryContainer
            : theme.colorScheme.secondaryContainer;

    final foreground = isUrgent
        ? theme.colorScheme.onErrorContainer
        : isHigh
            ? theme.colorScheme.onTertiaryContainer
            : theme.colorScheme.onSecondaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
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

class _SummaryMetric extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _SummaryMetric({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(
          icon,
          size: 21,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}