import 'package:flutter/material.dart';

class CharacterBackground extends StatelessWidget {
  final String imagePath;
  final BorderRadiusGeometry borderRadius;
  final double height;
  final double width;

  const CharacterBackground({
    Key key,
    @required this.imagePath,
    @required this.height,
    @required this.width,
    this.borderRadius,
  })  : assert(imagePath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.red,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets" + imagePath),
            ),
          ),
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [
                0.05,
                0.95,
              ],
              colors: [
                Colors.black,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
