import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Image(
          height: 60,
          width: 65,
          image: AssetImage(
            "images/logo.png",
          ),
        ),
        Text(
          'Pet Zone',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
