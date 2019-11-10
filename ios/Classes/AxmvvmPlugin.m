#import "AxmvvmPlugin.h"
#import <axmvvm/axmvvm-Swift.h>

@implementation AxmvvmPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAxmvvmPlugin registerWithRegistrar:registrar];
}
@end
