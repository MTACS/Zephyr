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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        restart();
    });
}
- (IBAction)importSettings:(NSButton *)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setResolvesAliases:YES];
    [openPanel setAllowedContentTypes:@[UTTypePropertyList]];
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSArray<NSURL *> *selectedURLs = openPanel.URLs;
            NSURL *settingsFileURL = [selectedURLs firstObject];
            NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfURL:settingsFileURL];
            if (settingsDict) {
                for (NSString *key in settingsDict.allKeys) {
                    [self.defaults setObject:[settingsDict objectForKey:key] forKey:key];
                }
                [self.defaults synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    restart();
                });
            }
        }
    }];
}
- (IBAction)exportSettings:(NSButton *)sender {
    NSMutableDictionary *settingsDict = [NSMutableDictionary new];
    for (NSString *key in ALLOWED_KEYS) {
        [settingsDict setObject:[self.defaults objectForKey:key] forKey:key];
    }
    
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedContentTypes:@[UTTypeXMLPropertyList]];
    [savePanel setTitle:@"Save Zephyr Settings"];
    [savePanel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            NSString *filePath = [[savePanel URL] path];
            BOOL success = [settingsDict writeToFile:filePath atomically:YES];
            if (!success) {
                NSLog(@"[ZEPHYR] Error saving file");
            }
        }
    }];
}
@end
