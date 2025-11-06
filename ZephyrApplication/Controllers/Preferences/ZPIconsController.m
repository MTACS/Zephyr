//
//  ZPIconsController.m
//  ZephyrApplication
//
//  Created by DF on 10/26/25.
//

#import "ZPIconsController.h"

@import UniformTypeIdentifiers;

@interface ZPIconsController ()
@end

@implementation ZPIconsController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customBadgeColorWell.supportsAlpha = YES;
    self.customBadgeColorWell.color = [self colorFromHexString:[self.defaults objectForKey:@"customBadgeColor"]] ?: [NSColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.00];
    [self updatePreferences];
}
- (void)updatePreferences {
    self.colorBadgesSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"colorBadges"] ?: NSControlStateValueOff;
    self.averageBadgesSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"averageBadges"] ?: NSControlStateValueOff;
    self.customBadgeColorSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"customBadgeColors"] ?: NSControlStateValueOff;
    self.trashBadgeSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"trashCountBadge"] ?: NSControlStateValueOff;
    self.folderBadgeSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"folderCountBadge"] ?: NSControlStateValueOff;
    
    self.averageBadgesSwitch.enabled = [self.defaults boolForKey:@"colorBadges"] ?: NO;
    self.customBadgeColorSwitch.enabled = [self.defaults boolForKey:@"colorBadges"] ?: NO;
    self.customBadgeColorWell.enabled = ([self.defaults boolForKey:@"colorBadges"] ?: NO) && ([self.defaults boolForKey:@"customBadgeColors"] ?: NO);
    self.imageBadgeButton.enabled = ([self.defaults boolForKey:@"useBadgeImage"] ?: NO);
    
    notify_post("com.mtac.zephyr.prefs.changed");
}
- (IBAction)colorIconBadgesChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"colorBadges"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)averageBadgesChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"averageBadges"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)customBadgeColorChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"customBadgeColors"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)trashBadgeCountChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"trashCountBadge"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)folderBadgeCountChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"folderCountBadge"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)imageBadgeSwitchChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:@"useBadgeImage"];
    if (sender.state == NSControlStateValueOn) {
        [self.defaults setBool:NO forKey:@"colorBadges"];
    }
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)chooseBadgeImage:(NSButton *)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseFiles = YES;
    openPanel.canChooseDirectories = NO;
    openPanel.allowsMultipleSelection = NO;
    openPanel.allowedContentTypes = @[UTTypePNG, UTTypeJPEG, UTTypeTIFF, UTTypeGIF];
    [openPanel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            NSURL *selectedFileURL = [openPanel.URLs firstObject];
                if (selectedFileURL) {
                    [self.defaults setObject:selectedFileURL.path forKey:@"customBadgeImage"];
                    [self.defaults synchronize];
                    [self updatePreferences];
                }
            }
        }
    ];
}
- (IBAction)colorWellDidSelectColor:(NSColorWell *)sender {
    NSString *colorString = [self hexStringFromColor:self.customBadgeColorWell.color];
    [self.defaults setObject:colorString forKey:@"customBadgeColor"];
    [self.defaults synchronize];
    [self updatePreferences];
}
@end
