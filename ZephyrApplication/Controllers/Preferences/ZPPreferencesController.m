//
//  ZPPreferencesController.m
//  ZephyrApplication
//
//  Created by DF on 10/31/25.
//

#import "ZPPreferencesController.h"

@interface ZPPreferencesController ()

@end

@implementation ZPPreferencesController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.mtac.zephyr"];
}
- (NSColor *)colorFromHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;

    switch ([colorString length]) {
        case 6:
            alpha = 1.0f;
            break;
        case 8:
            alpha = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            return nil;
    }

    red = [self colorComponentFrom:colorString start:0 length:2];
    green = [self colorComponentFrom:colorString start:2 length:2];
    blue = [self colorComponentFrom:colorString start:4 length:2];

    return [NSColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSRange range = NSMakeRange(start, length);
    NSString *substring = [string substringWithRange:range];
    NSScanner *scanner = [NSScanner scannerWithString:substring];
    unsigned int hexValue;
    if ([scanner scanHexInt:&hexValue]) {
        return (CGFloat)hexValue / 255.0f;
    }
    return 0.0f;
}
- (NSString *)hexStringFromColor:(NSColor *)color {
    NSColor *rgbColor = [color colorUsingColorSpace:[NSColorSpace sRGBColorSpace]];
    
    CGFloat red, green, blue, alpha;
    [rgbColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX",
                lround(red * 255),
                lround(green * 255),
                lround(blue * 255),
                lround(alpha * 255)];
}
@end
