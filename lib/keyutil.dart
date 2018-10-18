import 'dart:async';

import 'package:flutter/services.dart';

class KeyUtils {
  static const MethodChannel _channel =
      const MethodChannel('com.bzh.dytt/key_utils');

  KeyUtils();

  Future<String> getHeaderKey(int currentTime) async =>
      await _channel.invokeMethod("getHeaderKey", currentTime);
}
