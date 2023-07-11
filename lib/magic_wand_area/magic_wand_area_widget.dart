import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widgets/magic_cards_widget.dart';
import 'widgets/wand_mouse_animation.dart';

class MagicWandArea extends StatefulWidget {
  const MagicWandArea({super.key});

  @override
  State<MagicWandArea> createState() => _MagicWandAreaState();
}

class _MagicWandAreaState extends State<MagicWandArea> {
  final mouseEvent = ValueNotifier<PointerHoverEvent?>(null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) {
            mouseEvent.value = event;
          },
          child: Stack(
            children: [
              WandMouseAnimation(
                mouseEvent: mouseEvent,
                constraints: constraints,
              ),
              MagicCards(
                mouseEvent: mouseEvent,
                constraints: constraints,
              ),
            ],
          ),
        );
      },
    );
  }
}
