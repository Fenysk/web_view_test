import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key, required this.url});

  final String url;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    await _controller.initialize();
    await _controller.loadUrl(widget.url);

    if (!mounted) return;

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  WebviewPermissionDecision _handlePermissionRequest(WebviewPermissionKind permissionKind) {
    if (permissionKind == WebviewPermissionKind.microphone || permissionKind == WebviewPermissionKind.camera) {
      return WebviewPermissionDecision.allow;
    }
    return WebviewPermissionDecision.deny;
  }

  @override
  Widget build(BuildContext context) {
    Widget webPage = _controller.value.isInitialized
        ? Webview(
            _controller,
            permissionRequested: (url, permissionKind, isUserInitiated) {
              return _handlePermissionRequest(permissionKind);
            },
          )
        : const CircularProgressIndicator();

    return webPage;
  }
}
