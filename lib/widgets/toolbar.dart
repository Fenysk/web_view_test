import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key, required this.onExitTap});

  final void Function() onExitTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onExitTap,
            child: const Row(
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(width: 8),
                Text('Exit'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
