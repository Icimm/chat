import 'package:chat/core/models/chat_user.dart';
import 'dart:io';
import 'auth_firebase_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get UserChanges;

  Future<void> signup(
    String nome,
    String email,
    String password,
    File? Image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
   // return AuthMockService();
    return AuthFirebaseService();
  }
}
