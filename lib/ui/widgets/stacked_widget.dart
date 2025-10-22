import 'package:flutter/material.dart';
import 'package:weather/ui/widgets/animated_search_widget.dart';

class StackedWidget extends StatelessWidget {
  const StackedWidget({
    super.key,
    required this.child,
    required this.isVisible,
    required this.onSelected,
  });
  final Widget child;
  final bool isVisible;
  final void Function() onSelected;

  @override
  Widget build(context) {
    return Stack(
      children: [
        Positioned(top: 0, bottom: 0, left: 0, right: 0, child: child),
        if (isVisible) AnimatedSearchWidget(onSelected: onSelected),
      ],
    );
  }
}
