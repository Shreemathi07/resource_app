import 'package:flutter/material.dart';

import '../../app/app_theme.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({
    super.key,
    this.role = 'Resource Provider',
  });

  final String role;

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  late List<ResourceItem> _resources;
  String _selectedCategory = 'All';
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _resources = _resourcesForRole(widget.role);
  }

  List<ResourceItem> _resourcesForRole(String role) {
    if (role == 'Resource Seeker') {
      return [
        ResourceItem(
          name: 'Engineering Laptops',
          category: 'Electronics',
          quantity: 8,
          condition: 'Excellent',
          location: 'Vellore',
          description:
              'High-performance laptops available for students working on software projects, assignments and technical training.',
          availability: 'Available',
          owner: 'TechShare Community',
          purpose: 'Student Projects',
          verified: true,
        ),
        ResourceItem(
          name: 'Reference Books',
          category: 'Education',
          quantity: 35,
          condition: 'Good',
          location: 'Katpadi',
          description:
              'Academic reference books covering programming, mathematics, computer science and engineering subjects.',
          availability: 'Available',
          owner: 'Learning Circle',
          purpose: 'Academic Support',
          verified: true,
        ),
        ResourceItem(
          name: 'Projector System',
          category: 'Electronics',
          quantity: 2,
          condition: 'Good',
          location: 'Vellore',
          description:
              'Portable projector systems for workshops, presentations, student events and educational sessions.',
          availability: 'Limited',
          owner: 'Campus Connect',
          purpose: 'Events & Workshops',
          verified: true,
        ),
        ResourceItem(
          name: 'Drawing Equipment',
          category: 'Education',
          quantity: 15,
          condition: 'Good',
          location: 'Ranipet',
          description:
              'Drawing and technical-design equipment useful for engineering students and training programs.',
          availability: 'Available',
          owner: 'SkillBridge Foundation',
          purpose: 'Training',
          verified: false,
        ),
      ];
    }

    if (role == 'Organization') {
      return [
        ResourceItem(
          name: 'Community Computers',
          category: 'Electronics',
          quantity: 18,
          condition: 'Good',
          location: 'Vellore',
          description:
              'Computers maintained by the organization for digital literacy classes and community learning programs.',
          availability: 'Available',
          owner: 'Vellore Community Centre',
          purpose: 'Digital Literacy',
          verified: true,
        ),
        ResourceItem(
          name: 'Training Chairs',
          category: 'Furniture',
          quantity: 60,
          condition: 'Good',
          location: 'Katpadi',
          description:
              'Stackable chairs maintained for community workshops, awareness programs and training sessions.',
          availability: 'Available',
          owner: 'Community Development Unit',
          purpose: 'Community Programs',
          verified: true,
        ),
        ResourceItem(
          name: 'Science Lab Kit',
          category: 'Laboratory',
          quantity: 6,
          condition: 'Excellent',
          location: 'Vellore',
          description:
              'Educational laboratory kits used for school science demonstrations and practical learning.',
          availability: 'Limited',
          owner: 'STEM Outreach Team',
          purpose: 'STEM Education',
          verified: true,
        ),
        ResourceItem(
          name: 'Emergency Tool Kit',
          category: 'Tools & Equipment',
          quantity: 10,
          condition: 'Good',
          location: 'Gudiyatham',
          description:
              'Basic maintenance tool kits available for community facilities and local support activities.',
          availability: 'Available',
          owner: 'Rural Support Network',
          purpose: 'Community Maintenance',
          verified: false,
        ),
      ];
    }

    return [
      ResourceItem(
        name: 'Laptop Computers',
        category: 'Electronics',
        quantity: 12,
        condition: 'Good',
        location: 'Vellore',
        description:
            'Working laptops suitable for students, training centres and educational activities.',
        availability: 'Available',
        owner: 'My Resources',
        purpose: 'Education',
        verified: true,
      ),
      ResourceItem(
        name: 'Study Tables',
        category: 'Furniture',
        quantity: 8,
        condition: 'Good',
        location: 'Katpadi',
        description:
            'Reusable study tables suitable for classrooms, libraries and community learning spaces.',
        availability: 'Available',
        owner: 'My Resources',
        purpose: 'Learning Space',
        verified: true,
      ),
      ResourceItem(
        name: 'Laboratory Stools',
        category: 'Laboratory',
        quantity: 20,
        condition: 'Excellent',
        location: 'Vellore',
        description:
            'Durable laboratory stools suitable for schools, colleges and technical training centres.',
        availability: 'Available',
        owner: 'My Resources',
        purpose: 'Laboratory',
        verified: true,
      ),
      ResourceItem(
        name: 'Portable Projector',
        category: 'Electronics',
        quantity: 2,
        condition: 'Good',
        location: 'Vellore',
        description:
            'Portable projectors available for classrooms, presentations, workshops and community events.',
        availability: 'Limited',
        owner: 'My Resources',
        purpose: 'Presentations',
        verified: true,
      ),
    ];
  }

  List<String> get _categories {
    final values = <String>{'All'};

    for (final resource in _resources) {
      values.add(resource.category);
    }

    return values.toList();
  }

  List<ResourceItem> get _filteredResources {
    final query = _searchText.trim().toLowerCase();

    return _resources.where((resource) {
      final categoryMatch = _selectedCategory == 'All' ||
          resource.category == _selectedCategory;

      final searchMatch = query.isEmpty ||
          resource.name.toLowerCase().contains(query) ||
          resource.category.toLowerCase().contains(query) ||
          resource.location.toLowerCase().contains(query) ||
          resource.owner.toLowerCase().contains(query);

      return categoryMatch && searchMatch;
    }).toList();
  }

  bool get _isProvider => widget.role == 'Resource Provider';

  bool get _isSeeker => widget.role == 'Resource Seeker';

  bool get _isOrganization => widget.role == 'Organization';

  String get _title {
    if (_isSeeker) return 'Discover Resources';
    if (_isOrganization) return 'Community Inventory';
    return 'My Resources';
  }

  String get _headerTitle {
    if (_isSeeker) return 'Find what you need';
    if (_isOrganization) return 'Manage community resources';
    return 'Share what you have';
  }

  String get _headerDescription {
    if (_isSeeker) {
      return 'Discover useful resources shared by providers and organizations near you.';
    }

    if (_isOrganization) {
      return 'Monitor verified resources available across your community programs.';
    }

    return 'Add useful resources and make them available to people who need them.';
  }

  void _openAddResource() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddResourceScreen(
          onAdd: (resource) {
            setState(() {
              _resources.insert(
                0,
                resource.copyWith(
                  owner: 'My Resources',
                  verified: false,
                ),
              );
            });
          },
        ),
      ),
    );
  }

  void _openDetails(ResourceItem resource) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ResourceDetailsScreen(
          resource: resource,
          role: widget.role,
          onRequest: _isSeeker
              ? () => _requestResource(resource)
              : null,
        ),
      ),
    );
  }

  void _requestResource(ResourceItem resource) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Request sent for ${resource.name}.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteResource(ResourceItem resource) {
    setState(() {
      _resources.remove(resource);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resource removed successfully.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _editResource(ResourceItem resource) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddResourceScreen(
          existingResource: resource,
          onAdd: (updated) {
            final index = _resources.indexOf(resource);

            if (index != -1) {
              setState(() {
                _resources[index] = updated.copyWith(
                  owner: resource.owner,
                  verified: resource.verified,
                );
              });
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final resources = _filteredResources;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          if (_isProvider)
            IconButton(
              tooltip: 'Add resource',
              onPressed: _openAddResource,
              icon: const Icon(
                Icons.add_circle_outline_rounded,
              ),
            ),
          const SizedBox(width: 6),
        ],
      ),
      floatingActionButton: _isProvider
          ? FloatingActionButton.extended(
              onPressed: _openAddResource,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Add Resource',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: _buildHeader(scheme),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: _isSeeker
                      ? 'Search resources, providers...'
                      : 'Search resources...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon: _searchText.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchText = '';
                            });
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final selected =
                        category == _selectedCategory;

                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (selected) {
                        if (!selected) return;

                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              24,
              20,
              12,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isSeeker
                          ? 'Available Near You'
                          : _isOrganization
                              ? 'Community Resources'
                              : 'My Resources',
                      style:
                          theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    '${resources.length} items',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (resources.isEmpty)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                120,
              ),
              sliver: SliverToBoxAdapter(
                child: _EmptyResources(
                  isSeeker: _isSeeker,
                  onAdd: _openAddResource,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                120,
              ),
              sliver: SliverList.separated(
                itemCount: resources.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final resource = resources[index];

                  return _ResourceCard(
                    resource: resource,
                    role: widget.role,
                    onTap: () {
                      _openDetails(resource);
                    },
                    onEdit: _isProvider
                        ? () => _editResource(resource)
                        : null,
                    onDelete: _isProvider
                        ? () => _deleteResource(resource)
                        : null,
                    onRequest: _isSeeker
                        ? () => _requestResource(resource)
                        : null,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme scheme) {
    final IconData icon;

    if (_isSeeker) {
      icon = Icons.travel_explore_rounded;
    } else if (_isOrganization) {
      icon = Icons.business_rounded;
    } else {
      icon = Icons.inventory_2_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: scheme.primaryContainer,
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: scheme.primary,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _headerTitle,
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _headerDescription,
                  style: TextStyle(
                    color: scheme.onPrimaryContainer
                        .withValues(alpha: 0.75),
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
}

class _ResourceCard extends StatelessWidget {
  const _ResourceCard({
    required this.resource,
    required this.role,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    this.onRequest,
  });

  final ResourceItem resource;
  final String role;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onRequest;

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.devices_rounded;
      case 'Furniture':
        return Icons.chair_rounded;
      case 'Laboratory':
        return Icons.science_outlined;
      case 'Tools & Equipment':
        return Icons.build_outlined;
      case 'Education':
        return Icons.school_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSeeker = role == 'Resource Seeker';
    final isOrganization = role == 'Organization';

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Icon(
                      _categoryIcon(resource.category),
                      color: AppColors.primary,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                resource.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (resource.verified)
                              Icon(
                                Icons.verified_rounded,
                                size: 18,
                                color: scheme.primary,
                              ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          resource.category,
                          style: TextStyle(
                            color: scheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 15,
                              color: scheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${resource.quantity} available',
                              style: TextStyle(
                                color: scheme.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: scheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                resource.location,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:
                                      scheme.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _SmallTag(
                    text: resource.condition,
                  ),
                  const SizedBox(width: 7),
                  _SmallTag(
                    text: resource.availability,
                    highlighted:
                        resource.availability == 'Available',
                  ),
                  const Spacer(),
                  if (isSeeker && onRequest != null)
                    TextButton.icon(
                      onPressed: onRequest,
                      icon: const Icon(
                        Icons.send_outlined,
                        size: 17,
                      ),
                      label: const Text('Request'),
                    ),
                  if (isOrganization)
                    _SmallTag(
                      text: resource.verified
                          ? 'Verified'
                          : 'Review',
                      highlighted: resource.verified,
                    ),
                  if (onEdit != null)
                    IconButton(
                      tooltip: 'Edit',
                      onPressed: onEdit,
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                      ),
                    ),
                  if (onDelete != null)
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  const _SmallTag({
    required this.text,
    this.highlighted = false,
  });

  final String text;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.primaryLight
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: highlighted
              ? AppColors.primary
              : scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({
    super.key,
    required this.onAdd,
    this.existingResource,
  });

  final ValueChanged<ResourceItem> onAdd;
  final ResourceItem? existingResource;

  @override
  State<AddResourceScreen> createState() =>
      _AddResourceScreenState();
}

class _AddResourceScreenState
    extends State<AddResourceScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _locationController;
  late final TextEditingController _descriptionController;

  late String _category;
  late String _condition;
  late String _availability;

  final List<String> _categories = [
    'Electronics',
    'Furniture',
    'Laboratory',
    'Tools & Equipment',
    'Education',
    'Other',
  ];

  final List<String> _conditions = [
    'Excellent',
    'Good',
    'Fair',
    'Needs Repair',
  ];

  final List<String> _availabilityOptions = [
    'Available',
    'Limited',
    'Coming Soon',
  ];

  bool get _isEditing => widget.existingResource != null;

  @override
  void initState() {
    super.initState();

    final resource = widget.existingResource;

    _nameController = TextEditingController(
      text: resource?.name ?? '',
    );

    _quantityController = TextEditingController(
      text: resource?.quantity.toString() ?? '',
    );

    _locationController = TextEditingController(
      text: resource?.location ?? '',
    );

    _descriptionController = TextEditingController(
      text: resource?.description ?? '',
    );

    _category = resource?.category ?? 'Electronics';
    _condition = resource?.condition ?? 'Good';
    _availability =
        resource?.availability ?? 'Available';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final old = widget.existingResource;

    final resource = ResourceItem(
      name: _nameController.text.trim(),
      category: _category,
      quantity:
          int.tryParse(_quantityController.text.trim()) ?? 1,
      condition: _condition,
      location: _locationController.text.trim(),
      description: _descriptionController.text.trim(),
      availability: _availability,
      owner: old?.owner ?? 'My Resources',
      purpose: old?.purpose ?? 'Community Sharing',
      verified: old?.verified ?? false,
    );

    widget.onAdd(resource);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Resource updated successfully.'
              : 'Resource added successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? 'Edit Resource'
              : 'Add Resource',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            32,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    _isEditing
                        ? Icons.edit_note_rounded
                        : Icons.add_box_outlined,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _isEditing
                          ? 'Update your resource information.'
                          : 'Add something useful that others can discover and reuse.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _Field(
              controller: _nameController,
              label: 'Resource name',
              hint: 'Example: Desktop Computers',
              icon: Icons.inventory_2_outlined,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter a resource name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _DropdownField(
              label: 'Category',
              icon: Icons.category_outlined,
              value: _category,
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _category = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _Field(
              controller: _quantityController,
              label: 'Quantity',
              hint: 'Example: 5',
              icon: Icons.numbers_rounded,
              keyboardType: TextInputType.number,
              validator: (value) {
                final quantity =
                    int.tryParse(value?.trim() ?? '');

                if (quantity == null || quantity <= 0) {
                  return 'Enter a valid quantity';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            _DropdownField(
              label: 'Condition',
              icon: Icons.health_and_safety_outlined,
              value: _condition,
              items: _conditions,
              onChanged: (value) {
                setState(() {
                  _condition = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _Field(
              controller: _locationController,
              label: 'Location',
              hint: 'Example: Vellore',
              icon: Icons.location_on_outlined,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the resource location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _DropdownField(
              label: 'Availability',
              icon: Icons.event_available_outlined,
              value: _availability,
              items: _availabilityOptions,
              onChanged: (value) {
                setState(() {
                  _availability = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _Field(
              controller: _descriptionController,
              label: 'Description',
              hint:
                  'Describe the resource and how it can be used...',
              icon: Icons.description_outlined,
              maxLines: 5,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(
                  _isEditing
                      ? Icons.save_outlined
                      : Icons.add_rounded,
                ),
                label: Text(
                  _isEditing
                      ? 'Save Changes'
                      : 'Add Resource',
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
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      textInputAction: maxLines > 1
          ? TextInputAction.newline
          : TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: maxLines == 1
            ? Icon(icon)
            : Padding(
                padding: const EdgeInsets.only(
                  bottom: 72,
                ),
                child: Icon(icon),
              ),
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class ResourceDetailsScreen extends StatelessWidget {
  const ResourceDetailsScreen({
    super.key,
    required this.resource,
    required this.role,
    this.onRequest,
  });

  final ResourceItem resource;
  final String role;
  final VoidCallback? onRequest;

  IconData _icon(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.devices_rounded;
      case 'Furniture':
        return Icons.chair_rounded;
      case 'Laboratory':
        return Icons.science_outlined;
      case 'Tools & Equipment':
        return Icons.build_outlined;
      case 'Education':
        return Icons.school_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isSeeker = role == 'Resource Seeker';
    final isOrganization = role == 'Organization';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resource Details',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          20,
          16,
          20,
          32,
        ),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Icon(
              _icon(resource.category),
              size: 68,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: Text(
                  resource.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (resource.verified)
                Icon(
                  Icons.verified_rounded,
                  color: scheme.primary,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            resource.category,
            style: TextStyle(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _DetailBox(
                  icon: Icons.inventory_2_outlined,
                  title: 'Quantity',
                  value: '${resource.quantity}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DetailBox(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Condition',
                  value: resource.condition,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _DetailBox(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  value: resource.location,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DetailBox(
                  icon: Icons.event_available_outlined,
                  title: 'Status',
                  value: resource.availability,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'About this resource',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            resource.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.55,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          _InfoRow(
            icon: Icons.person_outline_rounded,
            title: 'Provided by',
            value: resource.owner,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.flag_outlined,
            title: 'Primary purpose',
            value: resource.purpose,
          ),
          const SizedBox(height: 28),
          if (isSeeker && onRequest != null)
            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: onRequest,
                icon: const Icon(Icons.send_outlined),
                label: const Text(
                  'Request This Resource',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    isOrganization
                        ? Icons.verified_outlined
                        : Icons.handshake_outlined,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isOrganization
                          ? 'This resource is part of the community inventory.'
                          : 'People with matching requirements can discover this resource.',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: scheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBox extends StatelessWidget {
  const _DetailBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: scheme.primary,
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
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyResources extends StatelessWidget {
  const _EmptyResources({
    required this.isSeeker,
    required this.onAdd,
  });

  final bool isSeeker;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 38,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            isSeeker
                ? 'No matching resources'
                : 'No resources found',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            isSeeker
                ? 'Try another search or category.'
                : 'Try another search or add your first resource.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
            ),
          ),
          if (!isSeeker) ...[
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Resource'),
            ),
          ],
        ],
      ),
    );
  }
}

class ResourceItem {
  const ResourceItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.condition,
    required this.location,
    required this.description,
    required this.availability,
    this.owner = 'My Resources',
    this.purpose = 'Community Sharing',
    this.verified = false,
  });

  final String name;
  final String category;
  final int quantity;
  final String condition;
  final String location;
  final String description;
  final String availability;
  final String owner;
  final String purpose;
  final bool verified;

  ResourceItem copyWith({
    String? name,
    String? category,
    int? quantity,
    String? condition,
    String? location,
    String? description,
    String? availability,
    String? owner,
    String? purpose,
    bool? verified,
  }) {
    return ResourceItem(
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      location: location ?? this.location,
      description: description ?? this.description,
      availability: availability ?? this.availability,
      owner: owner ?? this.owner,
      purpose: purpose ?? this.purpose,
      verified: verified ?? this.verified,
    );
  }
}