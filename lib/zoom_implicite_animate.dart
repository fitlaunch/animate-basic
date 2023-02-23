import 'package:animate1/flutter_animate_package.dart';
import 'package:flutter/material.dart';

class ZoomImpliciteAnimate extends StatefulWidget {
  const ZoomImpliciteAnimate({Key? key}) : super(key: key);

  @override
  State<ZoomImpliciteAnimate> createState() => _ZoomImpliciteAnimateState();
}

const defaultWidth = 100.0;

class _ZoomImpliciteAnimateState extends State<ZoomImpliciteAnimate> {
  var _isZoomIn = true;
  var _buttonTitle = 'Zoom Out';
  var _width = defaultWidth;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Zoom Me')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isZoomIn = !_isZoomIn;
                    _buttonTitle = _isZoomIn ? 'Zoom Out' : 'Zoom In';
                    _width = _isZoomIn
                        ? defaultWidth
                        : MediaQuery.of(context).size.width;
                    _curve = _isZoomIn ? Curves.bounceOut : Curves.bounceIn;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400), //300-500 = good
                  curve: _curve,
                  width: _width,
                  child: Image.asset(
                    'assets/images/greenhouse2.jpeg',
                    alignment: Alignment.center,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isZoomIn = !_isZoomIn;
                    _buttonTitle = _isZoomIn ? 'Zoom In' : 'Zoom Out';
                    _width = _isZoomIn
                        ? defaultWidth
                        : MediaQuery.of(context).size.width;
                    _curve = _isZoomIn ? Curves.bounceOut : Curves.bounceIn;
                  });
                },
                child: Text(_buttonTitle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FlutterAnimatePackage()),
                  );
                },
                child: const Text('Next Please'),
              ),
            ],
          ),
        ));
  }
}
