import 'dart:async';

import 'package:flutter/services.dart';

class CompressImage {
  static const MethodChannel _channel =
      const MethodChannel('compress_image');

  static Future<String> compress({String imageSrc, int desiredQuality}) async {
    final Map<String, dynamic> params = <String, dynamic> {
      'filePath': imageSrc,
      'desiredQuality': desiredQuality
    };
    final String filePath = await _channel.invokeMethod('compressImage', params);
    return filePath;
  }
}
