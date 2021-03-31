import 'package:flutter/material.dart';

abstract class LoaderMixin {
  bool loaderOpen = false;

  showHideLoaderHelper(BuildContext context, bool conditional) {
    if (conditional) {
      showLoader(context);
    } else {
      hideLoader(context);
    }
  }

  showLoader(BuildContext context) {
    if (context == null) return null;
    if (!loaderOpen) {
      loaderOpen = true;
      return Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return Container(
              width: 20.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            );
          },
        );
      });
    }
  }

  hideLoader(BuildContext context) {
    if (context != null && loaderOpen) {
      loaderOpen = false;
      Navigator.of(context).pop();
    }
  }
}
