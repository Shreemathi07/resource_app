import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _matchAlerts = true;
  bool _exchangeUpdates = true;
  bool _impactUpdates = true;
  bool _nearbyAlerts = true;
  bool _urgentNeeds = true;

  bool _smartMatching = true;
  bool _verifiedOnly = false;
  bool _showAvailability = true;

  bool _profileVisible = true;
  bool _showLocation = true;
  bool _showImpactStats = true;

  bool _biometricLock = false;

  String _radius = '10 km';
  String _language = 'English';
  String _appearance = 'System default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8FC),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          _buildSettingsIntro(),
          const SizedBox(height: 20),

          _buildSection(
            title: 'Notifications',
            icon: Icons.notifications_active_rounded,
            children: [
              _buildSwitchTile(
                icon: Icons.notifications_rounded,
                title: 'Push notifications',
                subtitle: 'Receive important ResourceX updates',
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.auto_awesome_rounded,
                title: 'Smart match alerts',
                subtitle: 'Notify me when a strong match is found',
                value: _matchAlerts,
                onChanged: (value) {
                  setState(() {
                    _matchAlerts = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.handshake_rounded,
                title: 'Exchange updates',
                subtitle: 'Updates about active resource exchanges',
                value: _exchangeUpdates,
                onChanged: (value) {
                  setState(() {
                    _exchangeUpdates = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.eco_rounded,
                title: 'Impact updates',
                subtitle: 'Weekly impact and contribution summaries',
                value: _impactUpdates,
                onChanged: (value) {
                  setState(() {
                    _impactUpdates = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.near_me_rounded,
                title: 'Nearby opportunities',
                subtitle: 'Resources and needs available nearby',
                value: _nearbyAlerts,
                onChanged: (value) {
                  setState(() {
                    _nearbyAlerts = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.priority_high_rounded,
                title: 'Urgent requirements',
                subtitle: 'Alert me about time-sensitive needs',
                value: _urgentNeeds,
                onChanged: (value) {
                  setState(() {
                    _urgentNeeds = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSection(
            title: 'Smart Matching',
            icon: Icons.psychology_rounded,
            children: [
              _buildSwitchTile(
                icon: Icons.auto_awesome_rounded,
                title: 'Smart matching',
                subtitle: 'Let ResourceX recommend relevant connections',
                value: _smartMatching,
                onChanged: (value) {
                  setState(() {
                    _smartMatching = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.verified_user_rounded,
                title: 'Prioritize verified members',
                subtitle: 'Show trusted connections first',
                value: _verifiedOnly,
                onChanged: (value) {
                  setState(() {
                    _verifiedOnly = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.inventory_2_rounded,
                title: 'Show availability',
                subtitle: 'Include resources currently available',
                value: _showAvailability,
                onChanged: (value) {
                  setState(() {
                    _showAvailability = value;
                  });
                },
              ),
              _buildActionTile(
                icon: Icons.radar_rounded,
                title: 'Discovery radius',
                subtitle: 'Currently set to $_radius',
                onTap: _showRadiusSheet,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSection(
            title: 'Privacy & Visibility',
            icon: Icons.shield_rounded,
            children: [
              _buildSwitchTile(
                icon: Icons.visibility_rounded,
                title: 'Profile visibility',
                subtitle: 'Allow other members to discover your profile',
                value: _profileVisible,
                onChanged: (value) {
                  setState(() {
                    _profileVisible = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.location_on_rounded,
                title: 'Show approximate location',
                subtitle: 'Help nearby members discover your resources',
                value: _showLocation,
                onChanged: (value) {
                  setState(() {
                    _showLocation = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.insights_rounded,
                title: 'Show impact statistics',
                subtitle: 'Display your contribution metrics publicly',
                value: _showImpactStats,
                onChanged: (value) {
                  setState(() {
                    _showImpactStats = value;
                  });
                },
              ),
              _buildActionTile(
                icon: Icons.block_rounded,
                title: 'Blocked members',
                subtitle: 'Manage members you have blocked',
                onTap: _showBlockedMembers,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSection(
            title: 'Security',
            icon: Icons.lock_rounded,
            children: [
              _buildSwitchTile(
                icon: Icons.fingerprint_rounded,
                title: 'Biometric app lock',
                subtitle: 'Use device authentication when opening ResourceX',
                value: _biometricLock,
                onChanged: (value) {
                  setState(() {
                    _biometricLock = value;
                  });
                  _showMessage(
                    value
                        ? 'Biometric lock enabled.'
                        : 'Biometric lock disabled.',
                  );
                },
              ),
              _buildActionTile(
                icon: Icons.password_rounded,
                title: 'Change password',
                subtitle: 'Update your ResourceX account password',
                onTap: _showChangePassword,
              ),
              _buildActionTile(
                icon: Icons.devices_rounded,
                title: 'Active sessions',
                subtitle: 'Review devices currently signed in',
                onTap: _showActiveSessions,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSection(
            title: 'Appearance & Language',
            icon: Icons.palette_rounded,
            children: [
              _buildActionTile(
                icon: Icons.dark_mode_rounded,
                title: 'Appearance',
                subtitle: _appearance,
                onTap: _showAppearanceSheet,
              ),
              _buildActionTile(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: _language,
                onTap: _showLanguageSheet,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSection(
            title: 'Data & Activity',
            icon: Icons.data_usage_rounded,
            children: [
              _buildActionTile(
                icon: Icons.history_rounded,
                title: 'Activity history',
                subtitle: 'View your resource and exchange activity',
                onTap: _showActivityHistory,
              ),
              _buildActionTile(
                icon: Icons.download_rounded,
                title: 'Download my data',
                subtitle: 'Request a copy of your ResourceX data',
                onTap: _downloadData,
              ),
              _buildActionTile(
                icon: Icons.delete_sweep_rounded,
                title: 'Clear local activity',
                subtitle: 'Remove locally stored activity from this device',
                destructive: true,
                onTap: _showClearActivityDialog,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSection(
            title: 'Support & Safety',
            icon: Icons.support_agent_rounded,
            children: [
              _buildActionTile(
                icon: Icons.help_center_rounded,
                title: 'Help centre',
                subtitle: 'Find answers to common questions',
                onTap: _showHelpCentre,
              ),
              _buildActionTile(
                icon: Icons.flag_rounded,
                title: 'Report a problem',
                subtitle: 'Tell us about an issue with ResourceX',
                onTap: _showReportProblem,
              ),
              _buildActionTile(
                icon: Icons.menu_book_rounded,
                title: 'Community guidelines',
                subtitle: 'Learn how ResourceX exchanges should work',
                onTap: _showGuidelines,
              ),
              _buildActionTile(
                icon: Icons.info_outline_rounded,
                title: 'About ResourceX',
                subtitle: 'Version 1.0.0 • Built for meaningful exchanges',
                onTap: _showAbout,
              ),
            ],
          ),

          const SizedBox(height: 22),

          _buildLogoutButton(),

          const SizedBox(height: 18),

          const Center(
            child: Text(
              'ResourceX',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              'Share more. Waste less. Impact more.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsIntro() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3155D8),
            Color(0xFF6A5AE0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3155D8).withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make ResourceX work for you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Control discovery, privacy, alerts and account preferences.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
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

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 16, 17, 9),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3155D8).withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF3155D8),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ...children,
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      leading: _iconBox(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11.5,
            height: 1.25,
          ),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool destructive = false,
  }) {
    final iconColor = destructive
        ? const Color(0xFFD94A4A)
        : const Color(0xFF3155D8);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      leading: _iconBox(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: destructive ? iconColor : null,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11.5,
            height: 1.25,
          ),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey,
      ),
    );
  }

  Widget _iconBox(
    IconData icon, {
    Color color = const Color(0xFF3155D8),
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: 19,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return OutlinedButton.icon(
      onPressed: _showLogoutDialog,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFD94A4A),
        side: BorderSide(
          color: const Color(0xFFD94A4A).withValues(alpha: 0.35),
        ),
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      icon: const Icon(Icons.logout_rounded),
      label: const Text(
        'Log Out',
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  void _showRadiusSheet() {
    _showSelectionSheet(
      title: 'Discovery radius',
      subtitle: 'Choose how far ResourceX should search for opportunities.',
      options: const [
        '2 km',
        '5 km',
        '10 km',
        '25 km',
        '50 km',
      ],
      selected: _radius,
      onSelected: (value) {
        setState(() {
          _radius = value;
        });
      },
    );
  }

  void _showAppearanceSheet() {
    _showSelectionSheet(
      title: 'Appearance',
      subtitle: 'Choose how ResourceX should look on your device.',
      options: const [
        'System default',
        'Light',
        'Dark',
      ],
      selected: _appearance,
      onSelected: (value) {
        setState(() {
          _appearance = value;
        });
      },
    );
  }

  void _showLanguageSheet() {
    _showSelectionSheet(
      title: 'Language',
      subtitle: 'Choose your preferred language.',
      options: const [
        'English',
        'Tamil',
        'Hindi',
      ],
      selected: _language,
      onSelected: (value) {
        setState(() {
          _language = value;
        });
      },
    );
  }

  void _showSelectionSheet({
    required String title,
    required String subtitle,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 15),
                ...options.map(
                  (option) {
                    final isSelected = option == selected;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(context);
                        _showMessage('$title updated to $option.');
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF3155D8)
                                  .withValues(alpha: 0.10)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isSelected
                              ? Icons.check_rounded
                              : Icons.circle_outlined,
                          color: isSelected
                              ? const Color(0xFF3155D8)
                              : Colors.grey.shade500,
                        ),
                      ),
                      title: Text(
                        option,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF3155D8),
                            )
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBlockedMembers() {
    _showInfoSheet(
      title: 'Blocked members',
      icon: Icons.block_rounded,
      description:
          'Members you block will not appear in your recommendations or contact requests.',
      items: const [
        'No blocked members',
        'You can manage blocked members here anytime.',
      ],
    );
  }

  void _showChangePassword() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
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
                    'Change password',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Current password',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      prefixIcon: const Icon(Icons.lock_reset_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMessage('Password update request submitted.');
                      },
                      child: const Text('Update Password'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showActiveSessions() {
    _showInfoSheet(
      title: 'Active sessions',
      icon: Icons.devices_rounded,
      description:
          'These are the devices currently associated with your ResourceX account.',
      items: const [
        'Windows • Current device',
        'Chrome browser • Current session',
        'No other active sessions',
      ],
    );
  }

  void _showActivityHistory() {
    _showInfoSheet(
      title: 'Activity history',
      icon: Icons.history_rounded,
      description: 'Your recent ResourceX activity.',
      items: const [
        'Shared 25 educational notebooks',
        'Connected with GreenCycle Foundation',
        'Completed a community food exchange',
        'Saved 3 resource opportunities',
      ],
    );
  }

  void _downloadData() {
    _showMessage(
      'Your data export request has been created. This is a front-end demo.',
    );
  }

  void _showClearActivityDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Clear local activity?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'This demo action removes locally displayed activity from the current session.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Local activity cleared.');
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpCentre() {
    _showInfoSheet(
      title: 'Help centre',
      icon: Icons.help_center_rounded,
      description: 'Quick answers for using ResourceX.',
      items: const [
        'How do smart matches work?',
        'How do I share a resource?',
        'How do I respond to a requirement?',
        'How are exchanges marked as completed?',
        'How is impact calculated?',
      ],
    );
  }

  void _showReportProblem() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
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
                    'Report a problem',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tell us what went wrong.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Describe the issue...',
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showMessage(
                          'Problem report submitted successfully.',
                        );
                      },
                      icon: const Icon(Icons.send_rounded),
                      label: const Text('Submit Report'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showGuidelines() {
    _showInfoSheet(
      title: 'Community guidelines',
      icon: Icons.menu_book_rounded,
      description:
          'ResourceX works best when every exchange is transparent, respectful and responsible.',
      items: const [
        'Provide accurate resource information',
        'Respect agreed exchange schedules',
        'Keep communication professional',
        'Report suspicious or unsafe activity',
        'Complete exchanges honestly',
      ],
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'ResourceX',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF3155D8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(
          Icons.hub_rounded,
          color: Colors.white,
        ),
      ),
      children: const [
        Text(
          'ResourceX connects surplus resources with real community needs through intelligent matching and measurable impact.',
        ),
      ],
    );
  }

  void _showInfoSheet({
    required String title,
    required IconData icon,
    required String description,
    required List<String> items,
  }) {
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
                Row(
                  children: [
                    _iconBox(icon),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                ...items.map(
                  (item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 18,
                            color: Color(0xFF2F9D68),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Log out of ResourceX?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'You can sign in again anytime using your ResourceX account.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD94A4A),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Logout action is ready for backend integration.');
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
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