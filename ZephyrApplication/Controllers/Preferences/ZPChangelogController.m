//
//  ZPChangelogController.m
//  ZephyrApplication
//
//  Created by DF on 11/13/25.
//

#import "ZPChangelogController.h"

@interface ZPChangelogController ()
@end

@implementation ZPChangelogController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView setString:@"1.1\n\n• Fixed import and export settings not working\n• Fixed Dock border layer corner radius not applying when using custom layer\n\n1.0\n\n• Initial release"];
}
@end
