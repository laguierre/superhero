import 'package:flutter/material.dart';

const kTextColor = Colors.black54;
const kCircularAvatarSize = 100.0;
const kPaddingSideCard = 37.5;
Color kSearchColor = Colors.grey.shade300;
BoxShadow kShadowContainer = BoxShadow(
  color: Colors.white.withOpacity(0.8),
  spreadRadius: 7,
  blurRadius: 7,
  offset: const Offset(0, 3), // changes position of shadow
);
LinearGradient linearGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0C7551),
      Color(0xFF08714E),
      Color(0xFF2D8F62),
      Color(0xFF53B076),
    ]);
const TextStyle textStyleListTile = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
const TextStyle textStyleSubtitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontStyle: FontStyle.italic);
const int kDurationDetails = 500;
const kSearchContainerPercent = 0.21;