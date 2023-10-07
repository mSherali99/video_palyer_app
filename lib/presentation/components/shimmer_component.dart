import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponent extends StatelessWidget {
  const ShimmerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Shimmer.fromColors(
              period: const Duration(milliseconds: 1000),
              baseColor: Colors.grey.withOpacity(0.1),
              highlightColor: Colors.grey.withOpacity(0.6),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                height: 250,
                color: Colors.white,
              ),
            ),
            Shimmer.fromColors(
              period: const Duration(milliseconds: 1000),
              baseColor: Colors.grey.withOpacity(0.1),
              highlightColor: Colors.grey.withOpacity(0.6),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                height: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.1),
              highlightColor: Colors.grey.withOpacity(0.6),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                height: 250,
                color: Colors.white,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.1),
              highlightColor: Colors.grey.withOpacity(0.6),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                height: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
