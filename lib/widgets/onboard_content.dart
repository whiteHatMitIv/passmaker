import 'package:flutter/material.dart';

class OnboardContent extends StatelessWidget {
  final String image, title;

  const OnboardContent({
    super.key,
    required this.image,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500
          ),
        ),
        const Spacer()
      ],
    );
  }
}