import 'package:equatable/equatable.dart';

class SkinCareRoutine extends Equatable {
  final String activityName;
  final String activityProduct;
  final String? activityLogPhoto;
  final String? activityCaptureTime;

  const SkinCareRoutine({
    required this.activityProduct,
    required this.activityName,
    required this.activityLogPhoto,
    required this.activityCaptureTime,
  });

  @override
  List<Object?> get props => [
        activityName,
        activityLogPhoto,
        activityCaptureTime,
        activityProduct,
      ];

  Map<String, dynamic> toMap() {
    return {
      'activityName': activityName,
      'activityProduct': activityProduct,
      'activityLogPhoto': activityLogPhoto,
      'activityCaptureTime': activityCaptureTime,
    };
  }

  SkinCareRoutine copyWith({
    String? activityName,
    String? activityProduct,
    String? activityLogPhoto,
    String? activityCaptureTime,
  }) {
    return SkinCareRoutine(
      activityName: activityName ?? this.activityName,
      activityProduct: activityProduct ?? this.activityProduct,
      activityLogPhoto: activityLogPhoto ?? this.activityLogPhoto,
      activityCaptureTime: activityCaptureTime ?? this.activityCaptureTime,
    );
  }
}
