import 'package:flutter/material.dart';

// full screen dialog for time consuming process.
void showFullScreenLoadingDialog({required BuildContext context, required String message}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20,),
              Text(message),
            ]
          )
        );
      }
    );
}
