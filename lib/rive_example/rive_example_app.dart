import 'package:animate1/rive_example/play_one_shot_Animation.dart';
import 'package:animate1/rive_example/play_pause_animation.dart';
import 'package:animate1/rive_example/simple_asset_animation.dart';
import 'package:animate1/rive_example/simple_networking_animation.dart';
import 'package:animate1/rive_example/simple_state_machine.dart';
import 'package:animate1/rive_example/skinning_demo.dart';
import 'package:animate1/rive_example/speedy_animation.dart';
import 'package:animate1/rive_example/state_machine_listener.dart';
import 'package:animate1/rive_example/state_machine_skills.dart';
import 'package:animate1/spin_square.dart';
import 'package:flutter/material.dart';

import 'carousel.dart';
import 'example_state_machine.dart';
import 'liquid_download.dart';
import 'little_machine.dart';

class RiveExampleApp extends StatefulWidget {
  const RiveExampleApp({Key? key}) : super(key: key);

  @override
  State<RiveExampleApp> createState() => _RiveExampleAppState();
}

class _RiveExampleAppState extends State<RiveExampleApp> {
  // Example animations
  final _pages = [
    const _Page('Simple Animation - Asset', SimpleAssetAnimation()),
    const _Page('Simple Animation - Network', SimpleNetworkAnimation()),
    const _Page('Play/Pause Animation', PlayPauseAnimation()),
    const _Page('Play One-Shot Animation', PlayOneShotAnimation()),
    const _Page('Button State Machine', ExampleStateMachine()),
    const _Page('Skills Machine', StateMachineSkills()),
    const _Page('Little Machine', LittleMachine()),
    const _Page('Liquid Download', LiquidDownload()),
    const _Page('Custom Controller - Speed', SpeedyAnimation()),
    const _Page('Simple State Machine', SimpleStateMachine()),
    const _Page('State Machine with Listener', StateMachineListener()),
    const _Page('Skinning Demo', SkinningDemo()),
    const _Page('Animation Carousel', AnimationCarousel()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Examples')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    _NavButton(page: _pages[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: _pages.length,
              ),
            ),
            const SizedBox(height: 10),
            const Text('More At https://github.com/rive-app/awesome-rive'),
            const SizedBox(height: 20),
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

/// Class used to organize demo pages.
class _Page {
  final String name;
  final Widget page;

  const _Page(this.name, this.page);
}

/// Button to navigate to demo pages.
class _NavButton extends StatelessWidget {
  const _NavButton({required this.page});

  final _Page page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: SizedBox(
          width: 250,
          child: Center(
            child: Text(
              page.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => page.page,
            ),
          );
        },
      ),
    );
  }
}
