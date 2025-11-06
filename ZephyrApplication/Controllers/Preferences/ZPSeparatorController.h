//
//  ZPSeparatorController.h
//  ZephyrApplication
//
//  Created by DF on 10/29/25.
//

#import <Cocoa/Cocoa.h>
#import "ZPPreferencesController.h"

@interface ZPSeparatorController : ZPPreferencesController
@property (strong) IBOutlet NSSwitch *hideSeparatorSwitch;
@property (strong) IBOutlet NSSwitch *colorSeparatorSwitch;
@property (strong) IBOutlet NSSwitch *hideRecentSeparatorSwitch;
@property (strong) IBOutlet NSSwitch *colorRecentSeparatorSwitch;
@property (strong) IBOutlet NSStepper *separatorWidthStepper;
@property (strong) IBOutlet NSStepper *separatorHeightStepper;
@property (strong) IBOutlet NSStepper *recentSeparatorWidthStepper;
@property (strong) IBOutlet NSStepper *recentSeparatorHeightStepper;
@property (strong) IBOutlet NSTextField *separatorWidthLabel;
@property (strong) IBOutlet NSTextField *separatorHeightLabel;
@property (strong) IBOutlet NSTextField *recentSeparatorWidthLabel;
@property (strong) IBOutlet NSTextField *recentSeparatorHeightLabel;
@property (strong) IBOutlet NSColorWell *separatorColorWell;
@property (strong) IBOutlet NSColorWell *recentSeparatorColorWell;
@end
