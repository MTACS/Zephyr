//
//  ZPSettingsController.h
//  ZephyrApplication
//
//  Created by DF on 11/1/25.
//

#import "ZPPreferencesController.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import "../../global.h"

@interface ZPSettingsController : ZPPreferencesController
@property (strong) IBOutlet NSSwitch *dockMenuSwitch;
@end
