//
//  ZPPreferencesController.h
//  ZephyrApplication
//
//  Created by DF on 10/31/25.
//

#import <Cocoa/Cocoa.h>
#import <notify.h>

@interface ZPPreferencesController : NSViewController
@property (nonatomic) NSUserDefaults *defaults;
- (NSColor *)colorFromHexString:(NSString *)hexString;
- (NSString *)hexStringFromColor:(NSColor *)color;
@end
