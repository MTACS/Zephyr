//
//  ZPBackgroundController.h
//  ZephyrApplication
//
//  Created by DF on 10/23/25.
//

#import <Cocoa/Cocoa.h>
#import "ZPPreferencesController.h"

@interface ZPBackgroundController : ZPPreferencesController
@property (strong) IBOutlet NSSwitch *hideBackgroundSwitch;
@property (strong) IBOutlet NSSwitch *hideBorderSwitch;
@property (strong) IBOutlet NSSwitch *colorBorderSwitch;
@property (strong) IBOutlet NSSwitch *customLayerSwitch;
@property (strong) IBOutlet NSColorWell *borderColorWell;
@property (strong) IBOutlet NSButton *customizeLayerButton;
@property (strong) IBOutlet NSPopUpButton *appearanceButton;
@end
