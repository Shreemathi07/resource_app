import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchText = '';

  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'TechShare Community',
      'message': 'The laptops are ready for pickup.',
      'time': '10 min',
      'unread': 2,
      'online': true,
      'resource': '12 Refurbished Laptops',
      'category': 'Technology',
      'status': 'Pickup scheduled',
      'statusIcon': Icons.local_shipping_outlined,
      'location': 'Vellore Campus',
      'exchangeTime': 'Today • 4:30 PM',
      'avatar': Icons.business_rounded,
    },
    {
      'name': 'Green Future Foundation',
      'message': 'Can we discuss the solar kit requirements?',
      'time': '1 hr',
      'unread': 1,
      'online': true,
      'resource': 'Solar Lighting Kits',
      'category': 'Energy',
      'status': 'Discussion',
      'statusIcon': Icons.chat_outlined,
      'location': 'Vellore',
      'exchangeTime': 'Tomorrow • 11:00 AM',
      'avatar': Icons.eco_rounded,
    },
    {
      'name': 'Campus Resource Hub',
      'message': 'We confirmed the table quantity.',
      'time': 'Yesterday',
      'unread': 0,
      'online': false,
      'resource': '18 Study Tables',
      'category': 'Furniture',
      'status': 'Exchange confirmed',
      'statusIcon': Icons.check_circle_outline_rounded,
      'location': 'Katpadi',
      'exchangeTime': 'Sep 8 • 10:00 AM',
      'avatar': Icons.school_rounded,
    },
    {
      'name': 'Learning Circle',
      'message': 'Thank you for connecting with us!',
      'time': 'Sep 4',
      'unread': 0,
      'online': false,
      'resource': 'School Supplies',
      'category': 'Education',
      'status': 'Completed',
      'statusIcon': Icons.done_all_rounded,
      'location': 'Ranipet',
      'exchangeTime': 'Completed',
      'avatar': Icons.menu_book_rounded,
    },
  ];

  List<Map<String, dynamic>> get _filteredConversations {
    if (_searchText.trim().isEmpty) {
      return _conversations;
    }

    final query = _searchText.toLowerCase();

    return _conversations.where((conversation) {
      return conversation['name'].toString().toLowerCase().contains(query) ||
          conversation['resource'].toString().toLowerCase().contains(query) ||
          conversation['category'].toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openConversation(Map<String, dynamic> conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConversationScreen(
          conversation: conversation,
        ),
      ),
    );
  }

  void _showNewMessage() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Start a conversation',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Connect with a provider or seeker from your matches.',
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: scheme.primary,
                  ),
                ),
                title: const Text(
                  'Open Smart Matches',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: const Text(
                  'Find someone to connect with',
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage('Open Matches from the bottom navigation');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  child: Icon(
                    Icons.search_rounded,
                    color: scheme.primary,
                  ),
                ),
                title: const Text(
                  'Find a resource',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: const Text(
                  'Browse available resources',
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Open Resources from the bottom navigation',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'New conversation',
            onPressed: _showNewMessage,
            icon: const Icon(
              Icons.edit_square,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(scheme),
          _buildExchangeSummary(scheme),
          Expanded(
            child: _filteredConversations.isEmpty
                ? _buildEmptyState(scheme)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      100,
                    ),
                    itemCount: _filteredConversations.length,
                    itemBuilder: (context, index) {
                      return _buildConversationCard(
                        _filteredConversations[index],
                        scheme,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNewMessage,
        icon: const Icon(Icons.add_comment_outlined),
        label: const Text('New'),
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchText = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search conversations or resources',
          prefixIcon: const Icon(
            Icons.search_rounded,
          ),
          suffixIcon: _searchText.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchText = '';
                    });
                  },
                  icon: const Icon(
                    Icons.clear_rounded,
                  ),
                ),
          filled: true,
          fillColor: scheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildExchangeSummary(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 2, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.swap_horizontal_circle_rounded,
              color: scheme.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3 active exchanges',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Keep conversations updated to complete exchanges.',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: scheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildConversationCard(
    Map<String, dynamic> conversation,
    ColorScheme scheme,
  ) {
    final bool hasUnread = conversation['unread'] as int > 0;
    final bool online = conversation['online'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: hasUnread
              ? scheme.primary.withAlpha(100)
              : scheme.outlineVariant,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => _openConversation(conversation),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: scheme.primaryContainer,
                        child: Icon(
                          conversation['avatar'] as IconData,
                          color: scheme.primary,
                          size: 26,
                        ),
                      ),
                      if (online)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: scheme.surfaceContainerHighest,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                conversation['name'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: hasUnread
                                      ? FontWeight.w900
                                      : FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              conversation['time'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          conversation['message'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                            fontWeight: hasUnread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hasUnread)
                    Container(
                      margin: const EdgeInsets.only(left: 7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${conversation['unread']}',
                        style: TextStyle(
                          color: scheme.onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 13),
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 17,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        conversation['resource'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Icon(
                      conversation['statusIcon'] as IconData,
                      size: 16,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      conversation['status'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
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

  Widget _buildEmptyState(ColorScheme scheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mark_chat_unread_outlined,
              size: 65,
              color: scheme.primary,
            ),
            const SizedBox(height: 15),
            const Text(
              'No conversations found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Try a different search term or start a new conversation.',
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

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.conversation,
  });

  final Map<String, dynamic> conversation;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hi! We found a good match for your requirement.',
      'mine': false,
      'time': '10:12 AM',
    },
    {
      'text': 'Great! Could you confirm the quantity available?',
      'mine': true,
      'time': '10:15 AM',
    },
    {
      'text': 'We currently have 12 units ready.',
      'mine': false,
      'time': '10:18 AM',
    },
    {
      'text': 'Perfect. When would pickup be possible?',
      'mine': true,
      'time': '10:20 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add({
        'text': text,
        'mine': true,
        'time': 'Now',
      });
    });

    _messageController.clear();
  }

  void _showAction(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showExchangeActions() {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Exchange actions',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Icon(
                  Icons.check_circle_outline_rounded,
                  color: scheme.primary,
                ),
                title: const Text(
                  'Confirm exchange',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Confirm that the exchange details are correct',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showAction('Exchange confirmed');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: scheme.primary,
                ),
                title: const Text(
                  'Share pickup location',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Send your preferred meeting point',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showAction('Pickup location shared');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.event_outlined,
                  color: scheme.primary,
                ),
                title: const Text(
                  'Change schedule',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Suggest a different exchange time',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showAction('Schedule options opened');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.done_all_rounded,
                  color: scheme.primary,
                ),
                title: const Text(
                  'Mark as completed',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Complete this resource exchange',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showAction('Exchange marked as completed');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final conversation = widget.conversation;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 19,
              backgroundColor: scheme.primaryContainer,
              child: Icon(
                conversation['avatar'] as IconData,
                color: scheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    conversation['online'] as bool
                        ? 'Active now'
                        : 'Last seen recently',
                    style: TextStyle(
                      fontSize: 10,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Exchange actions',
            onPressed: _showExchangeActions,
            icon: const Icon(
              Icons.more_vert_rounded,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildExchangeBanner(conversation, scheme),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(
                  _messages[index],
                  scheme,
                );
              },
            ),
          ),
          _buildMessageComposer(scheme),
        ],
      ),
    );
  }

  Widget _buildExchangeBanner(
    Map<String, dynamic> conversation,
    ColorScheme scheme,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 19,
                color: scheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  conversation['resource'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                conversation['category'] as String,
                style: TextStyle(
                  fontSize: 10,
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _exchangeInfo(
                  Icons.location_on_outlined,
                  conversation['location'] as String,
                  scheme,
                ),
              ),
              Expanded(
                child: _exchangeInfo(
                  Icons.schedule_rounded,
                  conversation['exchangeTime'] as String,
                  scheme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _exchangeInfo(
    IconData icon,
    String text,
    ColorScheme scheme,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: scheme.onSurfaceVariant,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(
    Map<String, dynamic> message,
    ColorScheme scheme,
  ) {
    final bool mine = message['mine'] as bool;

    return Align(
      alignment: mine
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 310,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(
          14,
          10,
          14,
          8,
        ),
        decoration: BoxDecoration(
          color: mine
              ? scheme.primary
              : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(mine ? 18 : 4),
            bottomRight: Radius.circular(mine ? 4 : 18),
          ),
        ),
        child: Column(
          crossAxisAlignment: mine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message['text'] as String,
              style: TextStyle(
                color: mine
                    ? scheme.onPrimary
                    : scheme.onSurface,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message['time'] as String,
              style: TextStyle(
                color: mine
                    ? scheme.onPrimary.withAlpha(180)
                    : scheme.onSurfaceVariant,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer(ColorScheme scheme) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                _showAction('Attachment options opened');
              },
              icon: const Icon(
                Icons.attach_file_rounded,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 7),
            IconButton.filled(
              onPressed: _sendMessage,
              icon: const Icon(
                Icons.send_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}