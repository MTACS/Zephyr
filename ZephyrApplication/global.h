//
//  global.h
//  ZephyrApplication
//
//  Created by DF on 11/5/25.
//

#import <Foundation/Foundation.h>
#import "spawn.h"

#ifndef global_h
#define global_h

#define ALLOWED_KEYS @[@"averageBadges", @"averageColorIndicator", @"blurRadius", @"borderLayerColor", @"brightness", @"colorBadges", @"colorBorderLayer", @"colorIndicator", @"colorRecentSeparator", @"colorSeparator", @"cornerRadius", @"customBadgeColor", @"customBadgeColors", @"dockAppearance", @"folderCountBadge", @"hideBackgroundLayers", @"hideBorderLayer", @"hideFolderBackground", @"hideRecentSeparator", @"hideSeparator", @"indicatorCustomColor", @"indicatorHeight", @"indicatorWidth", @"opacity", @"passthrough", @"recentSeparatorColor", @"recentSeparatorHeight", @"recentSeparatorWidth", @"saturation", @"separatorColor", @"separatorHeight", @"separatorWidth", @"showDockMenu", @"trashCountBadge", @"useBadgeImage", @"useCustomLayer"]

extern char** environ;

void restart(void);

#endif /* global_h */
