import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAnimation extends StatefulWidget {
  const ConfettiAnimation({super.key, required this.animate});

  final bool animate;

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation>
    with SingleTickerProviderStateMixin {
  final _controller = ConfettiController(duration: const Duration(seconds: 3));

  @override
  void didUpdateWidget(covariant ConfettiAnimation oldWidget) {
    if (widget.animate) {
      _controller.play();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(confettiController: _controller, blastDirectionality: BlastDirectionality.explosive,);
  }
}
