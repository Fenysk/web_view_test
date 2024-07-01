import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';
import 'dart:convert';

class WebPageWindows extends StatefulWidget {
  const WebPageWindows({
    super.key,
    required this.url,
    this.width,
    this.height,
    required this.onHangup,
    required this.onCameraStatusChange,
  });

  final String url;
  final double? width;
  final double? height;
  final void Function() onHangup;
  final void Function(bool cameraStatus) onCameraStatusChange;

  @override
  State<WebPageWindows> createState() => _WebPageWindowsState();
}

class _WebPageWindowsState extends State<WebPageWindows> {
  final _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    await _controller.initialize();
    await _controller.loadUrl(widget.url);
    await _controller.clearCache();
    await _controller.clearCookies();

    if (!mounted) return;

    _controller.title.listen((title) {
      if (title == 'hangup()') widget.onHangup();

      print(title);
      try {
        final parsedJson = jsonDecode(title);
        if (parsedJson is Map<String, dynamic> && parsedJson['cameraStatus'] != null) {
          widget.onCameraStatusChange(parsedJson['cameraStatus']);
        }
      } catch (e) {
        // If title is not a valid JSON, do nothing
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget webPage = _controller.value.isInitialized
        ? Webview(
            _controller,
            permissionRequested: (url, permissionKind, isUserInitiated) => WebviewPermissionDecision.allow,
          )
        : const Center(child: CircularProgressIndicator());

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: webPage,
    );
  }
}
