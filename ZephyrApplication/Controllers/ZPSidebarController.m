//
//  ZPSidebarController.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import "ZPSidebarController.h"

@interface ZPSidebarController ()
@end

@implementation ZPSidebarController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAboutView) name:@"ZPShowAboutView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSettings) name:@"ZPShowSettings" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDefault) name:@"ZPShowDefault" object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.target = self;
    self.tableView.action = @selector(tableViewClicked:);
    
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:YES];
    
    [self.tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];

}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *returnString;
    switch (row) {
        case 0:
            returnString = @"Background";
            break;
        case 1:
            returnString = @"Badges";
            break;
        case 2:
            returnString = @"Separators";
            break;
        case 3:
            returnString = @"Indicators";
            break;
        case 4:
            returnString = @"Launchpad";
            break;
        case 5:
            returnString = @"Extra";
            break;
        case 6:
            returnString = @"Settings";
            break;
        case 7:
            returnString = @"About";
            break;
        default:
            break;
    }
    return returnString;
}
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ZPSidebarCell *sidebarCell = (ZPSidebarCell *)cell;
    NSColor *iconColor;
    if (![[NSApp effectiveAppearance].name isEqualToString:NSAppearanceNameDarkAqua]) {
        if (sidebarCell.isHighlighted && sidebarCell.backgroundStyle == NSBackgroundStyleEmphasized) {
            iconColor = [NSColor whiteColor];
        } else {
            iconColor = [NSColor blackColor];
        }
    } else {
        iconColor = [NSColor whiteColor];
    }
    NSImageSymbolConfiguration *configuration = [NSImageSymbolConfiguration configurationWithHierarchicalColor:iconColor];
    NSString *imageName;
    switch (row) {
        case 0:
            imageName = @"dock.rectangle";
            break;
        case 1:
            imageName = @"app.badge.fill";
            break;
        case 2:
            imageName = @"square.fill.and.line.vertical.and.square";
            break;
        case 3:
            imageName = @"gauge.with.dots.needle.bottom.50percent";
            break;
        case 4:
            imageName = @"square.grid.3x3.square";
            break;
        case 5:
            imageName = @"rectangle.stack.fill.badge.plus";
            break;
        case 6:
            imageName = @"gearshape.circle.fill";
            break;
        case 7:
            imageName = @"info.square.fill";
            break;
        default:
            break;
    }
    sidebarCell.icon = [[NSImage imageWithSystemSymbolName:imageName accessibilityDescription:@""] imageWithSymbolConfiguration:configuration];
}
- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    ZPTableRowView *rowView = [tableView makeViewWithIdentifier:@"tableRowView" owner:self];
    if (!rowView) {
        rowView = [[ZPTableRowView alloc] initWithFrame:NSZeroRect];
        rowView.identifier = @"tableRowView";
    }
    return rowView;
}
- (void)tableViewClicked:(id)sender {
    NSInteger selectedRow = self.tableView.selectedRow;
    if (selectedRow != -1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ZPTabSelectionChanged" object:nil userInfo:@{@"selectedTab" : [NSNumber numberWithInteger:selectedRow]}];
    }
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
     NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow != -1) {
        ZPTableRowView *myRowView = [self.tableView rowViewAtRow:selectedRow makeIfNecessary:NO];
        [myRowView setEmphasized:YES];
    }
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 8;
}
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40.0;
}
- (void)showAboutView {
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[self numberOfRowsInTableView:self.tableView] - 1] byExtendingSelection:NO];
}
- (void)showSettings {
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:6] byExtendingSelection:NO];
}
- (void)showDefault {
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
}
@end
