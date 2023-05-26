# Social Media

A basic 3-5 pages SocialMedia with Navigator 2.0 implementation

## Basic Implementation

- Router Delegate
```dart
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
```

- Router Information Parser

```dart
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
```

## Runner Code

```dart
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Social Media",
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
      routeInformationParser: ChatRouteInformationParser(),
      routerDelegate: ChatRouteDelegate(),
    );
  }
}
```

## License

- This Project does not have any license.

## Collaboration

- This project is not open for collaboration

## Bugs & Issue

- For bugs, feature requests, and discussion please use [GitHub Issues](https://github.com/udit-raj-simform/social_media/issues)
