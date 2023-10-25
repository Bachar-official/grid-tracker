import 'package:flutter/material.dart';

class FadedWidget extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final String? message;
  const FadedWidget(
      {super.key, required this.child, this.duration, this.message});

  @override
  State<FadedWidget> createState() => _FadedWidgetState();
}

class _FadedWidgetState extends State<FadedWidget> {
  bool isVisible = true;

  void setVisible() {
    isVisible = !isVisible;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5), setVisible);
  }

  @override
  void dispose() {
    isVisible = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0.2,
      duration: widget.duration ?? const Duration(minutes: 5),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          widget.child,
          widget.message != null
              ? Positioned(
                  bottom: 10,
                  left: 10,
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1 : 0,
                    duration: const Duration(seconds: 10),
                    child: Card(
                      child: Text(widget.message!),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
