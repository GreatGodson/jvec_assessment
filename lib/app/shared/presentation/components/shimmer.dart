import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/framework/theme/spacings/spacings.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = Spacings.spacing8,
    this.margin,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    )
        .animate(
      onPlay: (controller) => controller.repeat(), // Loops the animation
    )
        .shimmer(
      duration: const Duration(seconds: 2),
      colors: [
        Colors.grey.shade300,
        Colors.grey.shade200,
        Colors.grey.shade300,
      ],
    );
  }
}

class ShimmerListViewWidget extends StatelessWidget {
  const ShimmerListViewWidget({super.key, this.length = 6});

  final int length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Spacings.spacing20,
      ),
      child: Column(
        children: List.generate(
          length,
          (i) {
            return const ShimmerWidget(
              margin: EdgeInsets.symmetric(vertical: Spacings.spacing4),
              width: double.infinity,
              height: Spacings.spacing64,
            );
          },
        ),
      ),
    );
  }
}
