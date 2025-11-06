//
//  ZPLaunchpadController.h
//  ZephyrApplication
//
//  Created by DF on 10/28/25.
//

#import <Cocoa/Cocoa.h>
#import "ZPPreferencesController.h"

@interface ZPLaunchpadController : ZPPreferencesController
@property (strong) IBOutlet NSSwitch *hideFolderBackgroundSwitch;
@end
