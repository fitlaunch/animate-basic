import 'dart:math' as math;

import 'package:animate1/spin_square.dart';
import 'package:flutter/material.dart';

/* 0xFFFFFFFF = A R G B = 32 bits
A = Alpha (0-255) - 8 bits
R = Red (0-255) - 8 bits
G = Green (0-255) - 8 bits
B = Blue (0-255) - 8 bits
 */
//Color getRandomColor() => Color(0xFF000000 + mathRandom().nextInt(0x00FFFFFF));
Color getRandomColor() =>
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(.9);

class StrobeCircle extends StatefulWidget {
  const StrobeCircle({
    Key? key,
  }) : super(key: key);

  @override
  State<StrobeCircle> createState() => _StrobeCircleState();
}

class _StrobeCircleState extends State<StrobeCircle> {
  var _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle - Color Animation'),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Another Flart Animation?'),
                  ),
                  FlutterLogo(size: 50),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SpinSquare(),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipPath(
                clipper: const CircleClipper(),
                child: TweenAnimationBuilder(
                  tween: ColorTween(
                    begin: getRandomColor(),
                    end: _color,
                  ),
                  onEnd: () {
                    setState(() {
                      _color = getRandomColor();
                    });
                  },
                  duration: const Duration(seconds: 1),
                  builder: (context, Color? color, child) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                      child: child,
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();
  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
      //a rectangle that contains a circle
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
