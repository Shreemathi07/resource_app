import 'package:flutter/material.dart';

class ResourceSafetyComplianceScreen extends StatefulWidget {
  const ResourceSafetyComplianceScreen({super.key});

  @override
  State<ResourceSafetyComplianceScreen> createState() =>
      _ResourceSafetyComplianceScreenState();
}

class _ResourceSafetyComplianceScreenState
    extends State<ResourceSafetyComplianceScreen> {
  int selectedTab = 0;
  String selectedRisk = 'All';
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> safetyChecks = [
    {
      'title': 'Medical Equipment Safety',
      'resource': 'Portable Oxygen Concentrator',
      'score': 96,
      'status': 'Safe',
      'lastChecked': '2 days ago',
      'nextCheck': 'In 28 days',
      'icon': Icons.medical_services_rounded,
    },
    {
      'title': 'Electrical Safety',
      'resource': 'Community Generator',
      'score': 88,
      'status': 'Review Soon',
      'lastChecked': '5 days ago',
      'nextCheck': 'In 10 days',
      'icon': Icons.electrical_services_rounded,
    },
    {
      'title': 'Food Storage Safety',
      'resource': 'Emergency Food Kits',
      'score': 94,
      'status': 'Safe',
      'lastChecked': '1 week ago',
      'nextCheck': 'In 21 days',
      'icon': Icons.restaurant_rounded,
    },
    {
      'title': 'Transport Safety',
      'resource': 'Delivery Van',
      'score': 79,
      'status': 'Attention',
      'lastChecked': '3 days ago',
      'nextCheck': 'Due now',
      'icon': Icons.local_shipping_rounded,
    },
  ];

  final List<Map<String, dynamic>> complianceItems = [
    {
      'title': 'Identity Verification',
      'description': 'Provider identity and organization details',
      'status': 'Verified',
      'progress': 1.0,
      'icon': Icons.verified_user_rounded,
    },
    {
      'title': 'Resource Documentation',
      'description': 'Ownership and authenticity documents',
      'status': 'Complete',
      'progress': 1.0,
      'icon': Icons.description_rounded,
    },
    {
      'title': 'Safety Certification',
      'description': 'Current safety certificate availability',
      'status': 'Valid',
      'progress': 0.92,
      'icon': Icons.workspace_premium_rounded,
    },
    {
      'title': 'Usage Guidelines',
      'description': 'Instructions and responsible-use requirements',
      'status': 'Review',
      'progress': 0.72,
      'icon': Icons.menu_book_rounded,
    },
  ];

  final List<Map<String, dynamic>> risks = [
    {
      'title': 'Maintenance overdue',
      'resource': 'Delivery Van',
      'severity': 'High',
      'description':
          'Scheduled maintenance has passed the recommended inspection date.',
      'icon': Icons.build_circle_rounded,
    },
    {
      'title': 'Certificate renewal',
      'resource': 'Community Generator',
      'severity': 'Medium',
      'description':
          'Safety certification will require renewal within the next month.',
      'icon': Icons.event_available_rounded,
    },
    {
      'title': 'Usage guideline missing',
      'resource': 'Power Tools Set',
      'severity': 'Low',
      'description':
          'Recommended operating instructions have not been uploaded.',
      'icon': Icons.menu_book_rounded,
    },
  ];

  final List<Map<String, dynamic>> certificates = [
    {
      'title': 'Electrical Safety Certificate',
      'resource': 'Community Generator',
      'validUntil': '18 Oct 2026',
      'status': 'Valid',
      'icon': Icons.electric_bolt_rounded,
    },
    {
      'title': 'Equipment Safety Certificate',
      'resource': 'Portable Oxygen Concentrator',
      'validUntil': '12 Dec 2026',
      'status': 'Valid',
      'icon': Icons.health_and_safety_rounded,
    },
    {
      'title': 'Vehicle Safety Inspection',
      'resource': 'Delivery Van',
      'validUntil': '08 Sep 2026',
      'status': 'Renew Soon',
      'icon': Icons.directions_car_rounded,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text(
          'Safety & Compliance',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Safety notifications',
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            tooltip: 'Information',
            onPressed: _showInformation,
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSafetyHero(scheme),
                  const SizedBox(height: 18),
                  _buildSearchBar(scheme),
                  const SizedBox(height: 16),
                  _buildTabs(scheme),
                  const SizedBox(height: 18),
                  if (selectedTab == 0) _buildOverview(scheme),
                  if (selectedTab == 1) _buildSafetyChecks(scheme),
                  if (selectedTab == 2) _buildCompliance(scheme),
                  if (selectedTab == 3) _buildRisks(scheme),
                  const SizedBox(height: 90),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showSafetyActions,
        icon: const Icon(Icons.shield_rounded),
        label: const Text('Safety Actions'),
      ),
    );
  }

  Widget _buildSafetyHero(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.18),
            blurRadius: 24,
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
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 29,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Protected',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Safety Score',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '92',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7, left: 5),
                child: Text(
                  '/100',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.92,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.16),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Your resource network is operating within a strong safety range.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme scheme) {
    return TextField(
      controller: searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search resources, checks or certificates...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: _showFilters,
          icon: const Icon(Icons.tune_rounded),
        ),
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTabs(ColorScheme scheme) {
    const tabs = [
      'Overview',
      'Safety Checks',
      'Compliance',
      'Risks',
    ];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final selected = selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedTab = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    color: selected ? scheme.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: scheme.shadow.withValues(alpha: 0.08),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          selected ? FontWeight.w800 : FontWeight.w600,
                      color: selected
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverview(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Safety Overview',
          'Monitor the protection level of your resources.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildStatsGrid(scheme),
        const SizedBox(height: 18),
        _buildAttentionCard(scheme),
        const SizedBox(height: 18),
        _sectionTitle(
          'Safety Signals',
          'Important indicators from your resource network.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildSignalList(scheme),
        const SizedBox(height: 18),
        _sectionTitle(
          'Smart Recommendations',
          'Actions that can improve your safety score.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildRecommendation(
          scheme,
          Icons.build_circle_rounded,
          'Schedule vehicle maintenance',
          'One resource has passed its recommended maintenance date.',
          'High priority',
        ),
        const SizedBox(height: 10),
        _buildRecommendation(
          scheme,
          Icons.description_rounded,
          'Upload missing guidelines',
          'Adding operating instructions improves responsible usage.',
          'Recommended',
        ),
        const SizedBox(height: 18),
        _buildCertificatesPreview(scheme),
      ],
    );
  }

  Widget _buildStatsGrid(ColorScheme scheme) {
    final stats = [
      ('Safe Resources', '38', Icons.verified_rounded),
      ('Checks Passed', '46', Icons.check_circle_rounded),
      ('Open Risks', '3', Icons.warning_amber_rounded),
      ('Certificates', '12', Icons.workspace_premium_rounded),
    ];

    return GridView.builder(
      itemCount: stats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (context, index) {
        final item = stats[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.42),
            borderRadius: BorderRadius.circular(21),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                item.$3,
                color: scheme.primary,
                size: 23,
              ),
              const Spacer(),
              Text(
                item.$2,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                item.$1,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttentionCard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: scheme.error.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_rounded,
            color: scheme.error,
            size: 27,
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3 safety items need attention',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Review the open risks before accepting new exchange requests.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showRiskDetails(risks.first),
            child: const Text('Review'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignalList(ColorScheme scheme) {
    final signals = [
      (
        Icons.shield_rounded,
        'Protection coverage',
        '96% of active resources have completed safety checks.',
        0.96
      ),
      (
        Icons.assignment_turned_in_rounded,
        'Compliance readiness',
        '92% of required compliance items are complete.',
        0.92
      ),
      (
        Icons.update_rounded,
        'Inspection freshness',
        '89% of inspections were completed within schedule.',
        0.89
      ),
    ];

    return Column(
      children: signals.map((signal) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  signal.$1,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      signal.$2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      signal.$3,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: signal.$4,
                        minHeight: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecommendation(
    ColorScheme scheme,
    IconData icon,
    String title,
    String description,
    String label,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showRecommendation(title, description),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.primaryContainer.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: scheme.primary,
              size: 27,
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
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: scheme.primary,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 11,
                      height: 1.35,
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

  Widget _buildCertificatesPreview(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Safety Certificates',
          'Recently verified safety documents.',
          scheme,
        ),
        const SizedBox(height: 12),
        ...certificates.take(2).map(
              (certificate) => _certificateCard(certificate, scheme),
            ),
      ],
    );
  }

  Widget _buildSafetyChecks(ColorScheme scheme) {
    final query = searchController.text.trim().toLowerCase();

    final filtered = safetyChecks.where((item) {
      if (query.isEmpty) return true;

      return item['title'].toString().toLowerCase().contains(query) ||
          item['resource'].toString().toLowerCase().contains(query);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Safety Inspections',
          '${filtered.length} checks currently tracked',
          scheme,
        ),
        const SizedBox(height: 12),
        if (filtered.isEmpty)
          _buildEmptyState(
            scheme,
            Icons.search_off_rounded,
            'No safety checks found',
            'Try another search term.',
          )
        else
          ...filtered.map(
            (item) => _inspectionCard(item, scheme),
          ),
      ],
    );
  }

  Widget _inspectionCard(
    Map<String, dynamic> item,
    ColorScheme scheme,
  ) {
    final score = item['score'] as int;
    final status = item['status'] as String;
    final statusColor =
        status == 'Safe' ? scheme.primary : scheme.error;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => _showInspectionDetails(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.36),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.32),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['resource'] as String,
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$score',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _miniInfo(
                    scheme,
                    Icons.history_rounded,
                    'Checked',
                    item['lastChecked'] as String,
                  ),
                ),
                Expanded(
                  child: _miniInfo(
                    scheme,
                    Icons.event_repeat_rounded,
                    'Next',
                    item['nextCheck'] as String,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompliance(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Compliance Center',
          'Track documentation and safety requirements.',
          scheme,
        ),
        const SizedBox(height: 12),
        ...complianceItems.map(
          (item) => _complianceCard(item, scheme),
        ),
        const SizedBox(height: 18),
        _sectionTitle(
          'Safety Certificates',
          'Documents linked to verified resources.',
          scheme,
        ),
        const SizedBox(height: 12),
        ...certificates.map(
          (certificate) => _certificateCard(certificate, scheme),
        ),
        const SizedBox(height: 18),
        _buildGuidelinesCard(scheme),
      ],
    );
  }

  Widget _complianceCard(
    Map<String, dynamic> item,
    ColorScheme scheme,
  ) {
    final progress = item['progress'] as double;
    final status = item['status'] as String;

    return InkWell(
      borderRadius: BorderRadius.circular(21),
      onTap: () => _showComplianceDetails(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: scheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: scheme.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['description'] as String,
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  status,
                  style: TextStyle(
                    color: progress >= 0.9
                        ? scheme.primary
                        : scheme.error,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _certificateCard(
    Map<String, dynamic> certificate,
    ColorScheme scheme,
  ) {
    final valid = certificate['status'] == 'Valid';

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showCertificateDetails(certificate),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.32),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                certificate['icon'] as IconData,
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    certificate['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    certificate['resource'] as String,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Valid until ${certificate['validUntil']}',
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 10,
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
                color: (valid ? scheme.primary : scheme.error)
                    .withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                certificate['status'] as String,
                style: TextStyle(
                  color: valid ? scheme.primary : scheme.error,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelinesCard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: scheme.secondary,
            size: 29,
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety Guidelines',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Review recommended practices for safe resource exchanges.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showGuidelines,
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildRisks(ColorScheme scheme) {
    final filtered = selectedRisk == 'All'
        ? risks
        : risks.where((risk) => risk['severity'] == selectedRisk).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Risk Detection',
          'Identify issues before they affect an exchange.',
          scheme,
        ),
        const SizedBox(height: 12),
        _buildRiskFilters(scheme),
        const SizedBox(height: 14),
        _buildRiskAnalytics(scheme),
        const SizedBox(height: 16),
        if (filtered.isEmpty)
          _buildEmptyState(
            scheme,
            Icons.shield_outlined,
            'No risks found',
            'There are no risks under this filter.',
          )
        else
          ...filtered.map(
            (risk) => _riskCard(risk, scheme),
          ),
        const SizedBox(height: 12),
        _buildHazardReportCard(scheme),
      ],
    );
  }

  Widget _buildRiskFilters(ColorScheme scheme) {
    const filters = ['All', 'High', 'Medium', 'Low'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final selected = selectedRisk == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: selected,
              onSelected: (_) {
                setState(() => selectedRisk = filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRiskAnalytics(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Risk Distribution',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          _riskBar(scheme, 'High', 1, 3),
          _riskBar(scheme, 'Medium', 1, 3),
          _riskBar(scheme, 'Low', 1, 3),
        ],
      ),
    );
  }

  Widget _riskBar(
    ColorScheme scheme,
    String label,
    int value,
    int total,
  ) {
    final progress = value / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          SizedBox(
            width: 58,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _riskCard(
    Map<String, dynamic> risk,
    ColorScheme scheme,
  ) {
    final severity = risk['severity'] as String;
    final color = severity == 'High'
        ? scheme.error
        : severity == 'Medium'
            ? scheme.secondary
            : scheme.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(21),
      onTap: () => _showRiskDetails(risk),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: color.withValues(alpha: 0.18),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                risk['icon'] as IconData,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    risk['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    risk['resource'] as String,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    risk['description'] as String,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                severity,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHazardReportCard(ColorScheme scheme) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: _showHazardReport,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: scheme.errorContainer.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          children: [
            Icon(Icons.report_problem_rounded),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report a Safety Hazard',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Flag a resource or exchange that may require review.',
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
    ColorScheme scheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _miniInfo(
    ColorScheme scheme,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: scheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 9,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    ColorScheme scheme,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 42,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 44,
            color: scheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showSafetyActions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Safety Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                _actionTile(
                  sheetContext,
                  Icons.fact_check_rounded,
                  'Start Safety Inspection',
                  'Perform a new resource safety check.',
                  _startInspection,
                ),
                _actionTile(
                  sheetContext,
                  Icons.workspace_premium_rounded,
                  'Add Certificate',
                  'Upload a safety certificate.',
                  _addCertificate,
                ),
                _actionTile(
                  sheetContext,
                  Icons.report_problem_rounded,
                  'Report Hazard',
                  'Flag a safety concern.',
                  _showHazardReport,
                ),
                _actionTile(
                  sheetContext,
                  Icons.menu_book_rounded,
                  'View Guidelines',
                  'Review safe exchange practices.',
                  _showGuidelines,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionTile(
    BuildContext sheetContext,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback action,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(sheetContext);
        action();
      },
    );
  }

  void _showInspectionDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item['resource'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _detailRow(
                  Icons.shield_rounded,
                  'Safety score',
                  '${item['score']}/100',
                ),
                _detailRow(
                  Icons.check_circle_rounded,
                  'Status',
                  item['status'] as String,
                ),
                _detailRow(
                  Icons.history_rounded,
                  'Last checked',
                  item['lastChecked'] as String,
                ),
                _detailRow(
                  Icons.event_repeat_rounded,
                  'Next check',
                  item['nextCheck'] as String,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _startInspection();
                    },
                    icon: const Icon(Icons.fact_check_rounded),
                    label: const Text('Run Inspection'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showComplianceDetails(Map<String, dynamic> item) {
    _showSimpleDetails(
      title: item['title'] as String,
      icon: item['icon'] as IconData,
      details: [
        item['description'] as String,
        'Current status: ${item['status']}',
        'Completion: ${((item['progress'] as double) * 100).round()}%',
      ],
    );
  }

  void _showCertificateDetails(Map<String, dynamic> certificate) {
    _showSimpleDetails(
      title: certificate['title'] as String,
      icon: certificate['icon'] as IconData,
      details: [
        'Resource: ${certificate['resource']}',
        'Status: ${certificate['status']}',
        'Valid until: ${certificate['validUntil']}',
      ],
    );
  }

  void _showRiskDetails(Map<String, dynamic> risk) {
    _showSimpleDetails(
      title: risk['title'] as String,
      icon: risk['icon'] as IconData,
      details: [
        'Resource: ${risk['resource']}',
        'Severity: ${risk['severity']}',
        risk['description'] as String,
      ],
      actionLabel: 'Resolve Risk',
      onAction: _resolveRisk,
    );
  }

  void _showSimpleDetails({
    required String title,
    required IconData icon,
    required List<String> details,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ...details.map(
                  (detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            detail,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (actionLabel != null && onAction != null) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        onAction();
                      },
                      child: Text(actionLabel),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRecommendation(String title, String description) {
    _showSimpleDetails(
      title: title,
      icon: Icons.auto_awesome_rounded,
      details: [
        description,
        'Completing this action can improve your ResourceX safety readiness.',
      ],
      actionLabel: 'Mark as Planned',
      onAction: () {
        _showSnackBar('Recommendation added to your safety plan.');
      },
    );
  }

  void _showNotifications() {
    _showSimpleDetails(
      title: 'Safety Notifications',
      icon: Icons.notifications_rounded,
      details: [
        '1 high-priority maintenance reminder',
        '1 certificate renewal reminder',
        '1 missing usage guideline',
      ],
    );
  }

  void _showInformation() {
    _showSimpleDetails(
      title: 'Safety & Compliance',
      icon: Icons.info_outline_rounded,
      details: [
        'Safety Score combines inspection, compliance and risk signals.',
        'Certificates help establish resource readiness.',
        'Risk alerts highlight issues that should be reviewed before exchanges.',
      ],
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Safety Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: const Icon(Icons.shield_rounded),
                  title: const Text('Highest safety score'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() => selectedTab = 1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.warning_amber_rounded),
                  title: const Text('Resources needing attention'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() {
                      selectedTab = 3;
                      selectedRisk = 'All';
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium_rounded),
                  title: const Text('Certificates'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() => selectedTab = 2);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGuidelines() {
    _showSimpleDetails(
      title: 'Safety Guidelines',
      icon: Icons.menu_book_rounded,
      details: [
        'Verify resource condition before every exchange.',
        'Keep safety certificates and documentation current.',
        'Provide clear usage instructions for shared equipment.',
        'Report hazards as soon as they are identified.',
        'Confirm that the receiving party understands safe usage requirements.',
      ],
    );
  }

  void _showHazardReport() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Report Safety Hazard'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Describe the safety concern...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showSnackBar('Safety hazard report submitted.');
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _startInspection() {
    _showSnackBar('New safety inspection started.');
  }

  void _addCertificate() {
    _showSnackBar('Certificate upload flow opened.');
  }

  void _resolveRisk() {
    _showSnackBar('Risk moved to your resolution checklist.');
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {});
    _showSnackBar('Safety data refreshed.');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Widget _detailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
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
}