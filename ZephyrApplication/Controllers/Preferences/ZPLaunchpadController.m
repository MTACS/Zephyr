//
//  ZPLaunchpadController.m
//  ZephyrApplication
//
//  Created by DF on 10/28/25.
//

#import "ZPLaunchpadController.h"

@interface ZPLaunchpadController ()
@end

@implementation ZPLaunchpadController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePreferences];
}
- (void)updatePreferences {
    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion < 26) {
        self.hideFolderBackgroundSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"hideFolderBackground"] ?: NSControlStateValueOff;
    } else {
        for (NSView *v in self.view.subviews) {
            [v removeFromSuperview];
        }
        NSTextField *label = [[NSTextField alloc] init];
        label.stringValue = @"Coming soon...";
        label.alignment = NSTextAlignmentCenter;
        label.bordered = NO;
        label.editable = NO;
        label.drawsBackground = NO;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:label];
        [NSLayoutConstraint activateConstraints:@[
            [label.widthAnchor constraintEqualToConstant:200],
            [label.heightAnchor constraintEqualToConstant:20],
            [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        ]];
    }
}
- (IBAction)folderBackgroundSwitchChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"hideFolderBackground"];
    [self.defaults synchronize];
    [self updatePreferences];
}
@end
