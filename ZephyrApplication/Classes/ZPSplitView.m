//
//  ZPSplitView.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import "ZPSplitView.h"

@implementation ZPSplitView
- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)updateBlurStyle {
    NSView *first = [self.subviews objectAtIndex:0];
    NSVisualEffectView *effectView = [first.subviews firstObject];
    [effectView setMaterial:(NSVisualEffectMaterial)7];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSUInteger osx_ver = [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion;
    if (osx_ver < 26) {
        NSView *first = [self.subviews objectAtIndex:0];
        NSVisualEffectView *effectView = [first.subviews firstObject];
        [effectView setMaterial:NSVisualEffectMaterialSidebar];
    }
}
- (CGFloat)dividerThickness {
    return 0.5;
}
- (NSColor *)dividerColor {
    return [NSColor separatorColor];
}
@end

