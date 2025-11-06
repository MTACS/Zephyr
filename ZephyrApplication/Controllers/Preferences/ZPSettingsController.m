//
//  ZPSettingsController.m
//  ZephyrApplication
//
//  Created by DF on 11/1/25.
//

#import "ZPSettingsController.h"

@interface ZPSettingsController ()
@end

@implementation ZPSettingsController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePreferences];
}
- (void)updatePreferences {
    self.dockMenuSwitch.state = (NSControlStateValue)[self.defaults boolForKey:@"showDockMenu"] ?: NSControlStateValueOn;
}
- (IBAction)dockMenuSwitchChanged:(NSSwitch *)sender {
    [self.defaults setBool:sender.state forKey:@"showDockMenu"];
    [self.defaults synchronize];
}
- (IBAction)resetSettings:(NSButton *)sender {
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:@"com.mtac.zephyr"];
}
- (IBAction)importSettings:(NSButton *)sender {
    
}
- (IBAction)exportSettings:(NSButton *)sender {
    
}
@end
