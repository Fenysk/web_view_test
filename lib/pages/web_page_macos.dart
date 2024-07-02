import 'package:flutter/material.dart';
import 'package:macos_webview_kit/macos_webview_kit.dart';

class WebPageMacos extends StatefulWidget {
  const WebPageMacos({super.key, required this.url});

  final String url;

  @override
  State<WebPageMacos> createState() => _WebPageMacosState();
}

class _WebPageMacosState extends State<WebPageMacos> {
  final _macosWebviewKitPlugin = MacosWebviewKit();

  @override
  void initState() {
    super.initState();
    _openWebView();
  }

  Future<void> _openWebView() async {
    await _macosWebviewKitPlugin.openWebView(urlString: widget.url);
  }

  Future<void> _closeWebView() async {
    await _macosWebviewKitPlugin.closeWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _closeWebView,
          ),
        ],
      ),
      body: Center(
        child: Text('WebView is open with URL: ${widget.url}'),
      ),
    );
  }
}
