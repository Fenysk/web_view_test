import 'dart:io';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class WebPageMacos extends StatefulWidget {
  const WebPageMacos({super.key, required this.url});

  final String url;

  @override
  State<WebPageMacos> createState() => _WebPageMacosState();
}

class _WebPageMacosState extends State<WebPageMacos> {
  bool? _webviewAvailable;

  @override
  void initState() {
    super.initState();
    WebviewWindow.isWebviewAvailable().then((value) {
      setState(() {
        _webviewAvailable = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: [
            IconButton(
              onPressed: _webviewAvailable != true ? null : _onTap,
              icon: const Icon(Icons.open_in_browser),
            )
          ],
        ),
      ),
    );
  }

  void _onTap() async {
    final webview = await WebviewWindow.create(
      configuration: CreateConfiguration(
        windowHeight: 1280,
        windowWidth: 720,
        title: "ExampleTestWindow",
        titleBarTopPadding: Platform.isMacOS ? 20 : 0,
        userDataFolderWindows: await _getWebViewPath(),
      ),
    );
    webview
      ..launch(widget.url)
      ..addOnUrlRequestCallback((url) {
        debugPrint('url: $url');
      });
  }

  Future<String> _getWebViewPath() async {
    final document = await getApplicationDocumentsDirectory();
    return p.join(document.path, 'desktop_webview_window');
  }
}
