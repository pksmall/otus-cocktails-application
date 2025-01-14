import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 375.0,
          height: 343.0,
          alignment: Alignment.center,
          child: Image.network(imageUrl),
        ),
        Positioned(
          top: 20.0,
          left: 20.0,
          child: SvgPicture.asset('assets/images/icon_back.svg'),
        ),
        Positioned(
          top: 20.0,
          right: 20.0,
          child: SvgPicture.asset('assets/images/icon_out.svg'),
        )
      ],
    );
  }
}
