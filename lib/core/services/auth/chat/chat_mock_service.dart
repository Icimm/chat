import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userid: '123',
      username: 'Fabricio',
      userImageURL: 'assets\images\avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Bom dia, teremos reunião hoje ?',
      createdAt: DateTime.now(),
      userid: '456',
      username: 'Icaro',
      userImageURL: 'assets\images\avatar.png',
    ),
    ChatMessage(
      id: '1',
      text: 'Bom diaa, teremos sim ! ?',
      createdAt: DateTime.now(),
      userid: '123',
      username: 'Fabricio',
      userImageURL: 'assets\images\avatar.png',
    )
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
     controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final NewMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userid: user.id,
      username: user.name,
      userImageURL: user.imageURL,
    );
    _msgs.add(NewMessage);
    _controller?.add(_msgs);
    return NewMessage;
  }
}
