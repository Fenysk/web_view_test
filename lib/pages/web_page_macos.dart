import 'package:flutter/material.dart';
import 'package:flutter_inline_webview_macos/flutter_inline_webview_macos.dart';
import 'package:flutter_inline_webview_macos/flutter_inline_webview_macos/flutter_inline_webview_macos_controller.dart';
import 'package:flutter_inline_webview_macos/flutter_inline_webview_macos/types.dart';

class WebPageMacos extends StatefulWidget {
  const WebPageMacos({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  final String url;
  final double? width;
  final double? height;

  @override
  State<WebPageMacos> createState() => _WebPageMacosState();
}

class _WebPageMacosState extends State<WebPageMacos> {
  InlineWebViewMacOsController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: InlineWebViewMacOs(
            key: widget.key,
            width: widget.width ?? 500,
            height: widget.height ?? 300,
            onWebViewCreated: (controller) {
              _controller = controller;
              _controller!.loadUrl(
                urlRequest: URLRequest(url: Uri.parse(widget.url)),
              );
            },
          ),
        ),
      ),
    );
  }
}
