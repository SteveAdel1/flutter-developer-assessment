import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_color.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const CachedImage({
    super.key,
    this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.shimmerBase,
                highlightColor: AppColors.shimmerHighlight,
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                color: Colors.grey[300],
                child: const Icon(Icons.error, color: Colors.red),
              ),
            )
          : Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.image, color: Colors.white70),
            ),
    );
  }
}
