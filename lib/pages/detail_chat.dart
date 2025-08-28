import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String contactAvatar; // UPDATE 5.3.5: Tambahkan avatar

  const ChatScreen({super.key, required this.contactName, required this.contactAvatar});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [{'text': 'Hallo', 'isMe': true, 'time': '12:55'},{'text': 'Ada yang bisa dibantu?', 'isMe': false, 'time': '13:00'}];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _formatCurrentTime() => DateFormat('HH:mm').format(DateTime.now());

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({'text': _controller.text, 'isMe': true, 'time': _formatCurrentTime()});
      });
      _controller.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UPDATE 5.3.5: AppBar sekarang menampilkan avatar dan nama
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.contactAvatar)),
            const SizedBox(width: 10),
            Text(widget.contactName),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4C53A5),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                  child: Align(
                    alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                    child: _buildChatBubble(message),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Map<String, dynamic> message) {
    return Column(
      crossAxisAlignment: message['isMe'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: message['isMe'] ? const Color(0xFF4C53A5) : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(message['text']!, style: TextStyle(color: message['isMe'] ? Colors.white : Colors.black)),
        ),
        const SizedBox(height: 4),
        Text(message['time']!, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  // UPDATE 5.3.6: Tampilan kolom input dikembangkan
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey[600]), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              ),
              onSubmitted: (_) => sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: const Color(0xFF4C53A5),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}