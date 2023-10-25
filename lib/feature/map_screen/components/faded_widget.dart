import 'package:flutter/material.dart';

class FadedWidget extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  const FadedWidget({super.key, required this.child, this.duration});

  @override
  State<FadedWidget> createState() => _FadedWidgetState();
}

class _FadedWidgetState extends State<FadedWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: widget.duration ?? const Duration(minutes: 5), vsync: this);
    animation = Tween(begin: 1.0, end: 0.1).animate(controller);
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(<double>[
        1 * animation.value,
        0,
        0,
        0,
        0,
        0,
        1 * animation.value,
        0,
        0,
        0,
        0,
        0,
        1 * animation.value,
        0,
        0,
        0,
        0,
        0,
        1 * animation.value,
        0,
      ]),
      child: widget.child,
    );
  }
}
