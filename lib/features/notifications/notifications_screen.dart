import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';

  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      title: 'New smart match found',
      message:
          'A nearby organization needs 25 reusable desks that match your available resources.',
      time: '8 min ago',
      category: 'Matches',
      icon: Icons.auto_awesome_rounded,
      unread: true,
    ),
    _NotificationItem(
      title: 'Exchange confirmed',
      message:
          'Green Campus Network confirmed the pickup for your 40 reusable chairs.',
      time: '32 min ago',
      category: 'Exchanges',
      icon: Icons.handshake_rounded,
      unread: true,
    ),
    _NotificationItem(
      title: 'Resource expiring soon',
      message:
          'Your surplus office lighting resource will expire from the marketplace in 2 days.',
      time: '1 hr ago',
      category: 'Resources',
      icon: Icons.schedule_rounded,
      unread: true,
    ),
    _NotificationItem(
      title: 'Nearby resource available',
      message:
          '12 laboratory stools are now available within 3 km of your preferred location.',
      time: '2 hrs ago',
      category: 'Nearby',
      icon: Icons.location_on_rounded,
      unread: false,
    ),
    _NotificationItem(
      title: 'Requirement updated',
      message:
          'Community Learning Centre increased their requirement from 20 to 35 laptops.',
      time: '4 hrs ago',
      category: 'Requirements',
      icon: Icons.assignment_rounded,
      unread: false,
    ),
    _NotificationItem(
      title: 'Impact milestone reached',
      message:
          'Congratulations! Your resource exchanges have crossed the 100 kg reuse milestone.',
      time: 'Yesterday',
      category: 'Impact',
      icon: Icons.eco_rounded,
      unread: false,
    ),
    _NotificationItem(
      title: 'Message received',
      message:
          'Arun from Community Makers sent you a message about the furniture exchange.',
      time: 'Yesterday',
      category: 'Messages',
      icon: Icons.chat_bubble_rounded,
      unread: false,
    ),
    _NotificationItem(
      title: 'Profile verification completed',
      message:
          'Your ResourceX profile verification has been successfully completed.',
      time: '2 days ago',
      category: 'System',
      icon: Icons.verified_rounded,
      unread: false,
    ),
  ];

  List<_NotificationItem> get _filteredNotifications {
    if (_selectedFilter == 'All') {
      return _notifications;
    }

    return _notifications
        .where((notification) => notification.category == _selectedFilter)
        .toList();
  }

  int get _unreadCount =>
      _notifications.where((notification) => notification.unread).length;

  void _markAllAsRead() {
    setState(() {
      for (final notification in _notifications) {
        notification.unread = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
      ),
    );
  }

  void _openNotification(_NotificationItem notification) {
    setState(() {
      notification.unread = false;
    });

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: scheme.primaryContainer,
                child: Icon(
                  notification.icon,
                  color: scheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                notification.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                notification.message,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 15,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 18,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    notification.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    notification.time,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('View related activity'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteNotification(_NotificationItem notification) {
    setState(() {
      _notifications.remove(notification);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification removed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildSummary(scheme),
          _buildFilters(),
          Expanded(
            child: _filteredNotifications.isEmpty
                ? _buildEmptyState(scheme)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                    itemCount: _filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];

                      return Dismissible(
                        key: ValueKey(
                          '${notification.title}-${notification.time}',
                        ),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(right: 24),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: scheme.errorContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: scheme.onErrorContainer,
                          ),
                        ),
                        onDismissed: (_) {
                          _deleteNotification(notification);
                        },
                        child: _NotificationCard(
                          notification: notification,
                          onTap: () => _openNotification(notification),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: [
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: scheme.surface.withAlpha(210),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.notifications_active_rounded,
              color: scheme.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stay in the loop',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _unreadCount == 0
                      ? 'You are all caught up.'
                      : '$_unreadCount unread updates need your attention.',
                  style: TextStyle(
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

  Widget _buildFilters() {
    const filters = [
      'All',
      'Matches',
      'Exchanges',
      'Resources',
      'Nearby',
      'Impact',
    ];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = filter == _selectedFilter;

          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme scheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 72,
              color: scheme.outline,
            ),
            const SizedBox(height: 18),
            const Text(
              'Nothing here yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'New ResourceX activity will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  final _NotificationItem notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: notification.unread ? 1 : 0,
      color: notification.unread
          ? scheme.primaryContainer.withAlpha(90)
          : scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      notification.icon,
                      color: scheme.primary,
                    ),
                  ),
                  if (notification.unread)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 11,
                        width: 11,
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: scheme.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: notification.unread
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          notification.time,
                          style: TextStyle(
                            fontSize: 11,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.35,
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        notification.category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: scheme.primary,
                        ),
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
}

class _NotificationItem {
  _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.category,
    required this.icon,
    required this.unread,
  });

  final String title;
  final String message;
  final String time;
  final String category;
  final IconData icon;
  bool unread;
}