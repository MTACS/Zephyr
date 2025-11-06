//
//  ZPTableView.m
//  ZephyrApplication
//
//  Created by DF on 10/25/25.
//

#import "ZPTableView.h"

@implementation ZPTableView
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}
/* - (void)highlightSelectionInClipRect:(NSRect)clipRect {
    NSColor *customHighlightColor = [NSColor clearColor];
    
    NSIndexSet *selectedRows = [self selectedRowIndexes];
    [selectedRows enumerateIndexesUsingBlock:^(NSUInteger row, BOOL *stop) {
        NSRect rowRect = [self rectOfRow:row];
        [customHighlightColor set];
        NSRectFillUsingOperation(rowRect, NSCompositingOperationSourceOver);
    }];
} */
@end
