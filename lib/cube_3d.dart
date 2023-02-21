import 'dart:math';

import 'package:animate1/rotate_repeat.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

///Flutter render engine has issues with 3d.  This is close using their current engine.

const widthAndHeight = 100.0; //? ha, so we can write widthAndHeight many times
//and not have to write 100 many times.

//animation controllers need stateful to dispose
class Cube3d extends StatefulWidget {
  const Cube3d({
    Key? key,
  }) : super(key: key);

  @override
  State<Cube3d> createState() => _Cube3dState();
}

class _Cube3dState extends State<Cube3d> with TickerProviderStateMixin {
  //3 animation controllers to deal with the 3d effect
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(
        title: const Text('3d Cube Animate'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: widthAndHeight, width: double.infinity),
            AnimatedBuilder(
              animation: Listenable.merge([
                //this allows us to merge
                // controllers and use one animated builder for all
                _xController,
                _yController,
                _zController,
              ]),
              builder: (context, child) {
                //at this point cut the stack and place
                //within and return it
                return Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.identity() //following binding single animation
                        //to all three controllers.  'evaluate' is key
                        ..rotateX(_animation.evaluate(_xController))
                        ..rotateY(_animation.evaluate(_yController))
                        ..rotateZ(_animation.evaluate(_zController)),
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                            //front side
                            color: Colors.green,
                            width: widthAndHeight,
                            height: widthAndHeight),
                        //left side
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi / 2),
                          child: Container(
                              //back side
                              color: Colors.white70,
                              width: widthAndHeight,
                              height: widthAndHeight),
                        ),
                        //right side
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(-pi / 2),
                          child: Container(
                              //back side
                              color: Colors.black54,
                              width: widthAndHeight,
                              height: widthAndHeight),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..translate(Vector3(0, 0, -widthAndHeight)),
                          // nope => ..translate(0, 0, -widthAndHeight),
                          child: Container(
                              //back side
                              color: Colors.blueAccent,
                              width: widthAndHeight,
                              height: widthAndHeight),
                        ),
                        //top side
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()..rotateX(-pi / 2),
                          child: Container(
                              //back side
                              color: Colors.amber,
                              width: widthAndHeight,
                              height: widthAndHeight),
                        ),
                        //bottom side
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(pi / 2),
                          child: Container(
                              //back side
                              color: Colors.red,
                              width: widthAndHeight,
                              height: widthAndHeight),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RotateRepeat()),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
