import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key, required this.leading, required this.trailing})
      : super(key: key);
  String leading;
  String trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(leading),
        TextButton(onPressed: () {}, child: Text(trailing)),
      ]),
    );
  }
}
