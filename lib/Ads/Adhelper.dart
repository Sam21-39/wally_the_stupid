import 'dart:io';

import 'package:flutter/services.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      PlatformViewsService.synchronizeToNativeViewHierarchy(false);// this is added to stop flickering the adview on page change
      return 'ca-app-pub-4026417628443700/9197223812';
      // } else if (Platform.isIOS) {
      //   return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
