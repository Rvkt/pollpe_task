import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBarWidget({Key? key, this.height = kToolbarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/logo/logo.png',
            height: 32,
          ),
          const SizedBox(width: 16),
          const Text(
            'Poll Pe',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'VarelaRound',
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 24),
          onPressed: () {
            // Add your search functionality here
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.notifications, size: 24),
          onPressed: () {
            // Add your notifications functionality here
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
