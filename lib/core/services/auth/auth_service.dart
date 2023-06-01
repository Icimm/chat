import 'package:chat/core/models/chat_user.dart';
import 'dart:io';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get UserChanges;

  Future<void> signup(
    String nome,
    String email,
    String password,
    File Image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();
}
