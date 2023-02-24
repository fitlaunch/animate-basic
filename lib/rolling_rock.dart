import 'dart:ui';

import 'package:animate1/strobe_circle.dart';
import 'package:flutter/material.dart';

///explicit animation ROAA Medium

class RollingRock extends StatefulWidget {
  const RollingRock({Key? key}) : super(key: key);

  @override
  State<RollingRock> createState() => _RollingRockState();
}

class _RollingRockState extends State<RollingRock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Rock'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlurContainer(
              containerHeight: 150,
              child: AlignTransition(
                alignment: _alignAnimation,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: const Rectangle(
                    color1: Colors.pink,
                    color2: Colors.pinkAccent,
                    width: 100,
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StrobeCircle()),
              );
            },
            child: const Text('Another?'),
          ),
          const AnimatedBuilderExample(),
        ],
      ),
    );
  }
}

class Rectangle extends StatelessWidget {
  const Rectangle({
    Key? key,
    this.width = 60,
    this.height = 40,
    required this.color1,
    required this.color2,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color1;
  final Color color2;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class BlurContainer extends StatelessWidget {
  const BlurContainer({
    Key? key,
    this.containerHeight = 120,
    this.child,
  }) : super(key: key);

  final double containerHeight;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          clipBehavior: Clip.none,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({Key? key}) : super(key: key);

  @override
  _AnimatedBuilderExampleState createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
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
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Colors.purple, Colors.pink, Colors.green],
              stops: [0, _controller.value, 20],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
          ),
        );
      },
    );
  }
}
