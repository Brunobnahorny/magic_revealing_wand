import 'package:flutter/material.dart';

import 'magic_wand_area/magic_wand_area_widget.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 39, 39),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(
            height: 400,
            width: 600,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.2),
              ],
            ),
            boxShadow: kElevationToShadow[2],
          ),
          child: const MagicWandArea(),
        ),
      ),
    );
  }
}
