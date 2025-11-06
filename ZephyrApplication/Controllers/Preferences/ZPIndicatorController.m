//
//  ZPIndicatorController.m
//  ZephyrApplication
//
//  Created by DF on 10/31/25.
//

#import "ZPIndicatorController.h"

@interface ZPIndicatorController ()
@end

@implementation ZPIndicatorController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customColorWell.supportsAlpha = YES;
    self.customColorWell.color = [self colorFromHexString:[self.defaults objectForKey:@"indicatorCustomColor"]] ?: [NSColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.00];
    [self updatePreferences];
}
- (void)updatePreferences {
    self.customColorSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"colorIndicator"] ?: NSControlStateValueOff;
    self.averageColorSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"averageColorIndicator"] ?: NSControlStateValueOff;
    
    self.widthStepper.integerValue = [self.defaults integerForKey:@"indicatorWidth"] ?: 0;
    self.heightStepper.integerValue = [self.defaults integerForKey:@"indicatorHeight"] ?: 0;
    
    self.widthLabel.stringValue = [NSString stringWithFormat:@"%ld", [self.defaults integerForKey:@"indicatorWidth"]];
    self.heightLabel.stringValue = [NSString stringWithFormat:@"%ld", [self.defaults integerForKey:@"indicatorHeight"]];
    
    self.customColorWell.enabled = [self.defaults boolForKey:@"colorIndicator"] ?: NO;
    notify_post("com.mtac.zephyr.prefs.changed");
}
- (IBAction)stepperValueChanged:(NSStepper *)sender {
    [self.defaults setInteger:sender.integerValue forKey:sender.identifier];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)colorWellDidSelectColor:(NSColorWell *)sender {
    NSString *colorString = [self hexStringFromColor:sender.color];
    [self.defaults setObject:colorString forKey:sender.identifier];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)customColorSwitchChanged:(NSSwitch *)sender {
    if ([self.defaults boolForKey:@"averageColorIndicator"] && sender.state == NSControlStateValueOn) {
        [self.defaults setBool:NO forKey:@"averageColorIndicator"];
    }
    [self.defaults setBool:(BOOL)sender.state forKey:@"colorIndicator"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)averageColorSwitchChanged:(NSSwitch *)sender {
    if ([self.defaults boolForKey:@"colorIndicator"] && sender.state == NSControlStateValueOn) {
        [self.defaults setBool:NO forKey:@"colorIndicator"];
    }
    [self.defaults setBool:(BOOL)sender.state forKey:@"averageColorIndicator"];
    [self.defaults synchronize];
    [self updatePreferences];
}
@end
