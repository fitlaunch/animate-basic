import 'package:animate1/spin_square.dart';
import 'package:flutter/material.dart';

class ScaledTransition extends StatefulWidget {
  const ScaledTransition({Key? key}) : super(key: key);

  @override
  State<ScaledTransition> createState() => _ScaledTransitionState();
}

class _ScaledTransitionState extends State<ScaledTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      //reverseDuration: const Duration(seconds: 3),
      vsync: this,
      value: .3, // starting size
      lowerBound: 0.3,
      upperBound: 1.0)
    ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo Scaling'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: const FlutterLogo(size: 150),
            ),
            const SizedBox(height: 100),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SpinSquare()),
                );
              },
              child: const Text('Another?'),
            ),
          ],
        ),
      ),
    );
  }
}
