import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:skincare_logger/src/core/utill/error/exceptions.dart';

abstract class StreakRemoteDatasource {
  ///
  Future<List<int>?> getStreakData({required int noOfDays});
}

@Singleton(as: StreakRemoteDatasource)
class StreakRemoteDatasourceImpl extends StreakRemoteDatasource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  StreakRemoteDatasourceImpl({required this.db, required this.auth});
  @override
  Future<List<int>?> getStreakData({required int noOfDays}) async {
    try {
      final uuid = auth.currentUser?.uid;
      List<int> streaks = [];
      QuerySnapshot snapshot = await db
          .collection('users')
          .doc(uuid)
          .collection('skincarelogs')
          .orderBy('date', descending: true)
          .limit(noOfDays)
          .get();

      DateTime? previousDate;
      int streak = 0;

      for (var doc in snapshot.docs) {
        DateTime currentDate =
            DateTime.parse(doc.id); // Adjust as per your date field name
        if (previousDate == null ||
            previousDate.difference(currentDate).inDays != 1) {
          // If it's the first date or not consecutive, reset streak
          streak = 1;
        } else {
          // Increment streak for consecutive dates
          streak++;
        }
        streaks.add(streak);
        previousDate = currentDate;
      }
      return streaks;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }
}
