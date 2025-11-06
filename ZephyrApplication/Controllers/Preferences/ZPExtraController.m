//
//  ZPExtraController.m
//  ZephyrApplication
//
//  Created by DF on 11/5/25.
//

#import "ZPExtraController.h"
#import "../../global.h"

NSUserDefaults *dockDefaults;

@interface ZPExtraController ()
@end

@implementation ZPExtraController
- (void)viewDidLoad {
    [super viewDidLoad];
    dockDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.apple.dock"];
    [self updatePreferences];
}
- (void)updatePreferences {
    [self.highlightSwitch setState:(NSControlStateValue)[dockDefaults boolForKey:@"mouse-over-hilite-stack"]];
    [self.staticSwitch setState:(NSControlStateValue)[dockDefaults boolForKey:@"static-only"]];
    [self.lockDockSwitch setState:(NSControlStateValue)[dockDefaults boolForKey:@"contents-immutable"]];
}
- (IBAction)addSpacer:(NSButton *)sender {
    NSString *size;
    switch (self.sizeButton.indexOfSelectedItem) {
        default:
        case 0:
            size = @"small-spacer-tile";
            break;
        case 1:
            size = @"spacer-tile";
            break;
    }
    
    CFArrayRef arr = CFPreferencesCopyAppValue((CFStringRef)@"persistent-apps", CFSTR("com.apple.dock"));
    NSMutableArray *persistentApps = nil;
    if (arr) {
        persistentApps = [(__bridge NSArray *)arr mutableCopy];
        CFRelease(arr);
    }
    if (!persistentApps) persistentApps = [NSMutableArray array];
    
    NSDictionary *spacerDict = @{
        @"tile-data": @{
            @"file-label": @""
        },
        @"tile-type": size
    };
    
    [persistentApps addObject:spacerDict];
    
    CFPreferencesSetAppValue((CFStringRef)@"persistent-apps", (__bridge CFArrayRef)persistentApps, CFSTR("com.apple.dock"));
    CFPreferencesAppSynchronize(CFSTR("com.apple.dock"));
    restart();
}
- (IBAction)switchChanged:(NSSwitch *)sender {
    CFPreferencesSetAppValue((CFStringRef)sender.identifier, (CFBooleanRef)sender.state ? kCFBooleanTrue : kCFBooleanFalse, CFSTR("com.apple.dock"));
    CFPreferencesAppSynchronize(CFSTR("com.apple.dock"));
    restart();
}
@end
