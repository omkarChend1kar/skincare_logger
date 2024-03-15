import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/common/services/service_locator.dart';
import 'package:skincare_logger/src/core/utill/error/exceptions.dart';
import 'package:skincare_logger/src/core/utill/utills/utills.dart';

abstract class AuthRemoteDatasource {
  ///
  Future<Stream<bool>> getUserLoginStatus();

  ///
  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  });

  ///
  Future<void> signIn({
    required String email,
    required String password,
  });

  ///
  Future<void> signInWithGoogle();

  ///
  Future<void> signOut();
}

@Singleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  AuthRemoteDatasourceImpl({required this.auth, required this.db});

  @override
  Future<Stream<bool>> getUserLoginStatus() async {
    try {
      final Stream<User?> userAuthStateStream = auth.authStateChanges();

      Stream<bool> getAuthStatus() async* {
        // ignore: unused_local_variable
        await for (final period in userAuthStateStream) {
          final User? user = auth.currentUser;
          if (user != null) {
            yield true;
          } else {
            yield false;
          }
        }
      }

      return Future.value(getAuthStatus());
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCreds = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCreds.user;
      sl<Utills>().setUID(uid: user!.uid);
      final CollectionReference userRef = db.collection('users');
      await userRef.doc(user.uid).set({"Name": name, "Email": email});
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCreds = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCreds.user;
      sl<Utills>().setUID(uid: user!.uid);
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleuser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        //Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
      }
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }
}
