import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationControllerDemo(),
    );
  }
}

class AnimationControllerDemo extends StatefulWidget {
  @override
  _AnimationControllerDemoState createState() =>
      _AnimationControllerDemoState();
}

class _AnimationControllerDemoState extends State<AnimationControllerDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Animation duration of 2 seconds
      vsync: this,
    );

    // Tween defines the range of values (from 0 to 300 pixels)
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  void _resetAnimation() {
    _controller.reset(); // Reset animation to its original state (position 0)
  }

  void _toggleAnimation() {
    if (_controller.isAnimating) {
      _controller.stop(); // Stop the animation
    } else {
      if (_controller.status == AnimationStatus.completed) {
        _resetAnimation(); // Reset if animation has completed
      }
      _controller.forward(); // Start the animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated Container that moves across the screen
            Container(
              margin: EdgeInsets.only(
                  left: _animation.value), // Moves left to right
              width: 50,
              height: 50,
              color: Colors.yellow,
            ),
            SizedBox(height: 20),
            // Button to start/stop/reset the animation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleAnimation,
                  child: Text(
                    _controller.isAnimating
                        ? 'Stop Animation'
                        : _controller.status == AnimationStatus.completed
                            ? 'Restart Animation'
                            : 'Start Animation',
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetAnimation,
                  child: Text('Reset to Start'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
