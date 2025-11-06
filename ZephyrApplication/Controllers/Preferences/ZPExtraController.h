//
//  ZPExtraController.h
//  ZephyrApplication
//
//  Created by DF on 11/5/25.
//

#import "ZPPreferencesController.h"

@interface ZPExtraController : ZPPreferencesController
@property (strong) IBOutlet NSPopUpButton *sizeButton;
@property (strong) IBOutlet NSSwitch *highlightSwitch;
@property (strong) IBOutlet NSSwitch *staticSwitch;
@property (strong) IBOutlet NSSwitch *lockDockSwitch;
@end
