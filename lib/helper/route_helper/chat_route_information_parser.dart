import 'package:social_media/values/app_globals/app_exports.dart';

class ChatRouteInformationParser extends RouteInformationParser<ChatListPath> {

  @override
  Future<ChatListPath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    final segments = uri.pathSegments;

    if(segments.isEmpty) return ChatListPath.home();

    if(segments.length == 2) {
      if(segments.first == "chat") {
        final id = int.tryParse(segments.elementAt(1));
        if(id != null) return ChatListPath.chats(id);
      }
    }

    return ChatListPath.invalidChat();
  }


  @override
  RouteInformation? restoreRouteInformation(ChatListPath configuration) {
    if(configuration.isInvalidChat) return const RouteInformation(location: "/404");
    if(configuration.isHomeScreen) return const RouteInformation(location: "/");
    if(configuration.isChatScreen) return RouteInformation(location: "/chat/${configuration.chatId}");
    return null;
  }
}