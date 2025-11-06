//
//  ZPSidebarCell.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import "ZPSidebarCell.h"

@implementation ZPSidebarCell
- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect imageRect = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + (cellFrame.size.height - 30) / 2, 30, 30);
    // [self.icon drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
    [self.icon drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0 respectFlipped:YES hints:nil];
    cellFrame.origin.x += 35;
    cellFrame.size.width -= 35;
    // [super drawInteriorWithFrame:cellFrame inView:controlView];
    
    NSAttributedString *attrString = self.attributedStringValue;

    if (self.isHighlighted && self.backgroundStyle == NSBackgroundStyleEmphasized) {
        NSMutableAttributedString *whiteString = attrString.mutableCopy;
        [whiteString addAttribute: NSForegroundColorAttributeName value:[NSColor whiteColor] range: NSMakeRange(0, whiteString.length)];
           attrString = whiteString;
    }

    [attrString drawWithRect:[self titleRectForBounds:cellFrame] options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin];
}
- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];

    NSAttributedString *attrString = self.attributedStringValue;
    NSRect textRect = [attrString boundingRectWithSize: titleFrame.size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin];

    if (textRect.size.height < titleFrame.size.height) {
        titleFrame.origin.y = theRect.origin.y + (theRect.size.height - textRect.size.height) / 2.0;
        titleFrame.size.height = textRect.size.height;
    }
    return titleFrame;
}
@end
