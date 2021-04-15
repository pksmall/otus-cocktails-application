import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DartUiWidgetsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          _buildGradientText(),
          const SizedBox(height: 100),
          // _buildTransformedContainer(),
          const SizedBox(height: 100),
          // _buildClipPath(),
          const SizedBox(height: 100),
          // _buildColored(),
        ],
      ),
    );
  }

  Widget _buildGradientText() {
    final shader = ui.Gradient.linear(
      Offset.zero,
      Offset(360, 0),
      <Color>[
        Colors.purpleAccent,
        Colors.deepPurple,
      ],
    );
    final paint = Paint()..shader = shader;

    return Text(
      "Welcome back, commander!",
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w900,
        foreground: paint,
      ),
    );
  }

  Widget _buildTransformedContainer() {
    final matrix = Matrix4.skewX(0.9)..rotateZ(pi / 30);

    return Container(
      transform: matrix,
      child: Text(
        "You have new replies",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildClipPath() {
    return Center(
      child: ClipPath(
        clipper: _RhombusClipper(),
        child: Image.asset("assets/image.jpg"),
      ),
    );
  }

  Widget _buildColored() {
    return Center(
      child: ClipRect(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.yellowAccent,
            BlendMode.multiply,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/image.jpg"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text("Press me"),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _RhombusClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) => false;
}
