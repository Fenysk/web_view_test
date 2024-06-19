import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'web_page.dart';
import '../widgets/toolbar.dart';

class JitsiPage extends StatefulWidget {
  const JitsiPage({super.key});

  @override
  State<JitsiPage> createState() => _JitsiPageState();
}

class _JitsiPageState extends State<JitsiPage> {
  void returnPreviousPage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Exit the WebPage
                await windowManager.setFullScreen(false);
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const Positioned.fill(
            child: WebPage(url: 'https://frontroom.batemates.app/'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Toolbar(onExitTap: returnPreviousPage),
          ),
        ],
      ),
    );
  }
}
