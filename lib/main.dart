import 'package:flutter/material.dart';


void main() => runApp(const ChatApp());

class Palette {
  const Palette._();

  static const Color green = Color(0xFF075E54);
  static const Color accent = Color(0xFF25D366);
  static const Color darkBar = Color(0xFF1F2C34);
  static const Color darkBg = Color(0xFF0B141A);

  static const Color chatBgLight = Color(0xFFECE5DD);
  static const Color mineLight = Color(0xFFDCF8C6);
  static const Color mineDark = Color(0xFF005C4B);
  static const Color theirsLight = Colors.white;
  static const Color theirsDark = Color(0xFF202C33);
}

class ChatPreview {
  const ChatPreview({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.color,
    this.unread = 0,
  });

  final String name;
  final String lastMessage;
  final String time;
  final Color color;
  final int unread;
}

class Message {
  const Message({required this.text, required this.time, required this.mine});

  final String text;
  final String time;
  final bool mine;
}

const List<ChatPreview> Chats = [
  ChatPreview(
    name: 'jacob',
    lastMessage: 'hi?',
    time: '4:52 PM',
    color: Color(0xFFE2573E),
    unread: 2,
  ),
  ChatPreview(
    name: 'Alex',
    lastMessage: 'how are you?',
    time: '3:10 PM',
    color: Color(0xFF1F9D78),
    unread: 5,
  ),
  ChatPreview(
    name: 'Mom',
    lastMessage: 'Call me when you reach home',
    time: '1:25 PM',
    color: Color(0xFFD89A14),
  ),
  ChatPreview(
    name: 'maya',
    lastMessage: 'The build passed, merging now',
    time: 'Yesterday',
    color: Color(0xFF0A62B8),
  ),
  ChatPreview(
    name: 'Meera',
    lastMessage: 'Thanks, that really helped!',
    time: 'Yesterday',
    color: Color(0xFF8E44AD),
  ),
  ChatPreview(
    name: 'Office Team',
    lastMessage: 'Standup moved to 10:30',
    time: 'Tuesday',
    color: Color(0xFF16A085),
  ),

];

const List<Message> sendMessages = [
  Message(text: 'Hi! Are you free  today?', time: '4:40 PM', mine: false),
  Message(text: 'Yes, after 8 works for me.', time: '4:42 PM', mine: true),
  Message(text: 'Great. Can you check the code today?', time: '4:52 PM', mine: false),
];

const List<String> autoReplies = [
  'Got it, thanks!',
  'Sounds good to me.',
  'Let me check and get back to you.',
  'Perfect, see you then.',
];

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    return ThemeData(
      //useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Palette.green,
        brightness: brightness,
        primary: dark ? Palette.accent : Palette.green,
      ),
      scaffoldBackgroundColor: dark ? Palette.darkBg : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: dark ? Palette.darkBar : Palette.green,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.accent,
        foregroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            PopupMenuButton<String>(
              onSelected: (_) {},
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'group', child: Text('New group')),
                PopupMenuItem(value: 'starred', child: Text('Starred messages')),
                PopupMenuItem(value: 'settings', child: Text('Settings')),
              ],
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatListTab(),
            StatusTab(),
            CallsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.name, required this.color, this.radius = 24});

  final String name;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        name.isEmpty ? '?' : name[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ChatListTab extends StatelessWidget {
  const ChatListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return ListView.separated(
      itemCount: Chats.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 76,
        color: theme.colorScheme.outlineVariant.withOpacity(0.5),
      ),
      itemBuilder: (context, index) {
        final chat = Chats[index];
        final hasUnread = chat.unread > 0;
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Avatar(name: chat.name, color: chat.color),
          title: Text(
            chat.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            chat.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat.time,
                style: TextStyle(
                  fontSize: 12,
                  color: hasUnread ? Palette.accent : muted,
                ),
              ),
              const SizedBox(height: 6),
              if (hasUnread)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Palette.accent,
                  child: Text(
                    '${chat.unread}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                const SizedBox(height: 20),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => ChatScreen(chat: chat)),
            );
          },
        );
      },
    );
  }
}

