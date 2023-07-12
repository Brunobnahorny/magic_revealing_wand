import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'wand_painter_widget.dart';

class WandMouseAnimation extends StatefulWidget {
  final ValueNotifier<PointerHoverEvent?> mouseEvent;
  final ValueNotifier<Offset> wandPositionNotifier;
  final BoxConstraints constraints;

  const WandMouseAnimation({
    super.key,
    required this.mouseEvent,
    required this.wandPositionNotifier,
    required this.constraints,
  });

  @override
  State<WandMouseAnimation> createState() => _WandMouseAnimationState();
}

class _WandMouseAnimationState extends State<WandMouseAnimation> {
  Offset oldValue = Offset.zero;
  Offset newValue = Offset.zero;

  void _handleMouseEvent() {
    setState(() {
      newValue = widget.mouseEvent.value?.localPosition ?? Offset.zero;
    });
  }

  @override
  void initState() {
    widget.mouseEvent.addListener(_handleMouseEvent);
    super.initState();
  }

  @override
  void dispose() {
    widget.mouseEvent.removeListener(_handleMouseEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<Offset>(begin: oldValue, end: newValue),
        builder: (
          BuildContext context,
          Offset tweenValue,
          Widget? child,
        ) {
          return CustomPaint(
            painter: WandPainter(
              wandPosition: tweenValue,
              wandPositionNotifier: widget.wandPositionNotifier,
            ),
            size: widget.constraints.biggest,
          );
        },
      ),
    );
  }
}
