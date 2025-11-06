//
//  ZPIconsController.h
//  ZephyrApplication
//
//  Created by DF on 10/26/25.
//

#import <Cocoa/Cocoa.h>
#import "ZPPreferencesController.h"

@interface ZPIconsController : ZPPreferencesController
@property (strong) IBOutlet NSSwitch *colorBadgesSwitch;
@property (strong) IBOutlet NSSwitch *averageBadgesSwitch;
@property (strong) IBOutlet NSSwitch *customBadgeColorSwitch;
@property (strong) IBOutlet NSSwitch *trashBadgeSwitch;
@property (strong) IBOutlet NSSwitch *folderBadgeSwitch;
@property (strong) IBOutlet NSSwitch *imageBadgeSwitch;
@property (strong) IBOutlet NSButton *imageBadgeButton;
@property (strong) IBOutlet NSColorWell *customBadgeColorWell;
@end
