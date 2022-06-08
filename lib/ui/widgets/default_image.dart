import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultImage(String image, {double? width = 150}) {
  return CachedNetworkImage(
    imageUrl: image,
    imageBuilder: (context, imageProvider) => Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => Container(
      height: width,
      width: width,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
