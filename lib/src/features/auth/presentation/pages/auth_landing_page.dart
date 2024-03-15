import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skincare_logger/src/features/routinelogger/presentation/pages/routine_logger_page.dart';
import 'package:skincare_logger/src/features/streaktraker/presentation/pages/streak_tracker_page.dart';

class AuthLandingPage extends StatefulWidget {
  const AuthLandingPage({super.key});

  @override
  State<AuthLandingPage> createState() => _AuthLandingPageState();
}

class _AuthLandingPageState extends State<AuthLandingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getBodyWidget() {
      switch (_selectedIndex) {
        case 0:
          return const RoutineLoggerPage();
        case 1:
          return const StreakTrackerPage();
        default:
          return Container(); // You can return any default widget here
      }
    }

    return Scaffold(
      body: getBodyWidget(),
      bottomNavigationBar: BottomAppBar(
        height: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  child: IconButton.filledTonal(
                    icon: const FaIcon(FontAwesomeIcons.listCheck),
                    onPressed: () => _onItemTapped(0),
                  ),
                ),
                const Text('Routine')
              ],
            ),
            const SizedBox(width: 20), // Add a little space between buttons
            Column(
              children: [
                Expanded(
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.fire),
                    onPressed: () => _onItemTapped(1),
                  ),
                ),
                const Text('Streak')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
