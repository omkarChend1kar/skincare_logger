import 'dart:convert';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skincare_logger/src/core/common/themes/constants.dart';
import 'package:skincare_logger/src/features/routinelogger/domain/entities/skin_routine_entity.dart';
import 'package:skincare_logger/src/features/routinelogger/presentation/cubit/routinelogger_cubit.dart';
import 'package:skincare_logger/src/features/routinelogger/presentation/logskincarecubit/logskincare_cubit.dart';

class RoutineLoggerPage extends StatefulWidget {
  const RoutineLoggerPage({super.key});

  @override
  State<RoutineLoggerPage> createState() => _RoutineLoggerPageState();
}

class _RoutineLoggerPageState extends State<RoutineLoggerPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _showImageDialog(String base64Image) async {
    // Decode base64 image
    Uint8List imageBytes = base64.decode(base64Image);

    // Show image in dialog
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Image.memory(imageBytes),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _captureAndConvertImage() async {
    try {
      late String base64Image;

      await showDialog(
        context: context,
        builder: (context) {
          return SmartFaceCamera(
            autoCapture: true,
            defaultCameraLens: CameraLens.front,
            message: 'Center your face in the square',
            onCapture: (File? image) async {
              Uint8List imageBytes = await image!.readAsBytes();
              base64Image = base64Encode(imageBytes);
              Navigator.of(context).pop(base64Image);
            },
          );
        },
      );

      // Return base64 image
      return base64Image;
    } catch (err) {
      print('Error capturing and converting image: $err');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 247, 250),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Skin Care Routine',
          style: textStyle.copyWith(fontSize: 22),
        ),
      ),
      body: BlocBuilder<RoutineloggerCubit, RoutineloggerState>(
        builder: (context, state) {
          if (state is RoutineloggerComplete) {
            final List<SkinCareRoutine> skinCareRoutine = state.skinCareRoutine;
            List<bool> activityCompleted = List<bool>.from(
              skinCareRoutine.map(
                (e) {
                  if (e.activityCaptureTime == null ||
                      e.activityLogPhoto == null) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
            );
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SkinCareRoutineSlider(
                    activityCompleted: activityCompleted,
                  ),
                ),
                ListView(
                  children: List<Widget>.generate(
                    skinCareRoutine.length,
                    (index) => ListTile(
                      trailing: skinCareRoutine[index].activityLogPhoto == null
                          ? IconButton(
                              onPressed: () async {
                                final BuildContext savedContext = context;
                                final base64 = await _captureAndConvertImage();
                                if (base64 != null) {
                                  savedContext
                                      .read<LogskincareCubit>()
                                      .logSkinCareRoutine(
                                        skinCareRoutine:
                                            skinCareRoutine[index].copyWith(
                                          activityLogPhoto: base64,
                                          activityCaptureTime: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                        ),
                                      );
                                }
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.camera,
                              ),
                            )
                          : IconButton(
                              onPressed: () async => await _showImageDialog(
                                skinCareRoutine[index].activityLogPhoto!,
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                              ),
                            ),
                      leading: const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                      title: Text(
                        skinCareRoutine[index].activityName,
                        style: textStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        skinCareRoutine[index].activityProduct,
                        style: textStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          if (state is RoutineloggerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class SkinCareRoutineSlider extends StatelessWidget {
  final List<bool> activityCompleted;

  const SkinCareRoutineSlider({
    super.key,
    required this.activityCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 100,
      child: CustomPaint(
        painter: SliderPainter(
          activityCompleted: activityCompleted,
          gap: 300 / (activityCompleted.length - 1),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
        ),
      ),
    );
  }
}

class SliderPainter extends CustomPainter {
  final List<bool> activityCompleted;
  final double gap;

  SliderPainter({
    required this.activityCompleted,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    const double circleRadius = 15;

    for (int i = 0; i < activityCompleted.length; i++) {
      final double startY = (i) * gap;
      final double endY = (i + 1) * gap;

      if (activityCompleted[i]) {
        // Draw circle
        paint.color = const Color.fromARGB(255, 150, 79, 101);
        canvas.drawCircle(
          Offset(size.width / 2, startY + circleRadius),
          circleRadius,
          paint,
        );

        // Draw line between circles (except for the last circle)
        if (i < activityCompleted.length - 1) {
          canvas.drawLine(
            Offset(size.width / 2, startY + circleRadius),
            Offset(size.width / 2, endY),
            paint,
          );
        }
      } else {
        // Draw circle
        paint.color = Colors.grey;
        canvas.drawCircle(
          Offset(size.width / 2, startY + circleRadius),
          circleRadius,
          paint,
        );

        // Draw line between circles (except for the last circle)
        if (i < activityCompleted.length - 1) {
          paint.color = Colors.grey;
          canvas.drawLine(
            Offset(size.width / 2, startY + circleRadius),
            Offset(size.width / 2, endY),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
