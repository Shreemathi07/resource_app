import 'package:flutter/material.dart';

class ResourceItem {
  const ResourceItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.condition,
    required this.location,
    required this.availability,
    required this.description,
    required this.owner,
  });

  final String name;
  final String category;
  final String quantity;
  final String condition;
  final String location;
  final String availability;
  final String description;
  final String owner;
}

class AddResourceScreen extends StatefulWidget {
  const AddResourceScreen({
    super.key,
    this.existingResource,
  });

  final ResourceItem? existingResource;

  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}

class _AddResourceScreenState extends State<AddResourceScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _locationController;
  late final TextEditingController _descriptionController;

  String _category = 'Electronics';
  String _condition = 'Good';
  String _availability = 'Available now';

  final List<String> _categories = const [
    'Electronics',
    'Education',
    'Furniture',
    'Healthcare',
    'Clothing',
    'Food',
    'Tools',
    'Sports',
    'Other',
  ];

  final List<String> _conditions = const [
    'New',
    'Like new',
    'Good',
    'Used',
    'Needs repair',
  ];

  final List<String> _availabilityOptions = const [
    'Available now',
    'Available this week',
    'Available this month',
    'By appointment',
  ];

  @override
  void initState() {
    super.initState();

    final resource = widget.existingResource;

    _nameController = TextEditingController(
      text: resource?.name ?? '',
    );

    _quantityController = TextEditingController(
      text: resource?.quantity ?? '',
    );

    _locationController = TextEditingController(
      text: resource?.location ?? '',
    );

    _descriptionController = TextEditingController(
      text: resource?.description ?? '',
    );

    if (resource != null) {
      _category = resource.category;
      _condition = resource.condition;
      _availability = resource.availability;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.existingResource != null;

  void _publishResource() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final resource = ResourceItem(
      name: _nameController.text.trim(),
      category: _category,
      quantity: _quantityController.text.trim(),
      condition: _condition,
      location: _locationController.text.trim(),
      availability: _availability,
      description: _descriptionController.text.trim(),
      owner: 'My Resource',
    );

    Navigator.of(context).pop(resource);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Resource' : 'Add Resource',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          children: [
            _buildHeader(scheme),
            const SizedBox(height: 24),
            _buildSectionTitle(
              'Resource information',
              'Tell others what you are offering.',
            ),
            const SizedBox(height: 14),
            _buildNameField(),
            const SizedBox(height: 14),
            _buildCategoryField(),
            const SizedBox(height: 14),
            _buildQuantityField(),
            const SizedBox(height: 24),
            _buildSectionTitle(
              'Condition & availability',
              'Help people understand when and how it can be used.',
            ),
            const SizedBox(height: 14),
            _buildConditionField(),
            const SizedBox(height: 14),
            _buildAvailabilityField(),
            const SizedBox(height: 24),
            _buildSectionTitle(
              'Location',
              'Add the area where the resource can be collected.',
            ),
            const SizedBox(height: 14),
            _buildLocationField(),
            const SizedBox(height: 24),
            _buildSectionTitle(
              'Description',
              'Add useful information for potential seekers.',
            ),
            const SizedBox(height: 14),
            _buildDescriptionField(),
            const SizedBox(height: 28),
            _buildPreviewCard(scheme),
            const SizedBox(height: 28),
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _publishResource,
                icon: Icon(
                  _isEditing
                      ? Icons.save_rounded
                      : Icons.publish_rounded,
                ),
                label: Text(
                  _isEditing
                      ? 'Save Changes'
                      : 'Publish Resource',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(35),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share something useful',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Your resource can help someone nearby.',
                  style: TextStyle(
                    color: Colors.white70,
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

  Widget _buildSectionTitle(
    String title,
    String subtitle,
  ) {
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
            fontSize: 12,
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Resource name',
        hintText: 'Example: Dell laptops',
        prefixIcon: Icon(Icons.inventory_2_outlined),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter the resource name';
        }

        if (value.trim().length < 2) {
          return 'Enter a valid resource name';
        }

        return null;
      },
    );
  }

  Widget _buildCategoryField() {
    return DropdownButtonFormField<String>(
      initialValue: _category,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category_outlined),
      ),
      items: _categories
          .map(
            (category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }

        setState(() {
          _category = value;
        });
      },
    );
  }

  Widget _buildQuantityField() {
    return TextFormField(
      controller: _quantityController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Quantity',
        hintText: 'Example: 10',
        prefixIcon: Icon(Icons.numbers_rounded),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter the quantity';
        }

        final quantity = int.tryParse(value.trim());

        if (quantity == null || quantity <= 0) {
          return 'Enter a valid quantity';
        }

        return null;
      },
    );
  }

  Widget _buildConditionField() {
    return DropdownButtonFormField<String>(
      initialValue: _condition,
      decoration: const InputDecoration(
        labelText: 'Condition',
        prefixIcon: Icon(Icons.fact_check_outlined),
      ),
      items: _conditions
          .map(
            (condition) => DropdownMenuItem<String>(
              value: condition,
              child: Text(condition),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }

        setState(() {
          _condition = value;
        });
      },
    );
  }

  Widget _buildAvailabilityField() {
    return DropdownButtonFormField<String>(
      initialValue: _availability,
      decoration: const InputDecoration(
        labelText: 'Availability',
        prefixIcon: Icon(Icons.event_available_outlined),
      ),
      items: _availabilityOptions
          .map(
            (option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }

        setState(() {
          _availability = value;
        });
      },
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      controller: _locationController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Location',
        hintText: 'Example: Katpadi, Vellore',
        prefixIcon: Icon(Icons.location_on_outlined),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter the location';
        }

        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 5,
      maxLength: 500,
      decoration: const InputDecoration(
        labelText: 'Description',
        hintText:
            'Explain what the resource can be used for...',
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: 75),
          child: Icon(Icons.description_outlined),
        ),
        alignLabelWithHint: true,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Add a short description';
        }

        if (value.trim().length < 10) {
          return 'Please provide a little more information';
        }

        return null;
      },
    );
  }

  Widget _buildPreviewCard(ColorScheme scheme) {
    final name = _nameController.text.trim();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: scheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _categoryIcon(_category),
              color: scheme.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Listing preview',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name.isEmpty
                      ? 'Your resource name'
                      : name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$_category • $_condition • $_availability',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.devices_rounded;
      case 'Education':
        return Icons.menu_book_rounded;
      case 'Furniture':
        return Icons.chair_rounded;
      case 'Healthcare':
        return Icons.medical_services_outlined;
      case 'Clothing':
        return Icons.checkroom_rounded;
      case 'Food':
        return Icons.restaurant_outlined;
      case 'Tools':
        return Icons.handyman_outlined;
      case 'Sports':
        return Icons.sports_soccer_rounded;
      default:
        return Icons.inventory_2_rounded;
    }
  }
}