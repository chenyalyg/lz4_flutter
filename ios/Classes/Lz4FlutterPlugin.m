#import "Lz4FlutterPlugin.h"
#if __has_include(<lz4_flutter/lz4_flutter-Swift.h>)
#import <lz4_flutter/lz4_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lz4_flutter-Swift.h"
#endif

@implementation Lz4FlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLz4FlutterPlugin registerWithRegistrar:registrar];
}
@end
