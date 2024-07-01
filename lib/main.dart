import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'pages/jitsi_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setTitle('Batemates');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateToRoom(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JitsiPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => navigateToRoom(context),
          child: const Text('Join a room'),
        ),
      ),
    );
  }
}
