//
//  ZPWindowController.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import "ZPWindowController.h"

#import "Preferences/ZPHUDController.h"

@interface ZPWindowController ()
@end

@implementation ZPWindowController
- (void)awakeFromNib {
    [super awakeFromNib];
    NSDictionary *preferences = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.mtac.zephyr"];
    if (preferences.allKeys.count == 0) {
        ZPHUDController *initializeController = [[NSStoryboard mainStoryboard] instantiateControllerWithIdentifier:@"initializeController"];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.window.contentViewController presentViewControllerAsSheet:initializeController];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.contentViewController dismissViewController:initializeController];
                [self.window update];
            });
        });
    }
}
- (void)windowDidLoad {
    [super windowDidLoad];
    [self removeBackground:self.window];
}
- (void)removeBackground:(NSWindow *)window {
    [window setBackgroundColor:[NSColor clearColor]];
   
    self.effectView = [[NSVisualEffectView alloc] initWithFrame:NSMakeRect(0, 0, window.contentView.bounds.size.width, window.contentView.bounds.size.height + 30)];
    [self.effectView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self.effectView setBlendingMode:NSVisualEffectBlendingModeBehindWindow];
    [self.effectView setState:NSVisualEffectStateActive];
    if (![self.effectView isDescendantOf:window.contentView]) {
        [[window contentView] addSubview:self.effectView positioned:NSWindowBelow relativeTo:nil];
    }

    [window.contentView setWantsLayer:YES];
    window.contentView.layer.backgroundColor = [NSColor clearColor].CGColor;
    
    [self.effectView setMaterial:(NSVisualEffectMaterial)7];
}
@end
