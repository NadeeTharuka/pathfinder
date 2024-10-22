import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/home'),
            icon: const Icon(Icons.home),
            color: Colors.blue,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/navigation_mode'),
            icon: const ImageIcon(
                AssetImage('lib/assets/images/navigation_icon.png')),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(Icons.person),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
