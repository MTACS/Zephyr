//
//  ZPSeparatorController.m
//  ZephyrApplication
//
//  Created by DF on 10/29/25.
//

#import "ZPSeparatorController.h"

@interface ZPSeparatorController ()
@end

@implementation ZPSeparatorController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.separatorColorWell.supportsAlpha = YES;
    self.separatorColorWell.color = [self colorFromHexString:[self.defaults objectForKey:@"separatorColor"]] ?: [NSColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
    
    self.recentSeparatorColorWell.supportsAlpha = YES;
    self.recentSeparatorColorWell.color = [self colorFromHexString:[self.defaults objectForKey:@"recentSeparatorColor"]] ?: [NSColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
    
    [self updatePreferences];
}
- (void)updatePreferences {
    [self.hideSeparatorSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"hideSeparator"] ?: NSControlStateValueOff];
    [self.colorSeparatorSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"colorSeparator"] ?: NSControlStateValueOff];
    [self.hideRecentSeparatorSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"hideRecentSeparator"] ?: NSControlStateValueOff];
    [self.colorRecentSeparatorSwitch setState:(NSControlStateValue)[self.defaults boolForKey:@"colorRecentSeparator"] ?: NSControlStateValueOff];
    [self.separatorWidthStepper setIntegerValue:[self.defaults integerForKey:@"separatorWidth"] ?: 0];
    [self.separatorHeightStepper setIntegerValue:[self.defaults integerForKey:@"separatorHeight"] ?: 0];
    [self.recentSeparatorWidthStepper setIntegerValue:[self.defaults integerForKey:@"recentSeparatorWidth"] ?: 0];
    [self.recentSeparatorHeightStepper setIntegerValue:[self.defaults integerForKey:@"recentSeparatorHeight"] ?: 0];
    [self.separatorWidthLabel setStringValue:[NSString stringWithFormat:@"%ld", [self.defaults integerForKey:@"separatorWidth"] ?: 0]];
    [self.separatorHeightLabel setStringValue:[NSString stringWithFormat:@"%ld", [self.defaults integerForKey:@"separatorHeight"] ?: 0]];
    [self.recentSeparatorWidthLabel setStringValue:[NSString stringWithFormat:@"%ld", [self.defaults integerForKey:@"recentSeparatorWidth"] ?: 0]];
    [self.recentSeparatorHeightLabel setStringValue:[NSString stringWithFormat:@"%ld", [self.defaults integerForKey:@"recentSeparatorHeight"] ?: 0]];
    notify_post("com.mtac.zephyr.prefs.changed");
}
- (IBAction)stepperValueChanged:(NSStepper *)sender {
    [self.defaults setInteger:sender.integerValue forKey:sender.identifier];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)switchChanged:(NSSwitch *)sender {
    [self.defaults setBool:(BOOL)sender.state forKey:sender.identifier];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)colorWellDidSelectColor:(NSColorWell *)sender {
    // self.customBadgeColorWell.color = sender.color;
    NSString *colorString = [self hexStringFromColor:sender.color];
    [self.defaults setObject:colorString forKey:sender.identifier];
    [self.defaults synchronize];
    [self updatePreferences];
}
@end
