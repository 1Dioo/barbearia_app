import 'package:flutter/material.dart';
import '../services/auth_storage.dart';
import 'auth/login_screen.dart';
import 'intro_screen.dart';
import 'main_shell.dart';

class EntryGate extends StatelessWidget {
  const EntryGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        AuthStorage.getIntroSeen(),
        AuthStorage.getCurrentUser(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data as List;
        final introSeen = data[0] as bool;
        final currentUser = data[1];

        if (!introSeen) return const IntroScreen();
        if (currentUser == null) return const LoginScreen();
        return const MainShell();
      },
    );
  }
}