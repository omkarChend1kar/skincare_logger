import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class Utills {
  final FirebaseAuth auth;
  final SharedPreferences sf;
  Utills({required this.sf, required this.auth});

  void setUID({
    required String uid,
  }) {
    sf.setString('UID_KEY', uid);
  }

  String get uid =>
      sf.getString(
        'UID_KEY',
      ) ??
      auth.currentUser!.uid;

  String? emailValidator({
    String? value,
    required String emailValidation,
  }) {
    RegExp regex = RegExp(r"\s+");
    if (value == null) {
      return emailValidation;
    } else {
      if (value.contains('@') && !regex.hasMatch(value)) {
        return null;
      } else {
        return emailValidation;
      }
    }
  }

  String? miscValidator({
    String? value,
    required String nameValidation,
  }) {
    if (value == null || value.length < 2) {
      return nameValidation;
    } else {
      if (value.isNotEmpty) {
        return null;
      } else {
        return nameValidation;
      }
    }
  }

  String? passwordValidator({
    String? value,
    required String passwordValidation,
  }) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null) {
      return passwordValidation;
    } else {
      if (regex.hasMatch(value) && value.length > 6) {
        return null;
      } else {
        return passwordValidation;
      }
    }
  }
}
