//
//  ZPSidebarController.h
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import <Cocoa/Cocoa.h>
#import "../Classes/ZPSidebarCell.h"
#import "../Classes/ZPTableRowView.h"

@interface ZPSidebarController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>
@property (strong) IBOutlet NSTableView *tableView;
@end
