import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'web_page_windows.dart';
import 'web_page_macos.dart';
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
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  Widget webPagePlatformSpecific() {
    return Platform.isMacOS
        ? WebPageWindows(
            // url: 'http://localhost:5173',
            url: 'https://google.fr',
            onHangup: returnPreviousPage,
            onCameraStatusChange: (cameraStatus) => {},
          )
        : const WebPageMacos(
            url: 'https://google.fr',
          );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned.fill(
            child: webPagePlatformSpecific(),
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
