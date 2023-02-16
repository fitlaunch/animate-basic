import 'dart:math';

import 'package:flutter/material.dart';

///1- create row with containers. 2- enum and path to draw half circles
///3- set up halfcircleclipper  4- go stateful and add mixin
///5- create animation controller and animation
///6- set them up in the init state  7- dispose the controller
///8- wrap widget with transform and transform with animated builder
///9- instructions for controller forward, repeat, delay for bounce
///10- set up flip animation
///
enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0); //starting point
        offset = Offset(size.width, size.height); //ending point
        clockwise = false;
        break;
      case CircleSide.right:
        //path.moveTo(0, 0); //starting point not actually necessary here
        offset = Offset(0, size.height); //ending point
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close(); //completes from offset end point back to the start position
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  //actual custom clipper
  final CircleSide side; //so we can get path size
  HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);
  //throw UnimplementedError();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class SphereFlip extends StatefulWidget {
  const SphereFlip({Key? key}) : super(key: key);

  @override
  State<SphereFlip> createState() => _SphereFlipState();
}

extension on VoidCallback {
  //built for use in below build
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _SphereFlipState extends State<SphereFlip> with TickerProviderStateMixin {
  //not Single as more than one animation
  late AnimationController _counterClockwiseController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    _counterClockwiseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClockwiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2), //90 degrees counter clockwise
    ).animate(
      CurvedAnimation(
          parent: _counterClockwiseController, curve: Curves.bounceOut),
    );

    //Flip Animation
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(
      parent: _flipController,
      curve: Curves.bounceOut,
    ));
//status listener  => for listening to animations
    _counterClockwiseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          //new animation to keep it moving
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(CurvedAnimation(
          parent: _flipController,
          curve: Curves.bounceOut,
        ));
        //reset the flip controller and start the animation
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counterClockwiseRotationAnimation = Tween<double>(
          begin: _counterClockwiseRotationAnimation.value,
          end: _counterClockwiseRotationAnimation.value +
              -(pi / 2), //90 degrees counter clockwise
        ).animate(
          CurvedAnimation(
              parent: _counterClockwiseController, curve: Curves.bounceOut),
        );
        _counterClockwiseController
          ..reset()
          ..forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _counterClockwiseController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockwiseController
      ..reset()
      ..forward.delayed(
        const Duration(seconds: 1),
      ); //delayed from above future

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sphere Rotate',
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: _counterClockwiseRotationAnimation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_counterClockwiseRotationAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        //multiple for this example (more efficient ways)
                        animation: _flipController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..rotateY(_flipAnimation.value),
                            child: ClipPath(
                              clipper: HalfCircleClipper(side: CircleSide.left),
                              child: Container(
                                color: Colors.red,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: _flipController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..rotateY(_flipAnimation.value),
                            child: ClipPath(
                              clipper:
                                  HalfCircleClipper(side: CircleSide.right),
                              child: Container(
                                color: Colors.black,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
