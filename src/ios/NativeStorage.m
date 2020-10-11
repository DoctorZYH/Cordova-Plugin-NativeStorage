/********* NativeStorage.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface NativeStorage : CDVPlugin {
  // Member variables go here.
}

- (void)set:(CDVInvokedUrlCommand*)command;
- (void)get:(CDVInvokedUrlCommand*)command;

@end

@implementation NativeStorage

- (void)set:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    NSDictionary *dict = command.arguments[0];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"value"] forKey:dict[@"key"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)get:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    NSDictionary *dict = command.arguments[0];
    if (![dict isKindOfClass:[NSDictionary class]]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:dict[@"key"]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
