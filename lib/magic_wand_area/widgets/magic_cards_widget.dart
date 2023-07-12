import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MagicCards extends StatelessWidget {
  final ValueNotifier<PointerHoverEvent?> mouseEvent;
  final ValueNotifier<Offset> wandPositionNotifier;
  final BoxConstraints constraints;

  const MagicCards({
    super.key,
    required this.mouseEvent,
    required this.wandPositionNotifier,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerPosition = constraints.biggest.center(Offset.zero);
        final firstPosition = centerPosition + const Offset(-80, 0);
        final secondPosition = centerPosition + const Offset(0, 0);
        final thirdPosition = centerPosition + const Offset(80, 0);
        return Stack(
          children: [
            MagicCard(
              rotation: 0.15,
              position: thirdPosition,
              wandPositionNotifier: wandPositionNotifier,
              imageAssetPath: 'assets/tower.jpg',
            ),
            MagicCard(
              rotation: -0.2,
              position: secondPosition,
              wandPositionNotifier: wandPositionNotifier,
              imageAssetPath: 'assets/swans.jpg',
            ),
            MagicCard(
              rotation: 0.1,
              position: firstPosition,
              wandPositionNotifier: wandPositionNotifier,
              imageAssetPath: 'assets/paintings.jpg',
            ),
          ],
        );
      },
    );
  }
}

class MagicCard extends StatelessWidget {
  final double rotation;
  final Offset position;
  final ValueNotifier<Offset> wandPositionNotifier;
  final String imageAssetPath;

  const MagicCard({
    super.key,
    required this.rotation,
    required this.position,
    required this.wandPositionNotifier,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final transformMatrix = Transform.rotate(
          angle: rotation,
        ).transform *
        Transform.translate(
          offset: Offset(rotation * -10, 0),
        ).transform;

    return Positioned(
      top: position.dy - 50,
      left: position.dx - 70,
      child: Container(
        height: 120,
        width: 120,
        transform: transformMatrix,
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: kElevationToShadow[2],
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1F2936),
              Color(0xFFB8B8B8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: MagicCardContent(
            position: position,
            wandPositionNotifier: wandPositionNotifier,
            imageAssetPath: imageAssetPath,
          ),
        ),
      ),
    );
  }
}

class MagicCardContent extends StatelessWidget {
  final Offset position;
  final ValueNotifier<Offset> wandPositionNotifier;
  final String imageAssetPath;

  const MagicCardContent({
    super.key,
    required this.position,
    required this.wandPositionNotifier,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: wandPositionNotifier,
      builder: (
        BuildContext context,
        Offset wandPosition,
        Widget? child,
      ) {
        return AnimatedCrossFade(
          duration: const Duration(
            milliseconds: 200,
          ),
          crossFadeState: wandPosition.dx > position.dx
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Stack(
            children: [
              Image.asset(
                imageAssetPath,
                fit: BoxFit.cover,
                isAntiAlias: true,
                height: 120,
                width: 120,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x33B8B8B8),
                      Color(0x33EEBE2D),
                    ],
                  ),
                ),
              ),
            ],
          ),
          secondChild: const Icon(
            Icons.image_search_rounded,
            color: Color(0xFF1F2936),
            size: 38,
          ),
          alignment: Alignment.center,
          layoutBuilder: crossFadeLayoutBuilder,
        );
      },
    );
  }

  Widget crossFadeLayoutBuilder(
    Widget topChild,
    Key topChildKey,
    Widget bottomChild,
    Key bottomChildKey,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        topChild,
        bottomChild,
      ],
    );
  }
}
