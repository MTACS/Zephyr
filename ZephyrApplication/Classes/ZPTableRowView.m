//
//  ZPTableRowView.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import "ZPTableRowView.h"

@implementation ZPTableRowView
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}
/* - (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSRect selectionRect = NSInsetRect(self.bounds, 2.5, 2.5);
        [[NSColor secondaryLabelColor] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:6 yRadius:6];
        [selectionPath fill];
    }
} */
- (BOOL)isEmphasized {
    return YES;
}
- (void)setEmphasized:(BOOL)emphasized {
    [super setEmphasized:emphasized];
    [self setNeedsDisplay:YES];
}
@end
