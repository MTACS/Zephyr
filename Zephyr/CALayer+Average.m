//
//  CALayer+Average.m
//  Zephyr
//
//  Created by DF on 10/21/25.
//

#import "CALayer+Average.h"
#import <CoreImage/CoreImage.h>

@implementation CALayer (AverageColor)

- (NSColor *)averageColor {
    CGImageRef cgImage = (__bridge CGImageRef)self.contents;
    if (!cgImage) {
        return nil;
    }
    CIImage *inputImage = [CIImage imageWithCGImage:cgImage];
    if (!inputImage) {
        return nil;
    }
    CIFilter *averageFilter = [CIFilter filterWithName:@"CIAreaAverage"];
    [averageFilter setValue:inputImage forKey:kCIInputImageKey];
    [averageFilter setValue:[CIVector vectorWithCGRect:inputImage.extent] forKey:kCIInputExtentKey];
    CIImage *outputImage = averageFilter.outputImage;
    if (!outputImage) {
        return nil;
    }
    CIContext *context = [CIContext contextWithOptions:@{kCIContextWorkingColorSpace: [NSNull null]}];
    
    unsigned char bitmap[4];
    [context render:outputImage
           toBitmap:bitmap
           rowBytes:4
             bounds:CGRectMake(0, 0, 1, 1)
             format:kCIFormatRGBA8
         colorSpace:nil];
    return [NSColor colorWithRed:(CGFloat)bitmap[0] / 255.0 green:(CGFloat)bitmap[1] / 255.0 blue:(CGFloat)bitmap[2] / 255.0 alpha:(CGFloat)bitmap[3] / 255.0];
}
@end
