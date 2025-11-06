//
//  ZPLayerController.m
//  ZephyrApplication
//
//  Created by DF on 10/26/25.
//

#import "ZPLayerController.h"

@interface ZPLayerController ()
@end

@implementation ZPLayerController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePreferences];
}
- (void)updatePreferences {
    [self.blurRadiusLabel setStringValue:[NSString stringWithFormat:@"%.f", [self.defaults floatForKey:@"blurRadius"] ?: 10.0]];
    [self.blurRadiusStepper setIntValue:(int)[self.defaults floatForKey:@"blurRadius"] ?: 10];
    [self.saturationLabel setStringValue:[NSString stringWithFormat:@"%.f", [self.defaults floatForKey:@"saturation"] ?: 1.0]];
    [self.saturationStepper setIntValue:(int)[self.defaults floatForKey:@"saturation"] ?: 1];
    [self.brightnessLabel setStringValue:[NSString stringWithFormat:@"%.2f", ([self.defaults floatForKey:@"brightness"] / 100) ?: 0.0]];
    [self.brightnessStepper setIntValue:(int)[self.defaults floatForKey:@"brightness"] ?: 0];
    [self.opacityLabel setStringValue:[NSString stringWithFormat:@"%.2f", ([self.defaults floatForKey:@"opacity"] / 100) ?: 5.0]];
    [self.opacityStepper setIntValue:(int)[self.defaults floatForKey:@"opacity"] ?: 5];
    [self.passthroughLabel setStringValue:[NSString stringWithFormat:@"%.2f", ([self.defaults floatForKey:@"passthrough"] / 100) ?: 0.0]];
    [self.passthroughStepper setIntValue:(int)[self.defaults floatForKey:@"passthrough"] ?: 0];
    [self.cornerRadiusLabel setStringValue:[NSString stringWithFormat:@"%.f", [self.defaults floatForKey:@"cornerRadius"] ?: 20.0]];
    [self.cornerRadiusStepper setIntValue:(int)[self.defaults floatForKey:@"cornerRadius"] ?: 20];
    
    notify_post("com.mtac.zephyr.prefs.changed");
}
- (IBAction)blurRadiusChanged:(NSStepper *)sender {
    [self.defaults setFloat:sender.floatValue forKey:@"blurRadius"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)saturationChanged:(NSStepper *)sender {
    [self.defaults setFloat:sender.floatValue forKey:@"saturation"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)brightnessChanged:(NSStepper *)sender {
    [self.defaults setFloat:sender.floatValue forKey:@"brightness"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)opacityChanged:(NSStepper *)sender {
    [self.defaults setFloat:sender.floatValue forKey:@"opacity"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)passthroughChanged:(NSStepper *)sender {
    [self.defaults setFloat:sender.floatValue forKey:@"passthrough"];
    [self.defaults synchronize];
    [self updatePreferences];
}
- (IBAction)cornerRadiusChanged:(NSStepper *)sender {
    [self.defaults setFloat:sender.floatValue forKey:@"cornerRadius"];
    [self.defaults synchronize];
    [self updatePreferences];
}
@end
