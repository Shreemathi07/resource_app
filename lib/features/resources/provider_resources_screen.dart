import 'package:flutter/material.dart';

class ProviderResourcesScreen extends StatefulWidget {
  const ProviderResourcesScreen({super.key});

  @override
  State<ProviderResourcesScreen> createState() =>
      _ProviderResourcesScreenState();
}

class _ProviderResourcesScreenState extends State<ProviderResourcesScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';

  final List<_ProviderResource> _resources = [
    _ProviderResource(
      title: 'Laptop Computers',
      category: 'Electronics',
      quantity: '8 units',
      status: 'Available',
      location: 'Vellore',
      description:
          'Good-condition laptops available for educational and community use.',
      icon: Icons.laptop_mac_rounded,
      color: Colors.indigo,
      views: 124,
      matches: 7,
    ),
    _ProviderResource(
      title: 'Engineering Textbooks',
      category: 'Education',
      quantity: '32 books',
      status: 'Matched',
      location: 'Katpadi',
      description:
          'Engineering and programming books available for students.',
      icon: Icons.menu_book_rounded,
      color: Colors.orange,
      views: 89,
      matches: 5,
    ),
    _ProviderResource(
      title: 'Reusable Office Furniture',
      category: 'Furniture',
      quantity: '14 items',
      status: 'Available',
      location: 'Vellore',
      description:
          'Tables, chairs and storage units available for organizations.',
      icon: Icons.chair_rounded,
      color: Colors.teal,
      views: 67,
      matches: 3,
    ),
    _ProviderResource(
      title: 'School Stationery Kits',
      category: 'Education',
      quantity: '50 kits',
      status: 'Reserved',
      location: 'Ranipet',
      description:
          'Stationery kits prepared for students through a community initiative.',
      icon: Icons.edit_note_rounded,
      color: Colors.pink,
      views: 156,
      matches: 9,
    ),
    _ProviderResource(
      title: 'Medical Camp Supplies',
      category: 'Healthcare',
      quantity: '24 boxes',
      status: 'Available',
      location: 'Vellore',
      description:
          'Non-prescription medical camp supplies for approved community events.',
      icon: Icons.medical_services_rounded,
      color: Colors.red,
      views: 73,
      matches: 4,
    ),
  ];

  List<_ProviderResource> get _filteredResources {
    List<_ProviderResource> result = _resources.where((resource) {
      final query = _searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          resource.title.toLowerCase().contains(query) ||
          resource.category.toLowerCase().contains(query) ||
          resource.location.toLowerCase().contains(query);

      bool matchesTab;

      switch (_selectedTab) {
        case 1:
          matchesTab = resource.status == 'Available';
          break;
        case 2:
          matchesTab = resource.status == 'Matched';
          break;
        case 3:
          matchesTab = resource.status == 'Reserved';
          break;
        default:
          matchesTab = true;
      }

      return matchesSearch && matchesTab;
    }).toList();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _filteredResources;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'My Resources',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Analytics',
            onPressed: _showAnalytics,
            icon: const Icon(Icons.analytics_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshResources,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            _buildIntroCard(context),
            const SizedBox(height: 20),
            _buildStats(context),
            const SizedBox(height: 24),
            _buildSearchBar(context),
            const SizedBox(height: 14),
            _buildTabs(context),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _selectedTab == 0
                      ? 'All resources'
                      : _tabTitles[_selectedTab],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  '${filtered.length} items',
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              _buildEmptyState(context)
            else
              ...filtered.map(
                (resource) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _buildResourceCard(context, resource),
                ),
              ),
            const SizedBox(height: 8),
            _buildSmartSuggestion(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddResourceSheet,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Resource',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  final List<String> _tabTitles = [
    'All',
    'Available',
    'Matched',
    'Reserved',
  ];

  Widget _buildIntroCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.inventory_2_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Provider Workspace',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Turn surplus into impact.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Manage what you can share and let ResourceX find the right people.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    height: 1.4,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _showAddResourceSheet,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: scheme.primary,
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Share something'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.volunteer_activism_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            context,
            '5',
            'Resources',
            Icons.inventory_2_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            context,
            '18',
            'Matches',
            Icons.auto_awesome_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            context,
            '437',
            'Views',
            Icons.visibility_outlined,
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 21,
            color: scheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return TextField(
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search your resources...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                  });
                },
                icon: const Icon(Icons.clear_rounded),
              )
            : IconButton(
                tooltip: 'Filters',
                onPressed: _showFilters,
                icon: const Icon(Icons.tune_rounded),
              ),
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: scheme.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabTitles.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedTab == index;

          return ChoiceChip(
            label: Text(_tabTitles[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedTab = index;
              });
            },
            labelStyle: TextStyle(
              color: selected
                  ? scheme.onPrimary
                  : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: scheme.primary,
            backgroundColor: scheme.surface,
            side: BorderSide(
              color: selected
                  ? scheme.primary
                  : scheme.outlineVariant.withValues(alpha: 0.65),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    _ProviderResource resource,
  ) {
    final scheme = Theme.of(context).colorScheme;

    Color statusColor;

    switch (resource.status) {
      case 'Matched':
        statusColor = Colors.blue;
        break;
      case 'Reserved':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.green;
    }

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        borderRadius: BorderRadius.circular(21),
        onTap: () => _showResourceDetails(resource),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: resource.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      resource.icon,
                      color: resource.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${resource.category} • ${resource.quantity}',
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: scheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              resource.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      _handleResourceAction(value, resource);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Edit'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'pause',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.pause_circle_outline),
                          title: Text('Pause listing'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.delete_outline),
                          title: Text('Remove'),
                        ),
                      ),
                    ],
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
                  color: scheme.surfaceContainerHighest.withValues(
                    alpha: 0.45,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      resource.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.visibility_outlined,
                      size: 15,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${resource.views}',
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.auto_awesome_outlined,
                      size: 15,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${resource.matches}',
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                      ),
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

  Widget _buildSmartSuggestion(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: scheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ResourceX suggestion',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your laptops have 7 potential matches nearby. Updating availability may increase successful exchanges.',
                  style: TextStyle(
                    color: scheme.onSurface,
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Smart matching insights opened.',
                        ),
                      ),
                    );
                  },
                  child: const Text('View insights'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: scheme.primary,
          ),
          const SizedBox(height: 14),
          const Text(
            'No resources found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another search or add a new resource.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _showAddResourceSheet,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add resource'),
          ),
        ],
      ),
    );
  }

  void _showResourceDetails(_ProviderResource resource) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: resource.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Icon(
                        resource.icon,
                        color: resource.color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        resource.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _detailRow(
                  Icons.category_outlined,
                  'Category',
                  resource.category,
                ),
                _detailRow(
                  Icons.inventory_2_outlined,
                  'Quantity',
                  resource.quantity,
                ),
                _detailRow(
                  Icons.location_on_outlined,
                  'Location',
                  resource.location,
                ),
                _detailRow(
                  Icons.flag_outlined,
                  'Status',
                  resource.status,
                ),
                const SizedBox(height: 12),
                Text(
                  resource.description,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showEditDialog(resource);
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Resource shared successfully.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share_outlined),
                        label: const Text('Share'),
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

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: scheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            '$title:',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddResourceSheet() {
    final titleController = TextEditingController();
    final quantityController = TextEditingController();
    final locationController = TextEditingController();

    String category = 'Electronics';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                MediaQuery.viewInsetsOf(context).bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Share a Resource',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tell ResourceX what you have available.',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Resource name',
                        hintText: 'Example: Laptops',
                        prefixIcon: Icon(Icons.inventory_2_outlined),
                      ),
                    ),
                    const SizedBox(height: 13),
                    DropdownButtonFormField<String>(
                      initialValue: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Electronics',
                          child: Text('Electronics'),
                        ),
                        DropdownMenuItem(
                          value: 'Education',
                          child: Text('Education'),
                        ),
                        DropdownMenuItem(
                          value: 'Furniture',
                          child: Text('Furniture'),
                        ),
                        DropdownMenuItem(
                          value: 'Healthcare',
                          child: Text('Healthcare'),
                        ),
                        DropdownMenuItem(
                          value: 'Food',
                          child: Text('Food'),
                        ),
                        DropdownMenuItem(
                          value: 'Clothing',
                          child: Text('Clothing'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            category = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              prefixIcon:
                                  Icon(Icons.numbers_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: locationController,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              prefixIcon:
                                  Icon(Icons.location_on_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter a resource name.',
                                ),
                              ),
                            );
                            return;
                          }

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(this.context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${titleController.text.trim()} added to your resources.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Publish Resource'),
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

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resource Filters',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: const Text('Available resources'),
                  subtitle: const Text(
                    'Show resources currently open for matching',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.auto_awesome_outlined),
                  title: const Text('Matched resources'),
                  subtitle: const Text(
                    'Resources that already have potential matches',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedTab = 2;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark_outline),
                  title: const Text('Reserved resources'),
                  subtitle: const Text(
                    'Resources currently reserved for an exchange',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedTab = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleResourceAction(
    String action,
    _ProviderResource resource,
  ) {
    switch (action) {
      case 'edit':
        _showEditDialog(resource);
        break;
      case 'pause':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${resource.title} listing paused.'),
          ),
        );
        break;
      case 'delete':
        _confirmDelete(resource);
        break;
    }
  }

  void _showEditDialog(_ProviderResource resource) {
    final controller = TextEditingController(text: resource.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Resource'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Resource name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('Resource details updated.'),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(_ProviderResource resource) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove resource?'),
          content: Text(
            'Are you sure you want to remove "${resource.title}" from your listings?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('Resource removed from listings.'),
                  ),
                );
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _showAnalytics() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Provider Analytics',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                _analyticsRow(
                  Icons.visibility_outlined,
                  'Total views',
                  '437',
                ),
                _analyticsRow(
                  Icons.auto_awesome_outlined,
                  'Potential matches',
                  '18',
                ),
                _analyticsRow(
                  Icons.swap_horizontal_circle_outlined,
                  'Successful exchanges',
                  '11',
                ),
                _analyticsRow(
                  Icons.public_outlined,
                  'Estimated community reach',
                  '126 people',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _analyticsRow(
    IconData icon,
    String title,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: scheme.primary,
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
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshResources() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resources refreshed.'),
      ),
    );
  }
}

class _ProviderResource {
  final String title;
  final String category;
  final String quantity;
  final String status;
  final String location;
  final String description;
  final IconData icon;
  final Color color;
  final int views;
  final int matches;

  const _ProviderResource({
    required this.title,
    required this.category,
    required this.quantity,
    required this.status,
    required this.location,
    required this.description,
    required this.icon,
    required this.color,
    required this.views,
    required this.matches,
  });
}