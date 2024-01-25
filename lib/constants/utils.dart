import 'package:flutter/material.dart';

import '../common/widgets/custom_snack_bar.dart';

void showCustomSnackBar(BuildContext context, String text, bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    CustomSnackBar(
      message: text,
      isSuccess: isSuccess,
      icon: isSuccess ? Icons.check_circle_outline : Icons.error_outline,
    ),
  );
}
