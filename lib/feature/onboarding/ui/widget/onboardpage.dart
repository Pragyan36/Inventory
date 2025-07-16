import 'package:flutter/material.dart';

Widget onboardPage({
  required String imagePath,
  required double screenHeight,
  required int activeIndex,
  required String tag,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(height: 30),
      Image.asset(
        'assets/logo.png',
        height: 100,
        width: 250,
      ),
      SizedBox(
        height: 500,
        width: double.infinity,
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
      Column(
        children: [
          Text(
            tag,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(active: activeIndex == 0),
              _dot(active: activeIndex == 1),
              _dot(),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _dot({bool active = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: active ? 18 : 8,
    height: 8,
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.white24,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
