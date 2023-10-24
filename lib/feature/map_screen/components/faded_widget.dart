import 'package:flutter/material.dart';

class FadedWidget extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Function()? onEnd;
  const FadedWidget(
      {super.key, required this.child, this.duration, this.onEnd});

  @override
  State<FadedWidget> createState() => _FadedWidgetState();
}

class _FadedWidgetState extends State<FadedWidget> {
  bool _visible = true;

  void fadeOut() {
    _visible = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), fadeOut);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      onEnd: widget.onEnd,
      opacity: _visible ? 1 : 0,
      duration: widget.duration ?? const Duration(minutes: 5),
      child: widget.child,
    );
  }
}
