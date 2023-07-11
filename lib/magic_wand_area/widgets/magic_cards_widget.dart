import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MagicCards extends StatelessWidget {
  final ValueNotifier<PointerHoverEvent?> mouseEvent;
  final BoxConstraints constraints;

  const MagicCards({
    super.key,
    required this.mouseEvent,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
