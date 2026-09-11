import 'package:flutter/material.dart';

class OrganizationWorkspaceScreen extends StatefulWidget {
  const OrganizationWorkspaceScreen({super.key});

  @override
  State<OrganizationWorkspaceScreen> createState() =>
      _OrganizationWorkspaceScreenState();
}

class _OrganizationWorkspaceScreenState
    extends State<OrganizationWorkspaceScreen> {
  int _selectedSection = 0;

  final List<_TeamMember> _teamMembers = [
    _TeamMember(
      name: 'Ananya Kumar',
      role: 'Organization Admin',
      initials: 'AK',
      status: 'Active',
    ),
    _TeamMember(
      name: 'Rahul Menon',
      role: 'Resource Coordinator',
      initials: 'RM',
      status: 'Active',
    ),
    _TeamMember(
      name: 'Priya Shah',
      role: 'Community Manager',
      initials: 'PS',
      status: 'Active',
    ),
    _TeamMember(
      name: 'Arjun Rao',
      role: 'Volunteer',
      initials: 'AR',
      status: 'Invited',
    ),
  ];

  final List<_OrganizationResource> _resources = [
    _OrganizationResource(
      title: 'Computer Lab Equipment',
      category: 'Electronics',
      quantity: '24 units',
      status: 'Available',
      icon: Icons.computer_rounded,
    ),
    _OrganizationResource(
      title: 'Student Learning Kits',
      category: 'Education',
      quantity: '85 kits',
      status: 'Partially Allocated',
      icon: Icons.school_rounded,
    ),
    _OrganizationResource(
      title: 'Office Chairs',
      category: 'Furniture',
      quantity: '36 units',
      status: 'Available',
      icon: Icons.chair_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Organization',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Organization notifications',
            onPressed: _showNotifications,
            icon: const Badge(
              label: Text('2'),
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          _buildOrganizationHeader(context),
          const SizedBox(height: 20),
          _buildOverview(context),
          const SizedBox(height: 24),
          _buildSectionSelector(context),
          const SizedBox(height: 18),
          _buildSelectedSection(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showQuickActionSheet,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Quick Action',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildOrganizationHeader(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.76),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.28),
                  ),
                ),
                child: const Icon(
                  Icons.apartment_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'VIT Community Hub',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Vellore • Education & Community',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _editOrganization,
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Verified organization with trusted exchange history',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Organization Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _overviewCard(
                context,
                '145',
                'Resources',
                Icons.inventory_2_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _overviewCard(
                context,
                '68',
                'Exchanges',
                Icons.swap_horizontal_circle_outlined,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _overviewCard(
                context,
                '1.8K',
                'People Reached',
                Icons.groups_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _overviewCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
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
            color: scheme.primary,
            size: 21,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSelector(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    const sections = [
      'Overview',
      'Resources',
      'Team',
      'Partnerships',
      'Impact',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sections.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = _selectedSection == index;

          return ChoiceChip(
            label: Text(sections[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedSection = index;
              });
            },
            selectedColor: scheme.primary,
            backgroundColor: scheme.surface,
            labelStyle: TextStyle(
              color: selected
                  ? scheme.onPrimary
                  : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
            side: BorderSide(
              color: selected
                  ? scheme.primary
                  : scheme.outlineVariant.withValues(alpha: 0.6),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedSection(BuildContext context) {
    switch (_selectedSection) {
      case 1:
        return _buildResourcesSection(context);
      case 2:
        return _buildTeamSection(context);
      case 3:
        return _buildPartnershipSection(context);
      case 4:
        return _buildImpactSection(context);
      default:
        return _buildOverviewSection(context);
    }
  }

  Widget _buildOverviewSection(BuildContext context) {
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today at a glance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _actionCard(
          context,
          Icons.auto_awesome_rounded,
          '12 smart matches',
          'ResourceX found new opportunities for your organization.',
          'Review',
          _showMatches,
        ),
        const SizedBox(height: 12),
        _actionCard(
          context,
          Icons.assignment_outlined,
          '5 active requirements',
          'Your organization currently needs resources from the network.',
          'View',
          _showRequirements,
        ),
        const SizedBox(height: 12),
        _actionCard(
          context,
          Icons.schedule_rounded,
          '3 exchanges scheduled',
          'Upcoming resource exchanges need coordination.',
          'Manage',
          _showExchanges,
        ),
        const SizedBox(height: 22),
        _buildActivitySection(context),
      ],
    );
  }

  Widget _actionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String buttonText,
    VoidCallback onPressed,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: scheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final activities = [
      (
        Icons.swap_horizontal_circle_outlined,
        'Exchange completed',
        '8 student kits were allocated',
        '1h ago',
      ),
      (
        Icons.person_add_alt_1_outlined,
        'New team member',
        'Arjun Rao accepted the invitation',
        '4h ago',
      ),
      (
        Icons.auto_awesome_outlined,
        'New match',
        'Computer equipment matched with a local NGO',
        'Yesterday',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Organization Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Column(
            children: List.generate(
              activities.length,
              (index) {
                final activity = activities[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  leading: CircleAvatar(
                    backgroundColor:
                        scheme.primaryContainer.withValues(alpha: 0.6),
                    child: Icon(
                      activity.$1,
                      color: scheme.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    activity.$2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  subtitle: Text(
                    activity.$3,
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: Text(
                    activity.$4,
                    style: TextStyle(
                      fontSize: 10,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResourcesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Managed Resources',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _addOrganizationResource,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._resources.map(
          (resource) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _resourceCard(context, resource),
          ),
        ),
        const SizedBox(height: 8),
        _infoBanner(
          context,
          Icons.auto_awesome_rounded,
          'Smart allocation insight',
          '14 resources could be matched with nearby requirements this week.',
        ),
      ],
    );
  }

  Widget _resourceCard(
    BuildContext context,
    _OrganizationResource resource,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showResourceDetails(resource),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  resource.icon,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${resource.category} • ${resource.quantity}',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      resource.status,
                      style: TextStyle(
                        color: resource.status == 'Available'
                            ? Colors.green
                            : Colors.orange,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Team Members',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: _inviteMember,
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Invite'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Column(
            children: List.generate(
              _teamMembers.length,
              (index) {
                final member = _teamMembers[index];

                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      leading: CircleAvatar(
                        radius: 22,
                        child: Text(
                          member.initials,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      title: Text(
                        member.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        member.role,
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: member.status == 'Active'
                                  ? Colors.green.withValues(alpha: 0.10)
                                  : Colors.orange.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              member.status,
                              style: TextStyle(
                                color: member.status == 'Active'
                                    ? Colors.green
                                    : Colors.orange,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index != _teamMembers.length - 1)
                      Divider(
                        height: 1,
                        indent: 70,
                        endIndent: 15,
                        color: scheme.outlineVariant.withValues(
                          alpha: 0.4,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 14),
        _infoBanner(
          context,
          Icons.security_outlined,
          'Team permissions',
          'Organization admins can control who manages resources, requirements and exchanges.',
        ),
      ],
    );
  }

  Widget _buildPartnershipSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community Partnerships',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _partnershipCard(
          context,
          'GreenSteps Foundation',
          'Environmental partner',
          '12 exchanges',
          Icons.eco_rounded,
        ),
        const SizedBox(height: 12),
        _partnershipCard(
          context,
          'Vellore Community Network',
          'Community partner',
          '8 exchanges',
          Icons.groups_rounded,
        ),
        const SizedBox(height: 12),
        _partnershipCard(
          context,
          'Local Learning Initiative',
          'Education partner',
          '17 exchanges',
          Icons.school_rounded,
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _discoverPartners,
            icon: const Icon(Icons.travel_explore_rounded),
            label: const Text('Discover New Partners'),
          ),
        ),
      ],
    );
  }

  Widget _partnershipCard(
    BuildContext context,
    String name,
    String type,
    String exchanges,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: scheme.secondary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  exchanges,
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$name partnership opened.'),
                ),
              );
            },
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.insights_rounded,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Organization Impact',
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                '1,842',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'people reached through resource exchanges',
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _impactMiniCard(
                      context,
                      '68',
                      'Exchanges',
                      Icons.swap_horizontal_circle_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _impactMiniCard(
                      context,
                      '420 kg',
                      'Waste diverted',
                      Icons.recycling_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Impact Highlights',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        _highlightRow(
          context,
          Icons.school_outlined,
          'Education',
          '1,120 learners supported',
        ),
        _highlightRow(
          context,
          Icons.recycling_outlined,
          'Circularity',
          '420 kg of materials reused',
        ),
        _highlightRow(
          context,
          Icons.groups_outlined,
          'Community',
          '34 local initiatives supported',
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _openImpactReport,
          icon: const Icon(Icons.assessment_outlined),
          label: const Text('View Full Impact Report'),
        ),
      ],
    );
  }

  Widget _impactMiniCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightRow(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.5),
        ),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBanner(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showQuickActionSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Organization Quick Actions',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                _sheetAction(
                  context,
                  Icons.inventory_2_outlined,
                  'Add Resource',
                  'Publish a resource for the network',
                  _addOrganizationResource,
                ),
                _sheetAction(
                  context,
                  Icons.assignment_outlined,
                  'Create Requirement',
                  'Tell the network what your organization needs',
                  _createRequirement,
                ),
                _sheetAction(
                  context,
                  Icons.person_add_alt_1_outlined,
                  'Invite Team Member',
                  'Add another member to your organization',
                  _inviteMember,
                ),
                _sheetAction(
                  context,
                  Icons.handshake_outlined,
                  'Find Partner',
                  'Discover organizations nearby',
                  _discoverPartners,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sheetAction(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 3),
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _editOrganization() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Organization profile editor opened.'),
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            children: const [
              Text(
                'Organization Notifications',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 15),
              ListTile(
                leading: Icon(Icons.auto_awesome_rounded),
                title: Text('New smart match'),
                subtitle: Text(
                  'Computer equipment has a potential local match.',
                ),
              ),
              ListTile(
                leading: Icon(Icons.schedule_rounded),
                title: Text('Exchange reminder'),
                subtitle: Text(
                  'A resource exchange is scheduled for tomorrow.',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMatches() {
    _showMessage('12 potential matches found for your organization.');
  }

  void _showRequirements() {
    _showMessage('5 active organization requirements.');
  }

  void _showExchanges() {
    _showMessage('3 upcoming exchanges require coordination.');
  }

  void _addOrganizationResource() {
    _showMessage('Resource creation workspace opened.');
  }

  void _createRequirement() {
    _showMessage('Requirement creation workspace opened.');
  }

  void _inviteMember() {
    _showMessage('Team member invitation form opened.');
  }

  void _discoverPartners() {
    _showMessage('Nearby organization discovery opened.');
  }

  void _showResourceDetails(_OrganizationResource resource) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(resource.icon),
                    ),
                    const SizedBox(width: 13),
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
                Text(
                  'Category: ${resource.category}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 7),
                Text(
                  'Quantity: ${resource.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 7),
                Text(
                  'Status: ${resource.status}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage('Resource management opened.');
                    },
                    icon: const Icon(Icons.settings_outlined),
                    label: const Text('Manage Resource'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openImpactReport() {
    _showMessage('Organization impact report opened.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class _TeamMember {
  final String name;
  final String role;
  final String initials;
  final String status;

  const _TeamMember({
    required this.name,
    required this.role,
    required this.initials,
    required this.status,
  });
}

class _OrganizationResource {
  final String title;
  final String category;
  final String quantity;
  final String status;
  final IconData icon;

  const _OrganizationResource({
    required this.title,
    required this.category,
    required this.quantity,
    required this.status,
    required this.icon,
  });
}