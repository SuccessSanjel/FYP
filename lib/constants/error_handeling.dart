import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamro_doctor/constants/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showCustomSnackBar(context, jsonDecode(response.body)['msg'], false);
      break;
    case 500:
      showCustomSnackBar(context, jsonDecode(response.body)['error'], false);
      break;
    default:
      showCustomSnackBar(context, jsonDecode(response.body), false);
  }
}
