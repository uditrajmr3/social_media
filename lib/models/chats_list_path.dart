class ChatListPath {

  final int? chatId;
  final bool isInvalidChat;

  ChatListPath.home() : chatId = null, isInvalidChat = false;

  ChatListPath.chats(this.chatId) : isInvalidChat = false;

  ChatListPath.invalidChat() : chatId = null, isInvalidChat = true;

  bool get isHomeScreen => chatId == null;
  bool get isChatScreen => chatId != null;

}