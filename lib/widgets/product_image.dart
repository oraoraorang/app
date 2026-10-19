import 'package:flutter/material.dart';

/// Image.asset with a simple fallback if the file is missing.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (BuildContext context, Object error, StackTrace? stack) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined),
        );
      },
    );
  }
}
