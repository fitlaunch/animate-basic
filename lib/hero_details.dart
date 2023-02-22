import 'package:flutter/material.dart';

import 'hero.dart';

class HeroDetails extends StatelessWidget {
  final Person person;
  const HeroDetails({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                //wrapping with material and color transparent remove yellow line
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                      //scaletransition to control movement (curve)
                      scale: animation.drive(
                        Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.fastOutSlowIn),
                        ),
                      ),
                      child: toHeroContext.widget),
                );
              case HeroFlightDirection.pop:
                return Material(
                    color: Colors.transparent,
                    child: ScaleTransition(
                        scale: animation
                            .drive(Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.linearToEaseOut),
                        )),
                        child: fromHeroContext.widget));
            }
            //return const Text('🔥'); //shows animation of fire dragging between images
          },
          tag: person.name,
          child: Text(
            '${person.emoji} ${person.name}',
            style: const TextStyle(fontSize: 36),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              person.name,
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Text(
              '${person.age} years old',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
