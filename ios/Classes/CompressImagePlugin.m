#import "CompressImagePlugin.h"

@implementation CompressImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"compress_image"
            binaryMessenger:[registrar messenger]];
  CompressImagePlugin* instance = [[CompressImagePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"compressImage" isEqualToString:call.method]) {
    NSString *imagePath = call.arguments[@"filePath"];
    int desiredQuality = call.arguments[@"desiredQuality"];
    float calculatedQuality = desiredQuality/1602.0;
    UIImage *highResImage=[UIImage imageWithContentsOfFile:imagePath];
    NSData *compressedImageData = UIImageJPEGRepresentation(highResImage, calculatedQuality);
    [compressedImageData writeToFile:imagePath atomically:YES];
    result(@"Image compressed successfully");
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
