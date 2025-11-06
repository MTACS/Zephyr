//
//  ZPSidebarCell.h
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import <Cocoa/Cocoa.h>

#define BORDER_SIZE 5
#define IMAGE_SIZE 30

@interface ZPSidebarCell : NSTextFieldCell
@property (nonatomic, strong) NSImageView *iconView;
@property (readwrite, retain) NSImage *icon;
@property (readwrite, copy) NSString *subtitle;
- (void)setIcon:(NSImage *)icon;
- (void)setSubtitle:(NSString *)subtitle;
@end
