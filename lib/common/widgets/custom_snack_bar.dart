import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String message;
  final bool isSuccess;
  final IconData icon;

  CustomSnackBar({
    super.key,
    required this.message,
    this.isSuccess = false,
    this.icon = Icons.error_outline,
  }) : super(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                icon,
                color: Colors.white,
              ),
            ],
          ),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        );
}
