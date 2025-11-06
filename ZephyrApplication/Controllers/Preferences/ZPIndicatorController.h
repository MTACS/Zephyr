//
//  ZPIndicatorController.h
//  ZephyrApplication
//
//  Created by DF on 10/31/25.
//

#import <Cocoa/Cocoa.h>
#import "ZPPreferencesController.h"

@interface ZPIndicatorController : ZPPreferencesController
@property (strong) IBOutlet NSSwitch *customColorSwitch;
@property (strong) IBOutlet NSSwitch *averageColorSwitch;
@property (strong) IBOutlet NSColorWell *customColorWell;
@property (strong) IBOutlet NSStepper *widthStepper;
@property (strong) IBOutlet NSStepper *heightStepper;
@property (strong) IBOutlet NSTextField *widthLabel;
@property (strong) IBOutlet NSTextField *heightLabel;
@end
