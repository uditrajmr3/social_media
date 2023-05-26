import 'package:social_media/values/app_globals/app_exports.dart';


class ChatHome extends StatefulWidget {
  const ChatHome({super.key, required this.chats, required this.onChatSelect});

  final List<Chat> chats;
  final void Function(Chat chat) onChatSelect;

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Media: Chats"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.chats.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
                  key: ValueKey("Item : $index"),
                  title: Text(widget.chats[index].name),
                  subtitle: Text(widget.chats[index].email),
                  trailing: Text(widget.chats[index].phone),
              onTap: () => widget.onChatSelect(widget.chats[index]),
                )),
      ),
    );
  }
}
