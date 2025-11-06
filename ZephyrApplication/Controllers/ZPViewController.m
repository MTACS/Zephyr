//
//  ZPViewController.m
//  ZephyrApplication
//
//  Created by DF on 10/23/25.
//

#import "ZPViewController.h"

@interface ZPViewController ()

@end

@implementation ZPViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabSelectionChanged:) name:@"ZPTabSelectionChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAboutView) name:@"ZPShowAboutView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSettings) name:@"ZPShowSettings" object:nil];
    
    [self.tabView selectTabViewItemAtIndex:0];
}
- (void)tabSelectionChanged:(NSNotification *)notification {
    NSDictionary *tabDict = notification.userInfo;
    NSInteger selectedIndex = [[tabDict objectForKey:@"selectedTab"] integerValue];
    [self.tabView selectTabViewItemAtIndex:selectedIndex];
}
- (void)showAboutView {
    [self.tabView selectTabViewItemAtIndex:6];
}
- (void)showSettings {
    [self.tabView selectTabViewItemAtIndex:5];
}
@end
