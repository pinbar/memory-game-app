import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_manager.dart';
import 'question_mark_tile.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation(
      {super.key,
      required this.word,
      required this.animate,
      required this.reverse,
      required this.animationCompleted});

  final Widget word;
  final bool animate;
  final bool reverse;
  final Function(int) animationCompleted;

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.animationCompleted.call(0);
      }
      if (status == AnimationStatus.dismissed) {
        widget.animationCompleted.call(1);
      }
    });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );
  }

  @override
  void didUpdateWidget(covariant FlipAnimation oldWidget) {
    if (widget.animate) {
      _controller.forward();
    }
    if (widget.reverse) {
      _controller.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(_animation.value * pi),
        child: _controller.value >= 0.5
            ? context.read<GameManager>().isNewGame ? const QuestionMarkTile() : widget.word
            : const QuestionMarkTile(),
      ),
    );
  }
}
