//
//  ZPLayerController.h
//  ZephyrApplication
//
//  Created by DF on 10/26/25.
//

#import <Cocoa/Cocoa.h>
#import "ZPPreferencesController.h"

@interface ZPLayerController : ZPPreferencesController
@property (strong) IBOutlet NSTextField *blurRadiusLabel;
@property (strong) IBOutlet NSTextField *saturationLabel;
@property (strong) IBOutlet NSTextField *brightnessLabel;
@property (strong) IBOutlet NSTextField *opacityLabel;
@property (strong) IBOutlet NSTextField *passthroughLabel;
@property (strong) IBOutlet NSTextField *cornerRadiusLabel;
@property (strong) IBOutlet NSStepper *blurRadiusStepper;
@property (strong) IBOutlet NSStepper *saturationStepper;
@property (strong) IBOutlet NSStepper *brightnessStepper;
@property (strong) IBOutlet NSStepper *opacityStepper;
@property (strong) IBOutlet NSStepper *passthroughStepper;
@property (strong) IBOutlet NSStepper *cornerRadiusStepper;
@end