class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return ListView(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              const Avatar(name: 'Me', color: Color(0xFF607D8B), radius: 26),
              Positioned(
                right: -2,
                bottom: -2,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  child: const CircleAvatar(
                    radius: 8,
                    backgroundColor: Palette.accent,
                    child: Icon(Icons.add, size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          title: const Text('My status', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: const Text('Tap to add a status update'),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            'Recent updates',
            style: TextStyle(color: muted, fontWeight: FontWeight.w600),
          ),
        ),
        for (final chat in Chats.take(4))
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            leading: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Palette.accent, width: 2),
              ),
              child: Avatar(name: chat.name, color: chat.color, radius: 22),
            ),
            title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Today, ${chat.time}'),
            onTap: () {},
          ),
      ],
    );
  }
}

class CallsTab extends StatelessWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final calls = <(ChatPreview, String, IconData, bool)>[
      (Chats[0], 'Today, 5:05 PM', Icons.call_received, false),
      (Chats[2], 'Today, 1:30 PM', Icons.call_made, true),
      (Chats[3], 'Yesterday, 9:12 PM', Icons.call_received, true),
      (Chats[4], 'Yesterday, 6:40 PM', Icons.call_missed, false),
    ];
    return ListView(
      children: [
        for (final c in calls)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Avatar(name: c.$1.name, color: c.$1.color),
            title: Text(c.$1.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Row(
              children: [
                Icon(
                  c.$3,
                  size: 16,
                  color: c.$4 ? Palette.accent : Colors.redAccent,
                ),
                const SizedBox(width: 4),
                Flexible(child: Text(c.$2, overflow: TextOverflow.ellipsis)),
              ],
            ),
            trailing: const Icon(Icons.call, color: Palette.accent),
            onTap: () {},
          ),
      ],
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chat});

  final ChatPreview chat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = List<Message>.of(sendMessages);
  int _replyIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _now() => TimeOfDay.now().format(context);

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Message(text: text, time: _now(), mine: true));
    });
    _controller.clear();

    Future<void>.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      final reply = autoReplies[_replyIndex % autoReplies.length];
      _replyIndex++;
      setState(() {
        _messages.add(Message(text: reply, time: _now(), mine: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Avatar(name: widget.chat.name, color: widget.chat.color, radius: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'online',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Container(
        color: dark ? Palette.darkBg : Palette.chatBgLight,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: _messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return const _DayChip(label: 'TODAY');
                  }
                  final message = _messages[_messages.length - 1 - index];
                  return MessageBubble(message: message);
                },
              ),
            ),
            _InputBar(controller: _controller, onSend: _send),
          ],
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: dark ? Palette.theirsDark : const Color(0xFFE1F2FB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: dark ? Colors.white70 : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final mine = message.mine;
    final color = mine
        ? (dark ? Palette.mineDark : Palette.mineLight)
        : (dark ? Palette.theirsDark : Palette.theirsLight);
    final textColor = dark ? Colors.white : Colors.black87;
    final maxWidth = MediaQuery.sizeOf(context).width * 0.78;

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          padding: const EdgeInsets.fromLTRB(10, 7, 10, 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft: Radius.circular(mine ? 10 : 2),
              bottomRight: Radius.circular(mine ? 2 : 10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  message.text,
                  style: TextStyle(fontSize: 15.5, color: textColor, height: 1.3),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 11,
                      color: dark ? Colors.white60 : Colors.black45,
                    ),
                  ),
                  if (mine) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.done_all, size: 16, color: Color(0xFF53BDEB)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final fieldColor = dark ? Palette.theirsDark : Colors.white;
    final iconColor = dark ? Colors.white60 : Colors.black45;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: fieldColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.emoji_emotions_outlined, color: iconColor),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onSubmitted: (_) => onSend(),textInputAction: TextInputAction.done,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.attach_file, color: iconColor),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.camera_alt, color: iconColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                final hasText = value.text.trim().isNotEmpty;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Palette.accent,
                    child: IconButton(
                      onPressed: hasText ? onSend : () {},
                      icon: Icon(
                        hasText ? Icons.send : Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}