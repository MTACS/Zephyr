//
//  ZPBackgroundController.m
//  ZephyrApplication
//
//  Created by DF on 10/23/25.
//

#import "ZPBackgroundController.h"

BOOL hasGlass(void) {
    return [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 26;
}

@interface ZPBackgroundController ()
@end

@implementation ZPBackgroundController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.borderColorWell.supportsAlpha = YES;
    self.borderColorWell.color = [self colorFromHexString:[self.defaults objectForKey:@"borderLayerColor"]] ?: [NSColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
    [self.appearanceButton selectItemAtIndex:[self.defaults integerForKey:@"dockAppearance"] ?: 0];
    [self updatePreferences];
}
- (void)updatePreferences {
    [self.hideBackgroundSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"hideBackgroundLayers"] ?: NSControlStateValueOff];
    [self.hideBorderSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"hideBorderLayer"] ?: NSControlStateValueOff];
    [self.colorBorderSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"colorBorderLayer"] ?: NSControlStateValueOff];
    [self.customLayerSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"useCustomLayer"] ?: NSControlStateValueOff];
    
    self.hideBorderSwitch.enabled = (![self.defaults boolForKey:@"hideBackgroundLayers"] ?: NO) && !hasGlass();
    self.colorBorderSwitch.enabled = (![self.defaults boolForKey:@"hideBackgroundLayers"] ?: NO) && !hasGlass();
    self.customLayerSwitch.enabled = (![self.defaults boolForKey:@"hideBackgroundLayers"]) ?: NO;
    self.customizeLayerButton.enabled = (![self.defaults boolForKey:@"hideBackgroundLayers"] ?: NO) && ([self.defaults boolForKey:@"useCustomLayer"] ?: NO);
    self.borderColorWell.enabled = (![self.defaults boolForKey:@"hideBackgroundLayers"] ?: NO) && !hasGlass();
    notify_post("com.mtac.zephyr.prefs.changed");
}
- (IBAction)hideBackgroundLayerChanged:(NSSwitch *)sender {
    [self.defaults setBool:sender.state forKey:@"hideBackgroundLayers"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)hideBorderLayerChanged:(NSSwitch *)sender {
    [self.defaults setBool:sender.state forKey:@"hideBorderLayer"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)colorBorderLayerChanged:(NSSwitch *)sender {
    [self.defaults setBool:sender.state forKey:@"colorBorderLayer"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)customLayerChanged:(NSSwitch *)sender {
    [self.defaults setBool:sender.state forKey:@"useCustomLayer"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)colorWellDidSelectColor:(NSColorWell *)sender {
    // self.customBadgeColorWell.color = sender.color;
    NSString *colorString = [self hexStringFromColor:self.borderColorWell.color];
    [self.defaults setObject:colorString forKey:@"borderLayerColor"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)selectAppearance:(NSPopUpButton *)sender {
    NSInteger selectedIndex = [sender.itemArray indexOfObject:sender.selectedItem];
    [self.defaults setInteger:selectedIndex forKey:@"dockAppearance"];
    [self.defaults synchronize];
    notify_post("com.mtac.zephyr.prefs.changed");
}
@end
