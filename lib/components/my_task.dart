import 'package:flutter/material.dart';
import 'package:simple_auth/utils/colors.dart';

class MyTask extends StatelessWidget {
  const MyTask({
    super.key,
    required this.name,
    required this.description,
    required this.left,
  });
  final String name;
  final String description;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      margin: left
          ? EdgeInsets.only(left: 5, right: 45, bottom: 8, top: 8)
          : EdgeInsets.only(left: 45, right: 5, bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700], fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
