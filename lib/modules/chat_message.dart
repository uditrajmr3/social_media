import 'package:social_media/values/app_globals/app_exports.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Description"),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text("Name: ${chat.name}"),
              subtitle: Text("E-mail: ${chat.email}"),
              trailing: Text("Contact: ${chat.phone}"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(chat.description, textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }
}
