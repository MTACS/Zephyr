//
//  AppDelegate.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

NSUserDefaults *defaults;

BOOL containsKey(NSString *key) {
    return [defaults.dictionaryRepresentation.allKeys containsObject:key];
}

@implementation AppDelegate
- (IBAction)showAboutView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZPShowAboutView" object:nil];
}
- (IBAction)openSettings:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZPShowSettings" object:nil];
}
- (IBAction)sourceCode:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/MTACS/Zephyr"]];
}
- (IBAction)materialLayerSourceCode:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/jslegendre/JLMaterialLayer"]];
}
- (IBAction)restartDock:(id)sender {
    restart();
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.mtac.zephyr"];
    [self loadDefaults];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZPShowDefault" object:nil];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
}
- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}
- (void)loadDefaults {
    
    // Bool
    
    if (!containsKey(@"colorBadges")) {
        [defaults setBool:NO forKey:@"colorBadges"];
    }
    if (!containsKey(@"averageBadges")) {
        [defaults setBool:NO forKey:@"averageBadges"];
    }
    if (!containsKey(@"customBadgeColors")) {
        [defaults setBool:NO forKey:@"customBadgeColors"];
    }
    if (!containsKey(@"trashCountBadge")) {
        [defaults setBool:NO forKey:@"trashCountBadge"];
    }
    if (!containsKey(@"folderCountBadge")) {
        [defaults setBool:NO forKey:@"folderCountBadge"];
    }
    if (!containsKey(@"hideBackgroundLayers")) {
        [defaults setBool:NO forKey:@"hideBackgroundLayers"];
    }
    if (!containsKey(@"hideBorderLayer")) {
        [defaults setBool:NO forKey:@"hideBorderLayer"];
    }
    if (!containsKey(@"colorBorderLayer")) {
        [defaults setBool:NO forKey:@"colorBorderLayer"];
    }
    if (!containsKey(@"useCustomLayer")) {
        [defaults setBool:NO forKey:@"useCustomLayer"];
    }
    if (!containsKey(@"hideFolderBackground")) {
        [defaults setBool:NO forKey:@"hideFolderBackground"];
    }
    if (!containsKey(@"hideSeparator")) {
        [defaults setBool:NO forKey:@"hideSeparator"];
    }
    if (!containsKey(@"colorSeparator")) {
        [defaults setBool:NO forKey:@"colorSeparator"];
    }
    if (!containsKey(@"hideRecentSeparator")) {
        [defaults setBool:NO forKey:@"hideRecentSeparator"];
    }
    if (!containsKey(@"colorRecentSeparator")) {
        [defaults setBool:NO forKey:@"colorRecentSeparator"];
    }
    if (!containsKey(@"useBadgeImage")) {
        [defaults setBool:NO forKey:@"useBadgeImage"];
    }
    if (!containsKey(@"colorIndicator")) {
        [defaults setBool:NO forKey:@"colorIndicator"];
    }
    if (!containsKey(@"averageColorIndicator")) {
        [defaults setBool:NO forKey:@"averageColorIndicator"];
    }
    if (!containsKey(@"showDockMenu")) {
        [defaults setBool:YES forKey:@"showDockMenu"];
    }
    
    
    // Float
    
    if (!containsKey(@"blurRadius")) {
        [defaults setFloat:10.0 forKey:@"blurRadius"];
    }
    if (!containsKey(@"saturation")) {
        [defaults setFloat:1.0 forKey:@"saturation"];
    }
    if (!containsKey(@"brightness")) {
        [defaults setFloat:0.0 forKey:@"brightness"];
    }
    if (!containsKey(@"opacity")) {
        [defaults setFloat:5.0 forKey:@"opacity"];
    }
    if (!containsKey(@"passthrough")) {
        [defaults setFloat:0.0 forKey:@"passthrough"];
    }
    if (!containsKey(@"cornerRadius")) {
        [defaults setFloat:20.0 forKey:@"cornerRadius"];
    }
    
    // Integer
    
    if (!containsKey(@"dockAppearance")) {
        [defaults setInteger:0 forKey:@"dockAppearance"];
    }
    if (!containsKey(@"separatorWidth")) {
        [defaults setInteger:0 forKey:@"separatorWidth"];
    }
    if (!containsKey(@"separatorHeight")) {
        [defaults setInteger:0 forKey:@"separatorHeight"];
    }
    if (!containsKey(@"recentSeparatorWidth")) {
        [defaults setInteger:0 forKey:@"recentSeparatorWidth"];
    }
    if (!containsKey(@"recentSeparatorHeight")) {
        [defaults setInteger:0 forKey:@"recentSeparatorHeight"];
    }
    if (!containsKey(@"indicatorWidth")) {
        [defaults setInteger:0 forKey:@"indicatorWidth"];
    }
    if (!containsKey(@"indicatorHeight")) {
        [defaults setInteger:0 forKey:@"indicatorHeight"];
    }
    
    // Colors
    
    if (!containsKey(@"borderLayerColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"borderLayerColor"];
    }
    if (!containsKey(@"customBadgeColor")) {
        [defaults setObject:@"#424242" forKey:@"customBadgeColor"];
    }
    if (!containsKey(@"separatorColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"separatorColor"];
    }
    if (!containsKey(@"recentSeparatorColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"recentSeparatorColor"];
    }
    if (!containsKey(@"indicatorCustomColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"indicatorCustomColor"];
    }
    
    [defaults synchronize];
}
@end
