#import "GetPermissionPlugin.h"
#if __has_include(<get_permission/get_permission-Swift.h>)
#import <get_permission/get_permission-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "get_permission-Swift.h"
#endif

@implementation GetPermissionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGetPermissionPlugin registerWithRegistrar:registrar];
}
@end
