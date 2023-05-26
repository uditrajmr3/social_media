import 'package:social_media/values/app_globals/app_exports.dart';

class ChatRouteDelegate extends RouterDelegate<ChatListPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ChatListPath> {

  Chat? _selectedChat;
  bool show404 = false;

  void onChatSelected(Chat chat) {
    _selectedChat = chat;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: const ValueKey("ChatHome"),
          child: ChatHome(chats: AppLists.chats, onChatSelect: onChatSelected),
        ),
        if (_selectedChat != null)
          MaterialPage(
              key: const ValueKey("ChatMessage"),
              child: ChatMessage(chat: _selectedChat!)),
        if (show404)
        const MaterialPage(
            key: ValueKey("ChatInvalid"), child: InvalidChat()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _selectedChat = null;
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  ChatListPath? get currentConfiguration {
    if(show404) return ChatListPath.invalidChat();

    if(_selectedChat == null) return ChatListPath.home();

    return ChatListPath.chats(AppLists.chats.indexOf(_selectedChat!));
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(ChatListPath configuration) async {
    if(configuration.isInvalidChat) {
      _selectedChat = null;
      show404 = true;
      return;
    }

    if(configuration.isChatScreen) {
      if(configuration.chatId!.isNegative || configuration.chatId! > AppLists.chats.length - 1) {
        show404 = true;
        return;
      }
      _selectedChat = AppLists.chats[configuration.chatId!];
    }
    else {
      show404 = false;
      _selectedChat = null;
      return;
    }
  }
}
