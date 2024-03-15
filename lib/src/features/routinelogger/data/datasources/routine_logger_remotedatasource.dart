import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:skincare_logger/src/core/utill/error/exceptions.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';

abstract class RoutineLoggerRemoteDatasource {
  ///
  Future<void> logSkinCareRoutine({
    required SkinCareRoutine skinCareRoutine,
  });

  ///
  Future<Stream<List<SkinCareRoutine>>> getTodaySkinsCareRoutine();
}

@Singleton(as: RoutineLoggerRemoteDatasource)
class RoutineLoggerRemoteDatasourceImpl extends RoutineLoggerRemoteDatasource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  RoutineLoggerRemoteDatasourceImpl({
    required this.db,
    required this.auth,
  });
  @override
  Future<Stream<List<SkinCareRoutine>>> getTodaySkinsCareRoutine() async {
    try {
      final uuid = auth.currentUser?.uid;
      final CollectionReference userRef = db.collection('users');
      final CollectionReference masterRef = db.collection('master');
      final CollectionReference skinCareRef =
          userRef.doc(uuid).collection('skincarelogs');
      String dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());

      StreamController<List<SkinCareRoutine>> controller =
          StreamController<List<SkinCareRoutine>>();

      skinCareRef
          .doc(dateString)
          .snapshots()
          .listen((DocumentSnapshot snapshot) async {
        if (snapshot.exists) {
          final logs = (snapshot.data() as dynamic)['logs'] ?? [];

          List<SkinCareRoutine> routines = logs
              .map((log) {
                return SkinCareRoutine(
                  activityProduct: log['activityProduct'],
                  activityName: log['activityName'],
                  activityLogPhoto: log['activityLogPhoto'],
                  activityCaptureTime: log['activityCaptureTime'],
                );
              })
              .cast<SkinCareRoutine>()
              .toList();

          controller.add(routines);
        } else {
          final QuerySnapshot masterSnaps = await masterRef.get();
          final List<dynamic> activities = (masterSnaps.docs.first.data()
              as Map<String, dynamic>)['activities'];
          final List<Map<String, dynamic>> logs = activities.map(
            (e) {
              final object = {
                "activityProduct": e["product"],
                "activityName": e["name"],
                "activityLogPhoto": null,
                "activityCaptureTime": null,
              };
              return object;
            },
          ).toList();
          await skinCareRef.doc(dateString).set({
            "logs": logs,
            "date": DateTime.now(),
          });
        }
      });
      return controller.stream;
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }

  @override
  Future<void> logSkinCareRoutine({
    required SkinCareRoutine skinCareRoutine,
  }) async {
    try {
      final uuid = auth.currentUser?.uid;
      final CollectionReference userRef = db.collection('users');
      String dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final DocumentReference skinCare =
          userRef.doc(uuid).collection('skincarelogs').doc(dateString);
      DocumentSnapshot skinCareSnapshot = await skinCare.get();
      if (!skinCareSnapshot.exists) {
        throw ServerException(
          errorDescription: "Document does not exist",
          errorCode: '01',
        );
      }
      List<Map<String, dynamic>> logs = List<Map<String, dynamic>>.from(
          (skinCareSnapshot.data() as dynamic)?['logs']);

      // Find the map with the matching routine name
      int indexToUpdate = -1;
      for (int i = 0; i < logs.length; i++) {
        Map<String, dynamic> log = logs[i];
        if (log['activityName'] == skinCareRoutine.activityName) {
          indexToUpdate = i;
          break;
        }
      }

      // If a matching map is found, update it
      if (indexToUpdate != -1) {
        logs[indexToUpdate] = skinCareRoutine.toMap();

        // Update the document with the modified data
        await skinCare.update({'logs': logs});
      } else {
        throw ServerException(
          errorDescription:
              "Routine with name '${skinCareRoutine.activityName}' not found",
          errorCode: "01",
        );
      }
    } on FirebaseException catch (err) {
      throw ServerException(
        errorDescription: err.message ?? "Something went wrong",
        errorCode: err.code,
      );
    }
  }
}
