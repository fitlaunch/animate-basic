import 'dart:math';

import 'package:animate1/sphere_flip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SpinSquare extends StatefulWidget {
  const SpinSquare({
    Key? key,
  }) : super(key: key);

  @override
  State<SpinSquare> createState() => _SpinSquareState();
}

class _SpinSquareState extends State<SpinSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, //SingleTickerProviderStateMixin needed for this
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    _controller.loop(count: 6, reverse: true);
    //.repeat(reverse: true);
    //or => ..repeat();
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    //end: 0.2 * pi = quick tilt
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
        title: const Text('Spinning Square'),
      ),
      body: Center(
        child: AnimatedBuilder(
          //this wraps what will be animated, usually the Transform
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment:
                  Alignment.center, //for this could be origin: Offset (50,50),
              transform: Matrix4.identity()
                ..rotateX(_animation.value) //X axis rotate
                ..rotateZ(.2), //Z axis rotate combined in = tilted rotation.
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SphereFlip(),
                      ));
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
