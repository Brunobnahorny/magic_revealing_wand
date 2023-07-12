import 'package:flutter/material.dart';
import 'dart:math';

class WandPainter extends CustomPainter {
  final ValueNotifier<Offset> wandPositionNotifier;
  final Offset wandPosition;

  WandPainter({
    required this.wandPosition,
    required this.wandPositionNotifier,
  });

  void drawRotated({
    required Canvas canvas,
    required Offset center,
    required double rotation,
    required VoidCallback drawFuncion,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    drawFuncion();
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    //simul props
    final positionWandX = (size.width * -0.025) + wandPosition.dx * 1.28;
    final wandXByScreen = (positionWandX / size.width);
    final linearGradientMiddle = wandXByScreen.clamp(0.4, 0.6);
    const rotationRange = pi / 8;
    final rotationInWand =
        (-rotationRange / 2) + wandXByScreen.clamp(0, 1) * rotationRange;
    final stops = <double>[0, linearGradientMiddle, 1];
    final positionWandy =
        (size.height * 0.16) + wandPosition.dy * 0.52 + (size.height / 2);
    final positionWandCenter = Offset(positionWandX, positionWandy);
    const double wandWidth = 36;
    final wandRotation = rotationInWand;

    //wand base
    final wandBaseHeight = size.height * 0.6;

    final wandBaseRect = Rect.fromCenter(
      center: positionWandCenter,
      width: wandWidth,
      height: wandBaseHeight,
    );
    final wandBasePaint = Paint()
      ..shader = LinearGradient(
        stops: stops,
        colors: const [
          Color(0xFF1A171C),
          Color(0xFF29272c),
          Color(0xFF1A171C),
        ],
      ).createShader(wandBaseRect);

    drawRotated(
      canvas: canvas,
      center: positionWandCenter,
      rotation: wandRotation,
      drawFuncion: () => canvas.drawRRect(
        RRect.fromRectAndCorners(
          wandBaseRect,
          bottomLeft: const Radius.circular(8),
          bottomRight: const Radius.circular(8),
        ),
        wandBasePaint,
      ),
    );

    //wand head
    final wandHeadHeight = size.height * 0.2;
    final wandHeadRect = Rect.fromCenter(
      center: positionWandCenter +
          Offset(0, -((wandBaseHeight + wandHeadHeight) / 2)),
      width: wandWidth,
      height: wandHeadHeight,
    );
    final wandHeadPaint = Paint()
      ..shader = LinearGradient(
        stops: stops,
        colors: const [
          Color(0xFFD2D7E5),
          Colors.white,
          Color(0xFFD2D7E5),
        ],
      ).createShader(wandHeadRect);

    //sets wand notifier
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wandPositionNotifier.value = positionWandCenter;
    });

    drawRotated(
      canvas: canvas,
      center: positionWandCenter,
      rotation: wandRotation,
      drawFuncion: () => canvas.drawRRect(
        RRect.fromRectAndCorners(
          wandHeadRect,
          topLeft: const Radius.circular(8),
          topRight: const Radius.circular(8),
        ),
        wandHeadPaint,
      ),
    );
  }

  @override
  bool shouldRepaint(WandPainter oldDelegate) =>
      wandPosition != oldDelegate.wandPosition;

  @override
  bool shouldRebuildSemantics(WandPainter oldDelegate) => false;
}
