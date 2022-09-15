import 'dart:async';

import 'package:news/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:news/widgets/snackbar/bars.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  static void show({bool dismissable = true}) async {
    Get.dialog(
      const Loading(),
      barrierDismissible: dismissable,
    );
  }

  static Future<T?> showUntil<T>(FutureOr<T> Function() task) async {
    Loading.show();
    T? result;
    Object? error;
    try {
      result = await task();
    } catch (e) {
      error = e;
    }
    Get.back();
    if (error != null) {
      errorSnackBar(title: "Error", error: error.toString());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Theme.of(context).theme;
    return Container(
      decoration: BoxDecoration(
        color: theme.background.withAlpha(192),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(8),
      child: SpinKitDoubleBounce(
        color: theme.action,
      ),
    );
  }
}
