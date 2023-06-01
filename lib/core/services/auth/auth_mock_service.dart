import 'dart:math';
import '../../models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'dart:io';
import 'dart:async';

class AuthMockService implements AuthService {
  static Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get UserChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? Image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: Image?.path ?? 'assets\images\avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}