import 'package:animate1/hero.dart';
import 'package:flutter/material.dart';

//MAPP

class RotateRepeat extends StatefulWidget {
  const RotateRepeat({Key? key}) : super(key: key);

  @override
  State<RotateRepeat> createState() => _RotateRepeatState();
}

class _RotateRepeatState extends State<RotateRepeat>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCirc,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotate Me'),
      ),
      body: Center(
          child: RotationTransition(
        turns: _animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: const FlutterLogo(size: 150),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HeroPage(),
                ),
              );
            },
          ),
        ),
      )),
    );
  }
}
