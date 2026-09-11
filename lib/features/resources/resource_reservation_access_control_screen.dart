import 'package:flutter/material.dart';

class ResourceReservationAccessControlScreen extends StatefulWidget {
  const ResourceReservationAccessControlScreen({super.key});

  @override
  State<ResourceReservationAccessControlScreen> createState() =>
      _ResourceReservationAccessControlScreenState();
}

class _ResourceReservationAccessControlScreenState
    extends State<ResourceReservationAccessControlScreen> {
  int selectedTab = 0;
  String selectedRole = 'All';
  String searchQuery = '';

  final List<String> tabs = [
    'Overview',
    'Permissions',
    'Roles',
    'Audit',
  ];

  final List<String> roles = [
    'All',
    'Provider',
    'Seeker',
    'Organization',
    'Coordinator',
  ];

  final List<Map<String, dynamic>> accessRecords = [
    {
      'name': 'VIT Resource Center',
      'role': 'Provider',
      'description': 'Can create, approve and manage resource reservations.',
      'permissions': 8,
      'total': 8,
      'status': 'Active',
      'icon': Icons.inventory_2_outlined,
      'color': Colors.indigo,
    },
    {
      'name': 'Student Community',
      'role': 'Seeker',
      'description': 'Can discover resources and manage own reservations.',
      'permissions': 6,
      'total': 7,
      'status': 'Active',
      'icon': Icons.person_outline_rounded,
      'color': Colors.teal,
    },
    {
      'name': 'VIT Sustainability Cell',
      'role': 'Organization',
      'description': 'Can manage shared resources and community exchanges.',
      'permissions': 9,
      'total': 9,
      'status': 'Active',
      'icon': Icons.groups_outlined,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Resource Coordinator',
      'role': 'Coordinator',
      'description': 'Can review conflicts and coordinate reservation workflows.',
      'permissions': 10,
      'total': 10,
      'status': 'Active',
      'icon': Icons.manage_accounts_outlined,
      'color': Colors.orange,
    },
    {
      'name': 'Innovation Club',
      'role': 'Organization',
      'description': 'Limited access to selected community resources.',
      'permissions': 5,
      'total': 9,
      'status': 'Restricted',
      'icon': Icons.business_outlined,
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> permissions = [
    {
      'title': 'Create Reservation',
      'description': 'Create a reservation request for an available resource.',
      'category': 'Reservation',
      'enabled': true,
      'icon': Icons.add_circle_outline_rounded,
      'color': Colors.indigo,
    },
    {
      'title': 'Approve Reservation',
      'description': 'Approve reservation requests for managed resources.',
      'category': 'Reservation',
      'enabled': true,
      'icon': Icons.check_circle_outline_rounded,
      'color': Colors.green,
    },
    {
      'title': 'Modify Reservation',
      'description': 'Change reservation dates, times and pickup details.',
      'category': 'Reservation',
      'enabled': true,
      'icon': Icons.edit_calendar_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Cancel Reservation',
      'description': 'Cancel an active or scheduled reservation.',
      'category': 'Reservation',
      'enabled': true,
      'icon': Icons.cancel_outlined,
      'color': Colors.red,
    },
    {
      'title': 'Manage Resource',
      'description': 'Update availability, condition and resource details.',
      'category': 'Resource',
      'enabled': true,
      'icon': Icons.inventory_2_outlined,
      'color': Colors.teal,
    },
    {
      'title': 'View Audit Records',
      'description': 'Access reservation activity and security history.',
      'category': 'Security',
      'enabled': false,
      'icon': Icons.history_rounded,
      'color': Colors.deepPurple,
    },
  ];

  final List<Map<String, dynamic>> auditRecords = [
    {
      'action': 'Permission Granted',
      'actor': 'Resource Coordinator',
      'target': 'VIT Resource Center',
      'time': 'Today, 11:32 AM',
      'status': 'Approved',
      'icon': Icons.lock_open_outlined,
      'color': Colors.green,
    },
    {
      'action': 'Access Restricted',
      'actor': 'System',
      'target': 'Innovation Club',
      'time': 'Today, 9:48 AM',
      'status': 'Restricted',
      'icon': Icons.lock_outline_rounded,
      'color': Colors.red,
    },
    {
      'action': 'Role Updated',
      'actor': 'Platform Admin',
      'target': 'Student Community',
      'time': 'Yesterday, 4:18 PM',
      'status': 'Updated',
      'icon': Icons.manage_accounts_outlined,
      'color': Colors.indigo,
    },
    {
      'action': 'Permission Reviewed',
      'actor': 'Security Monitor',
      'target': 'VIT Sustainability Cell',
      'time': 'Yesterday, 1:42 PM',
      'status': 'Verified',
      'icon': Icons.fact_check_outlined,
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Access Control',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          IconButton(
            onPressed: refreshData,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(),
                const SizedBox(height: 18),
                _buildStats(),
                const SizedBox(height: 18),
                _buildSearch(),
                const SizedBox(height: 12),
                _buildRoleFilters(),
                const SizedBox(height: 16),
                _buildTabs(),
                const SizedBox(height: 18),
                _buildSelectedTab(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateAccess,
        icon: const Icon(
          Icons.add_moderator_outlined,
        ),
        label: const Text(
          'Access Rule',
        ),
      ),
    );
  }

  Widget _buildHero() {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            Colors.deepPurple.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Protected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Reservation Access Control',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Control who can create, approve, modify and manage resource reservations across the ResourceX network.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _heroMetric(
                '97%',
                'Access health',
              ),
              _heroMetric(
                '4',
                'Active roles',
              ),
              _heroMetric(
                '42',
                'Rules',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.70),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          _statItem(
            '42',
            'Rules',
            Icons.rule_folder_outlined,
            Colors.indigo,
          ),
          _statItem(
            '4',
            'Roles',
            Icons.groups_outlined,
            Colors.deepPurple,
          ),
          _statItem(
            '97%',
            'Secure',
            Icons.shield_outlined,
            Colors.green,
          ),
          _statItem(
            '3',
            'Restricted',
            Icons.block_outlined,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _statItem(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 18,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search member, role or permission',
        prefixIcon: const Icon(
          Icons.search_rounded,
        ),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    searchQuery = '';
                  });
                },
                icon: const Icon(
                  Icons.clear_rounded,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildRoleFilters() {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: roles.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final role = roles[index];
          final selected = selectedRole == role;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedRole = role;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                ),
              ),
              child: Text(
                role,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.grey.shade700,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedTab == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedTab() {
    switch (selectedTab) {
      case 1:
        return _buildPermissions();
      case 2:
        return _buildRoles();
      case 3:
        return _buildAudit();
      default:
        return _buildOverview();
    }
  }

  Widget _buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Access Health',
          'Current reservation permission status',
          Icons.security_outlined,
        ),
        const SizedBox(height: 14),
        _buildAccessHealth(),
        const SizedBox(height: 20),
        _sectionTitle(
          'Smart Access Recommendations',
          'Improve reservation security',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _recommendationCard(
          'Review restricted organizations',
          'Some organizations have limited access to reservation actions.',
          Icons.groups_outlined,
          Colors.orange,
        ),
        _recommendationCard(
          'Enable audit visibility',
          'Coordinator accounts can benefit from reservation audit access.',
          Icons.history_rounded,
          Colors.indigo,
        ),
        _recommendationCard(
          'Keep role permissions minimal',
          'Only grant permissions required for each reservation workflow.',
          Icons.lock_outline_rounded,
          Colors.green,
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Active Access',
          'Current role-based access assignments',
          Icons.admin_panel_settings_outlined,
        ),
        const SizedBox(height: 12),
        ...accessRecords.take(4).map(_buildAccessCard),
      ],
    );
  }

  Widget _buildAccessHealth() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 92,
                    height: 92,
                    child: CircularProgressIndicator(
                      value: 0.97,
                      strokeWidth: 9,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.indigo,
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '97',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Score',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strong Access Protection',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Reservation permissions are mostly aligned with member roles and security policies.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _healthMetric(
                '98%',
                'Role match',
                Colors.green,
              ),
              _healthMetric(
                '96%',
                'Least access',
                Colors.indigo,
              ),
              _healthMetric(
                '94%',
                'Reviewed',
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthMetric(
    String value,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessCard(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;
    final progress =
        (item['permissions'] as int) / (item['total'] as int);

    return GestureDetector(
      onTap: () => _showAccessDetails(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: color,
                size: 21,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['name'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      _statusBadge(
                        item['status'].toString(),
                        item['status'] == 'Active'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['role'].toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['description'].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${item['permissions']}/${item['total']}',
                        style: TextStyle(
                          color: color,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissions() {
    final filtered = permissions.where((item) {
      final query = searchQuery.toLowerCase();

      return query.isEmpty ||
          item['title'].toString().toLowerCase().contains(query) ||
          item['description'].toString().toLowerCase().contains(query);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Permission Matrix',
          '${filtered.length} available access controls',
          Icons.grid_view_rounded,
        ),
        const SizedBox(height: 14),
        ...filtered.map(_buildPermissionCard),
        const SizedBox(height: 18),
        _buildPermissionInfo(),
      ],
    );
  }

  Widget _buildPermissionCard(
    Map<String, dynamic> permission,
  ) {
    final color = permission['color'] as Color;
    final enabled = permission['enabled'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: enabled
              ? Colors.grey.shade200
              : Colors.orange.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              permission['icon'] as IconData,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  permission['title'].toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  permission['description'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  permission['category'].toString(),
                  style: TextStyle(
                    color: color,
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (_) {
              _showSnackBar(
                '${permission['title']} permission updated',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionInfo() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: 0.12),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.indigo,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Text(
              'ResourceX uses role-based permissions so members only receive the reservation actions required for their responsibilities.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 9,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Role Management',
          'Reservation access by user role',
          Icons.groups_outlined,
        ),
        const SizedBox(height: 14),
        _roleCard(
          'Resource Provider',
          'Manages resources and reservation approvals.',
          '8 permissions',
          Icons.inventory_2_outlined,
          Colors.indigo,
        ),
        _roleCard(
          'Resource Seeker',
          'Discovers resources and manages own requests.',
          '6 permissions',
          Icons.person_outline_rounded,
          Colors.teal,
        ),
        _roleCard(
          'Organization',
          'Manages shared resources and community exchanges.',
          '9 permissions',
          Icons.groups_outlined,
          Colors.deepPurple,
        ),
        _roleCard(
          'Coordinator',
          'Coordinates conflicts, approvals and fulfillment.',
          '10 permissions',
          Icons.manage_accounts_outlined,
          Colors.orange,
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Role Intelligence',
          'Smart access recommendations',
          Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _recommendationCard(
          'Coordinator access is optimal',
          'Coordinator permissions currently cover all critical reservation workflows.',
          Icons.verified_outlined,
          Colors.green,
        ),
        _recommendationCard(
          'Seeker access can remain limited',
          'Seekers only need access to their own reservation lifecycle.',
          Icons.lock_outline_rounded,
          Colors.indigo,
        ),
      ],
    );
  }

  Widget _roleCard(
    String title,
    String description,
    String permissionsText,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        _showSnackBar(
          '$title role selected',
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    permissionsText,
                    style: TextStyle(
                      color: color,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Access Audit Trail',
          'Recent permission and role activity',
          Icons.history_rounded,
        ),
        const SizedBox(height: 14),
        ...auditRecords.map(_buildAuditCard),
        const SizedBox(height: 18),
        _buildAuditSummary(),
      ],
    );
  }

  Widget _buildAuditCard(
    Map<String, dynamic> record,
  ) {
    final color = record['color'] as Color;

    return GestureDetector(
      onTap: () => _showAuditDetails(record),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                record['icon'] as IconData,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          record['action'].toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      _statusBadge(
                        record['status'].toString(),
                        color,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    record['target'].toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${record['actor']} • ${record['time']}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditSummary() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Access Activity Summary',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          _summaryRow(
            'Permissions granted',
            '18',
            Colors.green,
          ),
          _summaryRow(
            'Permissions reviewed',
            '27',
            Colors.indigo,
          ),
          _summaryRow(
            'Access restrictions',
            '3',
            Colors.orange,
          ),
          _summaryRow(
            'Security incidents',
            '0',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 10,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendationCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9,
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

  Widget _statusBadge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 7,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAccessDetails(
    Map<String, dynamic> item,
  ) {
    final color = item['color'] as Color;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetHandle(),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: color.withValues(alpha: 0.10),
                    child: Icon(
                      item['icon'] as IconData,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item['name'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.groups_outlined,
                'Role',
                item['role'].toString(),
              ),
              _detailRow(
                Icons.security_outlined,
                'Access',
                '${item['permissions']}/${item['total']} permissions',
              ),
              _detailRow(
                Icons.verified_outlined,
                'Status',
                item['status'].toString(),
              ),
              const SizedBox(height: 8),
              Text(
                item['description'].toString(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Access permissions opened',
                        );
                      },
                      child: const Text(
                        'Permissions',
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Access settings updated',
                        );
                      },
                      child: const Text(
                        'Manage Access',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAuditDetails(
    Map<String, dynamic> record,
  ) {
    final color = record['color'] as Color;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetHandle(),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: color.withValues(alpha: 0.10),
                    child: Icon(
                      record['icon'] as IconData,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      record['action'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _detailRow(
                Icons.person_outline,
                'Actor',
                record['actor'].toString(),
              ),
              _detailRow(
                Icons.shield_outlined,
                'Target',
                record['target'].toString(),
              ),
              _detailRow(
                Icons.schedule_outlined,
                'Time',
                record['time'].toString(),
              ),
              _detailRow(
                Icons.verified_outlined,
                'Status',
                record['status'].toString(),
              ),
              const SizedBox(height: 15),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  _showSnackBar(
                    'Audit record marked for review',
                  );
                },
                icon: const Icon(
                  Icons.fact_check_outlined,
                ),
                label: const Text(
                  'Mark for Review',
                ),
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sheetHandle() {
    return Center(
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showCreateAccess() {
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
        String selectedNewRole = 'Provider';

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).viewInsets.bottom + 25,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sheetHandle(),
                    const SizedBox(height: 18),
                    const Text(
                      'Create Access Rule',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Define a new reservation access rule for a role.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Rule name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedNewRole,
                      decoration: InputDecoration(
                        labelText: 'Role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      items: roles
                          .where((role) => role != 'All')
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedNewRole = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Permissions',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _sheetPermission(
                      'Create reservation',
                      true,
                    ),
                    _sheetPermission(
                      'Modify reservation',
                      true,
                    ),
                    _sheetPermission(
                      'Cancel reservation',
                      true,
                    ),
                    _sheetPermission(
                      'Approve reservation',
                      false,
                    ),
                    const SizedBox(height: 15),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _showSnackBar(
                          'Access rule created for $selectedNewRole',
                        );
                      },
                      icon: const Icon(
                        Icons.add_moderator_outlined,
                      ),
                      label: const Text(
                        'Create Access Rule',
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

  Widget _sheetPermission(
    String title,
    bool enabled,
  ) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: enabled,
      onChanged: (_) {},
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _showNotifications() {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Access Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationItem(
                  Icons.lock_outline_rounded,
                  'Innovation Club access was restricted',
                  '14 minutes ago',
                  Colors.red,
                ),
                _notificationItem(
                  Icons.verified_outlined,
                  'Coordinator permissions reviewed',
                  '1 hour ago',
                  Colors.green,
                ),
                _notificationItem(
                  Icons.manage_accounts_outlined,
                  'Student Community role updated',
                  'Yesterday',
                  Colors.indigo,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _notificationItem(
    IconData icon,
    String title,
    String time,
    Color color,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.09),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        time,
        style: const TextStyle(
          fontSize: 9,
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> refreshData() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    _showSnackBar(
      'Access control refreshed',
    );
  }
}