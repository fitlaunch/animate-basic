import 'package:animate1/rolling_rock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlutterAnimatePackage extends StatelessWidget {
  const FlutterAnimatePackage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate Package'),
      ),
      body: Center(
        child: ListView(
          children: [
            const Divider(),
            Animate(
              effects: const [
                FadeEffect(),
                ScaleEffect(curve: Curves.bounceIn)
              ],
              child: const Text("Helloooooo World!"),
            ),
            const Divider(),
            const Text("Another Hello World!")
                .animate(delay: const Duration(seconds: 1))
                .fadeIn(
                  delay: const Duration(milliseconds: 500),
                )
                .scale(),
            const Divider(),
            const Text("Hello World Blur!")
                .animate()
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(
                    delay: 2000.ms,
                    duration: 600.ms) // runs after the above w/new duration
                .blurXY(
                    begin: 0.0,
                    end: 0.7), // inherits the delay & duration from move
            const Divider(),
            const Text('Color Me Hello')
                .animate(delay: const Duration(seconds: 2))
                .tint(color: Colors.greenAccent),
            const Divider(),
            const Text("Slow Hello Delay Move")
                .animate()
                .fadeIn(duration: 1600.ms)
                .then(delay: 800.ms) // baseline=800ms
                .slide(),
            const Divider(),
            Column(
                children: AnimateList(
              interval: 800.ms,
              effects: [FadeEffect(duration: 300.ms)],
              children: [
                const Text("Hello"),
                const Text("World"),
                const Text("Step Me In Slow")
              ],
            )),

// or shorthand:
            Column(
              children: [
                const Text("Hello2"),
                const Text("World2"),
                const Text("Step Me In Faster")
              ].animate(interval: 400.ms).fade(duration: 300.ms),
            ),
            const Divider(),
            Animate().toggle(
              duration: 2.seconds,
              builder: (_, value, __) => Text(value ? "Before" : "After"),
            ),
            const Divider(),
            Animate().toggle(
              duration: 10000.ms,
              builder: (_, value, __) => AnimatedContainer(
                duration: 2.seconds,
                color: value ? Colors.red : Colors.green,
              ),
            ),
            const Divider(),
            const Text("Swap Before").animate().swap(
                duration: 900.ms, builder: (_, __) => const Text("With After")),
            const Divider(),
            const Text("Hello").animate().fadeIn(duration: 600.ms).callback(
                duration: 3000.ms,
                callback: (_) => const Text('CallBack')), //print('halfway')),
            const Divider(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RollingRock()),
                  );
                },
                child: const Text('Another Animation?'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
