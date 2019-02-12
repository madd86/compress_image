package io.resdigital.compressimage;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** CompressImagePlugin */
public class CompressImagePlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "compress_image");
    channel.setMethodCallHandler(new CompressImagePlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("compressImage")) {
      try {
        String filePath = call.argument("filePath");
        Integer desiredQuality = call.argument("desiredQuality");
        Bitmap bitmap = BitmapFactory.decodeFile(filePath);
        assert filePath != null;
        assert desiredQuality != null;
        OutputStream imageFile = new FileOutputStream(filePath);
        bitmap.compress(Bitmap.CompressFormat.JPEG, desiredQuality, imageFile);
        result.success("Image compressed successfully");
      } catch (FileNotFoundException e) {
        e.printStackTrace();
      }
    } else {
      result.notImplemented();
    }
  }
}
