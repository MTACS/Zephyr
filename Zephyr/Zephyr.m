//
//  Zephyr.m
//  Zephyr
//
//  Created by DF on 10/7/25.
//

#import "Zephyr.h"
#import "CALayer+Average.h"

static const char *kNotifyPrefsChanged = "com.mtac.zephyr.prefs.changed";

NSUserDefaults *defaults;

void redirect(NSString *filePath) {
    FILE *logFile = fopen([filePath UTF8String], "a");
    dup2(fileno(logFile), STDERR_FILENO);
    setvbuf(stderr, NULL, _IONBF, 0);
}

BOOL containsKey(NSString *key) {
    return [defaults.dictionaryRepresentation.allKeys containsObject:key];
}

CGFloat colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSRange range = NSMakeRange(start, length);
    NSString *substring = [string substringWithRange:range];
    NSScanner *scanner = [NSScanner scannerWithString:substring];
    unsigned int hexValue;
    if ([scanner scanHexInt:&hexValue]) {
        return (CGFloat)hexValue / 255.0f;
    }
    return 0.0f;
}

NSColor *colorFromHexString(NSString *hexString) {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;

    switch ([colorString length]) {
        case 6:
            alpha = 1.0f;
            break;
        case 8:
            alpha = colorComponentFrom(colorString, 6, 2);
            break;
        default:
            return nil;
    }

    red = colorComponentFrom(colorString, 0, 2);
    green = colorComponentFrom(colorString, 2, 2);
    blue = colorComponentFrom(colorString, 4, 2);

    return [NSColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@interface CALayer ()
@property struct CGColor *contentsMultiplyColor;
@end

@implementation Zephyr
+ (void)load {
}
@end

// Folder count badge, indicators

ZKSwizzleInterface(zp_Tile, Tile, NSObject)
@implementation zp_Tile
- (void)update {
    ZKOrig(void);
    if ([defaults boolForKey:@"folderCountBadge"]) {
        DOCKStack *stack = ((Tile *)self).stack;
        if (stack != NULL) {
            NSString *filePath = [((Tile *)self).fileURL.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
            ECStatusLabelDescription *description = [[objc_getClass("ECStatusLabelDescription") alloc] initWithDefaultPositioningAndString:[NSString stringWithFormat:@"%ld", contents.count]];
            if (contents.count > 0) {
                [((Tile *)self) setStatusLabel:description forType:0];
            } else {
                [((Tile *)self) removeStatusLabelForType:0];
            }
        }
    }
    
    /* NSString *bundleIdentifier = ((Tile *)self).bundleIdentifier;
    if ([bundleIdentifier isEqualToString:@"com.apple.finder"]) {
        DOCKTileLayer *layer = ZKHookIvar(self, DOCKTileLayer *, "_layer");
        [layer _setImage:[[NSImage alloc] initWithContentsOfFile:@"Finder.png"]];
    } */
}
- (void)addIndicator {
    ZKOrig(void);
    
    CALayer *indicatorLayer = ZKHookIvar(self, DOCKIndicatorLayer *, "_indicatorLayer");
    
    if ([defaults boolForKey:@"averageColorIndicator"]) {
        DOCKTileLayer *tileLayer = ZKHookIvar(self, DOCKTileLayer *, "_layer");
        CALayer *imageLayer = tileLayer.imageLayer;
        indicatorLayer.backgroundColor = [imageLayer averageColor].CGColor;
    }
    
    if ([defaults boolForKey:@"colorIndicator"]) {
        indicatorLayer.backgroundColor = colorFromHexString([defaults objectForKey:@"indicatorCustomColor"]).CGColor;
    }
    
    CGRect indicatorFrame = indicatorLayer.frame;
    indicatorLayer.frame = NSMakeRect(indicatorFrame.origin.x - ([defaults integerForKey:@"indicatorWidth"] / 2), indicatorFrame.origin.y + [defaults integerForKey:@"indicatorPosition"], indicatorFrame.size.width + [defaults integerForKey:@"indicatorWidth"], indicatorFrame.size.height + [defaults integerForKey:@"indicatorHeight"]);
}
@end

static void *kBlurLayerKey = &kBlurLayerKey;

// Tahoe

ZKSwizzleInterface(zp__TtC8DockCore16ModernFloorLayer, _TtC8DockCore16ModernFloorLayer, CALayer)
@implementation zp__TtC8DockCore16ModernFloorLayer
- (void)layoutSublayers {
    ZKOrig(void);
    ((CALayer *)self).sublayers[1].hidden = ([defaults boolForKey:@"hideBackgroundLayers"] || [defaults boolForKey:@"useCustomLayer"]);
    CALayer *separatorLayer = ZKHookIvar(self, CALayer *, "separatorLayer");
    separatorLayer.hidden = [defaults boolForKey:@"hideSeparator"];
    
    if ([defaults boolForKey:@"colorSeparator"]) {
        separatorLayer.backgroundColor = colorFromHexString([defaults objectForKey:@"separatorColor"]).CGColor;
    }
    
    if ([defaults integerForKey:@"separatorWidth"] != 0 || [[defaults objectForKey:@"separatorHeight"] integerValue] != 0) {
        CGRect separatorFrame = separatorLayer.frame;
        double separatorPosition = ZKHookIvar(self, double, "separatorPosition");
        [separatorLayer setFrame:CGRectMake(separatorPosition, separatorFrame.origin.y + -([[defaults objectForKey:@"separatorHeight"] integerValue] / 2), separatorFrame.size.width + [defaults integerForKey:@"separatorWidth"], separatorFrame.size.height + [[defaults objectForKey:@"separatorHeight"] integerValue])];
    }
    
    CALayer *recentSeparatorLayer = ZKHookIvar(self, CALayer *, "recentSeparatorLayer");
    recentSeparatorLayer.hidden = [defaults boolForKey:@"hideRecentSeparator"];
    
    if ([defaults boolForKey:@"colorRecentSeparator"]) {
        recentSeparatorLayer.backgroundColor = colorFromHexString([defaults objectForKey:@"recentSeparatorColor"]).CGColor;
    }
    
    if ([defaults integerForKey:@"recentSeparatorWidth"] != 0 || [[defaults objectForKey:@"recentSeparatorHeight"] integerValue] != 0) {
        CGRect recentSeparatorFrame = separatorLayer.frame;
        double recentSeparatorPosition = ZKHookIvar(self, double, "recentSeparatorPosition");
        [recentSeparatorLayer setFrame:CGRectMake(recentSeparatorPosition, recentSeparatorFrame.origin.y + -([[defaults objectForKey:@"recentSeparatorHeight"] integerValue] / 2), recentSeparatorFrame.size.width + [defaults integerForKey:@"recentSeparatorWidth"], recentSeparatorFrame.size.height + [[defaults objectForKey:@"recentSeparatorHeight"] integerValue])];
    }
    
    if ([defaults boolForKey:@"useCustomLayer"]) {
        CALayer *materialLayer = ((CALayer *)self).sublayers[1];
        CGRect materialFrame = materialLayer.frame;
        
        if (!self.blurLayer) self.blurLayer = [JLMaterialLayer layer];
        self.blurLayer.frame = NSMakeRect(materialFrame.origin.x, materialFrame.origin.y + 5, materialFrame.size.width, materialFrame.size.height - 10);
        self.blurLayer.cornerCurve = kCACornerCurveContinuous;
        if (![((CALayer *)self).sublayers containsObject:self.blurLayer]) {
            [((CALayer *)self) insertSublayer:self.blurLayer atIndex:0];
        }
        
        self.blurLayer.blurRadius = [defaults floatForKey:@"blurRadius"];
        self.blurLayer.adaptiveTintOpacity = [defaults floatForKey:@"opacity"] / 100;
        self.blurLayer.saturation = [defaults floatForKey:@"saturation"];
        self.blurLayer.colorBrightness = [defaults floatForKey:@"brightness"] / 100;
        self.blurLayer.fillOpacity = [defaults floatForKey:@"passthrough"] / 100;
        self.blurLayer.cornerRadius = [defaults floatForKey:@"cornerRadius"];
    }
}
- (JLMaterialLayer *)blurLayer {
    return [defaults boolForKey:@"useCustomLayer"] ?  objc_getAssociatedObject(self, kBlurLayerKey) : nil;
}
- (void)setBlurLayer:(JLMaterialLayer *)blurLayer {
    if ([defaults boolForKey:@"useCustomLayer"]) {
        objc_setAssociatedObject(self, kBlurLayerKey, blurLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end

// Sequoia

ZKSwizzleInterface(zp_FloorLayer, FloorLayer, CALayer)
@implementation zp_FloorLayer
- (void)layoutSublayers {
    ZKOrig(void);
    CALayer *borderLayer = ZKHookIvar(self, CALayer *, "_innerRimLayer");
    borderLayer.hidden = [defaults boolForKey:@"hideBorderLayer"] || [defaults boolForKey:@"hideBackgroundLayers"];
    if ([defaults boolForKey:@"colorBorderLayer"]) {
        borderLayer.backgroundColor = colorFromHexString([defaults objectForKey:@"borderLayerColor"]).CGColor;
    }
    if ([defaults boolForKey:@"useCustomLayer"]) {
        borderLayer.cornerRadius = [defaults integerForKey:@"cornerRadius"];
    }
    
    CALayer *separatorLayer = ZKHookIvar(self, CALayer *, "_separatorLayer");
    separatorLayer.hidden = [defaults boolForKey:@"hideSeparator"];
    
    if ([defaults boolForKey:@"colorSeparator"]) {
        separatorLayer.backgroundColor = colorFromHexString([defaults objectForKey:@"separatorColor"]).CGColor;
    }
    
    if ([defaults integerForKey:@"separatorWidth"] != 0 || [[defaults objectForKey:@"separatorHeight"] integerValue] != 0) {
        CGRect separatorFrame = separatorLayer.frame;
        double separatorPosition = ZKHookIvar(self, double, "_separatorPosition");
        [separatorLayer setFrame:CGRectMake(separatorPosition, separatorFrame.origin.y + -([[defaults objectForKey:@"separatorHeight"] integerValue] / 2), separatorFrame.size.width + [defaults integerForKey:@"separatorWidth"], separatorFrame.size.height + [[defaults objectForKey:@"separatorHeight"] integerValue])];
    }
    
    CALayer *recentSeparatorLayer = ZKHookIvar(self, CALayer *, "_recentSeparatorLayer");
    recentSeparatorLayer.hidden = [defaults boolForKey:@"hideRecentSeparator"];
    if ([defaults boolForKey:@"colorRecentSeparator"]) {
        recentSeparatorLayer.backgroundColor = colorFromHexString([defaults objectForKey:@"recentSeparatorColor"]).CGColor;
    }
    
    if ([defaults integerForKey:@"recentSeparatorWidth"] != 0 || [[defaults objectForKey:@"recentSeparatorHeight"] integerValue] != 0) {
        CGRect recentSeparatorFrame = separatorLayer.frame;
        double recentSeparatorPosition = ZKHookIvar(self, double, "_recentSeparatorPosition");
        [recentSeparatorLayer setFrame:CGRectMake(recentSeparatorPosition, recentSeparatorFrame.origin.y + -([[defaults objectForKey:@"recentSeparatorHeight"] integerValue] / 2), recentSeparatorFrame.size.width + [defaults integerForKey:@"recentSeparatorWidth"], recentSeparatorFrame.size.height + [[defaults objectForKey:@"recentSeparatorHeight"] integerValue])];
    }
    
    CALayer *materialLayer = ZKHookIvar(self, CALayer *, "_materialLayer");
    materialLayer.hidden = [defaults boolForKey:@"useCustomLayer"] || [defaults boolForKey:@"hideBackgroundLayers"];
    
    ZKHookIvar(self, CALayer *, "_rim").hidden = YES;
    
    if ([defaults boolForKey:@"useCustomLayer"]) {
        if (self.blurLayer) {
            NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.mtac.zephyr"];
            self.blurLayer.blurRadius = [defaults floatForKey:@"blurRadius"];
            self.blurLayer.adaptiveTintOpacity = [defaults floatForKey:@"opacity"] / 100;
            self.blurLayer.saturation = [defaults floatForKey:@"saturation"];
            self.blurLayer.colorBrightness = [defaults floatForKey:@"brightness"] / 100;
            self.blurLayer.fillOpacity = [defaults floatForKey:@"passthrough"] / 100;
            self.blurLayer.cornerRadius = [defaults floatForKey:@"cornerRadius"];
        }
    }
}
- (void)setGlobalSeparatorPositionsInDock:(id)dock position:(double)position1 recentPosition:(double)position2 {
    ZKOrig(void, dock, position1, position2);
    if ([defaults boolForKey:@"useCustomLayer"]) {
        CALayer *materialLayer = ZKHookIvar(self, CALayer *, "_materialLayer");
        
        if (!self.blurLayer) self.blurLayer = [JLMaterialLayer layer];
        self.blurLayer.frame = materialLayer.frame;
        self.blurLayer.cornerCurve = kCACornerCurveContinuous;
        if (![((FloorLayer *)self).sublayers containsObject:self.blurLayer]) {
            [((FloorLayer *)self) insertSublayer:self.blurLayer atIndex:0];
        }
    }
}
- (JLMaterialLayer *)blurLayer {
    return [defaults boolForKey:@"useCustomLayer"] ?  objc_getAssociatedObject(self, kBlurLayerKey) : nil;
}
- (void)setBlurLayer:(JLMaterialLayer *)blurLayer {
    if ([defaults boolForKey:@"useCustomLayer"]) {
        objc_setAssociatedObject(self, kBlurLayerKey, blurLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end

// Trash badge

ZKSwizzleInterface(zp_DOCKTrashTile, DOCKTrashTile, NSObject)
@implementation zp_DOCKTrashTile
- (void)update {
    ZKOrig(void);
    if ([defaults boolForKey:@"trashCountBadge"]) {
        _Bool full = ZKHookIvar(self, _Bool, "_trashFull");
        NSInteger itemCount = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@".Trash"] error:nil] count];
        ECStatusLabelDescription *description = [[objc_getClass("ECStatusLabelDescription") alloc] initWithDefaultPositioningAndString:[NSString stringWithFormat:@"%ld", itemCount]];
        if (full) {
            [((Tile *)self) setStatusLabel:description  forType:0];
        } else {
            [((Tile *)self) removeStatusLabelForType:0];
        }
    }
}
- (void)updateRect {
    ZKOrig(void);
    if ([defaults boolForKey:@"trashCountBadge"]) {
        [((DOCKTrashTile *)self) update];
    }
}
@end

// Color Badges

ZKSwizzleInterface(zp_ECStatusLabelLayer, ECStatusLabelLayer, CALayer)
@implementation zp_ECStatusLabelLayer
- (void)_renderBadgeImage {
    ZKOrig(void);
    if ([defaults boolForKey:@"useBadgeImage"]) {
        CALayer *background = ZKHookIvar(self, CALayer *, "_backgroundLayer");
        background.backgroundColor = [NSColor clearColor].CGColor;
        NSString *badgeImagePath = [defaults objectForKey:@"customBadgeImage"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:badgeImagePath]) {
            NSImage *customBadgeImage = [[NSImage alloc] initWithContentsOfFile:badgeImagePath];
            CGFloat scaleFactor = [customBadgeImage recommendedLayerContentsScale:[NSScreen mainScreen].backingScaleFactor];
            id layerContent = [customBadgeImage layerContentsForContentsScale:scaleFactor];
            background.contents = layerContent;
            background.contentsScale = scaleFactor;
            background.contentsGravity = kCAGravityResizeAspectFill;
        }
    }
    if ([defaults boolForKey:@"customBadgeColors"]) {
        CALayer *background = ZKHookIvar(self, CALayer *, "_backgroundLayer");
        background.backgroundColor = colorFromHexString([defaults objectForKey:@"customBadgeColor"]).CGColor;
        ZKHookIvar(self, CALayer *, "_secondShadowLayer").hidden = YES;
    }
}
@end

// Average Badges

ZKSwizzleInterface(zp_DOCKTileLayer, DOCKTileLayer, CALayer);
@implementation zp_DOCKTileLayer
- (void)layoutSublayers {
    ZKOrig(void);
    
    if ([defaults boolForKey:@"averageBadges"]) {
        CALayer *imageLayer = ((DOCKTileLayer *) self).imageLayer;
        ECStatusLabelDescription *description = ((DOCKTileLayer *) self).statusLabel;
        if (description.string != NULL && description.string != nil) {
            NSColor *average = [imageLayer averageColor];
            ECStatusLabelLayer *labelLayer = ((DOCKTileLayer *) self).labelLayer;
            CALayer *background = ZKHookIvar(labelLayer, CALayer *, "_backgroundLayer");
            background.backgroundColor = [average colorWithAlphaComponent:1.0].CGColor;
        }
    }
}
- (void)appearanceChanged {
    ZKOrig(void);
    [self layoutSublayers];
}
/* - (void)_setImage:(id)image {
    ZKOrig(void, image);
} */
@end

// Launchpad Average Badges

ZKSwizzleInterface(zp_ECSBItemLayer, ECSBItemLayer, CALayer)
@implementation zp_ECSBItemLayer
- (void)layout {
    ZKOrig(void);
    if ([defaults boolForKey:@"averageBadges"]) {
        ECStatusLabelLayer *labelLayer = ((ECSBItemLayer *)self).statusLayer;
        ECStatusLabelDescription *description = labelLayer.labelDescription;
        CALayer *imageLayer = ((ECSBItemLayer *) self).imageLayer;
        if (description.string != NULL && description.string != nil) {
            NSColor *average = [imageLayer averageColor];
            CALayer *background = ZKHookIvar(labelLayer, CALayer *, "_backgroundLayer");
            background.backgroundColor = [average colorWithAlphaComponent:1.0].CGColor;
        }
    }
}
@end

// Launchpad Folders

ZKSwizzleInterface(zp_ECSBGroupLayer, ECSBGroupLayer, CALayer)
@implementation zp_ECSBGroupLayer
- (void)layout {
    ZKOrig(void);
    ((ECSBGroupLayer *)self).backdropLayer.hidden = [defaults boolForKey:@"hideFolderBackground"];
}
@end

ZKSwizzleInterface(zp_ECSBLayer, ECSBLayer, CALayer)
@implementation zp_ECSBLayer
- (void)layout {
    ZKOrig(void);
}
@end

// Dock menu

ZKSwizzleInterface(zp_NSMenu, NSMenu, NSObject)
@implementation zp_NSMenu
- (void)accessibilityMenuDidOpen {
    ZKOrig(void);
    if ([defaults boolForKey:@"showDockMenu"]) {
        NSArray *items = ((NSMenu *)self).itemArray;
        if ([[[items lastObject] title] containsString:@"Dock Settings"]) {
            NSMenuItem *zephyrSettings = [[NSMenuItem alloc] initWithTitle:@"Zephyr Settings" action:@selector(openZephyrSettings) keyEquivalent:@""];
            zephyrSettings.target = self;
            [((NSMenu *)self) insertItem:zephyrSettings atIndex:items.count];
        }
    }
}
- (void)openZephyrSettings {
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    NSURL *settingsAppPath = [workspace URLForApplicationWithBundleIdentifier:@"com.mtac.zephyrapplication"];
    [workspace openApplicationAtURL:settingsAppPath configuration:[NSWorkspaceOpenConfiguration configuration] completionHandler:nil];
}
@end

ZKSwizzleInterface(zp_DockBar, DockBar, NSObject)
@implementation zp_DockBar
- (id)initWithEnvironment:(id)environment spaces:(id)spaces processUIModeManager:(id)manager {
    return ZKOrig(id, environment, spaces, manager);
}
- (void)appearanceDidChange:(id)change {
    ZKOrig(void, change);
}
@end

ZKSwizzleInterface(zp_DockGlobals, DockGlobals, NSObject)
@implementation zp_DockGlobals
- (_Bool)darkDock {
    _Bool appearance = ZKOrig(_Bool);
    switch ([defaults integerForKey:@"dockAppearance"]) {
        default:
        case 0:
            break;
        case 1:
            appearance = YES;
            break;
        case 2:
            appearance = NO;
            break;
    }
    return appearance;
}
@end

void updatePreferences(void) {
    NSLog(@"[ZEPHYR] Updating Preferences");
    if (![[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.Dock"]) {
        return;
    }
    
    // https://github.com/aspauldingcode/apple-sharpener/blob/ea3179839ea0bc6be4058dc17f9a5f55fb709a0a/src/sharpener/Dock/dock.m#L124
    
    NSArray *windows = [[NSApplication sharedApplication] windows];
    for (NSWindow *window in windows) {
        if (window.contentView && window.contentView.layer) {
            [window.contentView.layer setNeedsLayout];
        }
    }
}

static void setup(void) __attribute__((constructor));
static void setup(void) {
    // freopen([@"/Users/daf/Desktop/zephyrlog.txt" fileSystemRepresentation], "a", stderr);
    
    defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.mtac.zephyr"];

    // Bool
    
    if (!containsKey(@"colorBadges")) {
        [defaults setBool:NO forKey:@"colorBadges"];
    }
    if (!containsKey(@"averageBadges")) {
        [defaults setBool:NO forKey:@"averageBadges"];
    }
    if (!containsKey(@"customBadgeColors")) {
        [defaults setBool:NO forKey:@"customBadgeColors"];
    }
    if (!containsKey(@"trashCountBadge")) {
        [defaults setBool:NO forKey:@"trashCountBadge"];
    }
    if (!containsKey(@"folderCountBadge")) {
        [defaults setBool:NO forKey:@"folderCountBadge"];
    }
    if (!containsKey(@"hideBackgroundLayers")) {
        [defaults setBool:NO forKey:@"hideBackgroundLayers"];
    }
    if (!containsKey(@"hideBorderLayer")) {
        [defaults setBool:NO forKey:@"hideBorderLayer"];
    }
    if (!containsKey(@"colorBorderLayer")) {
        [defaults setBool:NO forKey:@"colorBorderLayer"];
    }
    if (!containsKey(@"useCustomLayer")) {
        [defaults setBool:NO forKey:@"useCustomLayer"];
    }
    if (!containsKey(@"hideFolderBackground")) {
        [defaults setBool:NO forKey:@"hideFolderBackground"];
    }
    if (!containsKey(@"hideSeparator")) {
        [defaults setBool:NO forKey:@"hideSeparator"];
    }
    if (!containsKey(@"colorSeparator")) {
        [defaults setBool:NO forKey:@"colorSeparator"];
    }
    if (!containsKey(@"hideRecentSeparator")) {
        [defaults setBool:NO forKey:@"hideRecentSeparator"];
    }
    if (!containsKey(@"colorRecentSeparator")) {
        [defaults setBool:NO forKey:@"colorRecentSeparator"];
    }
    if (!containsKey(@"useBadgeImage")) {
        [defaults setBool:NO forKey:@"useBadgeImage"];
    }
    if (!containsKey(@"colorIndicator")) {
        [defaults setBool:NO forKey:@"colorIndicator"];
    }
    if (!containsKey(@"averageColorIndicator")) {
        [defaults setBool:NO forKey:@"averageColorIndicator"];
    }
    if (!containsKey(@"showDockMenu")) {
        [defaults setBool:YES forKey:@"showDockMenu"];
    }
    
    // Float
    
    if (!containsKey(@"blurRadius")) {
        [defaults setFloat:10.0 forKey:@"blurRadius"];
    }
    if (!containsKey(@"saturation")) {
        [defaults setFloat:1.0 forKey:@"saturation"];
    }
    if (!containsKey(@"brightness")) {
        [defaults setFloat:0.0 forKey:@"brightness"];
    }
    if (!containsKey(@"opacity")) {
        [defaults setFloat:5.0 forKey:@"opacity"];
    }
    if (!containsKey(@"passthrough")) {
        [defaults setFloat:0.0 forKey:@"passthrough"];
    }
    if (!containsKey(@"cornerRadius")) {
        [defaults setFloat:20.0 forKey:@"cornerRadius"];
    }
    
    // Integer
    
    if (!containsKey(@"dockAppearance")) {
        [defaults setInteger:0 forKey:@"dockAppearance"];
    }
    if (!containsKey(@"separatorWidth")) {
        [defaults setInteger:0 forKey:@"separatorWidth"];
    }
    if (!containsKey(@"separatorHeight")) {
        [defaults setInteger:0 forKey:@"separatorHeight"];
    }
    if (!containsKey(@"recentSeparatorWidth")) {
        [defaults setInteger:0 forKey:@"recentSeparatorWidth"];
    }
    if (!containsKey(@"recentSeparatorHeight")) {
        [defaults setInteger:0 forKey:@"recentSeparatorHeight"];
    }
    if (!containsKey(@"indicatorWidth")) {
        [defaults setInteger:0 forKey:@"indicatorWidth"];
    }
    if (!containsKey(@"indicatorHeight")) {
        [defaults setInteger:0 forKey:@"indicatorHeight"];
    }
    
    // Colors
    
    if (!containsKey(@"borderLayerColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"borderLayerColor"];
    }
    if (!containsKey(@"customBadgeColor")) {
        [defaults setObject:@"#424242" forKey:@"customBadgeColor"];
    }
    if (!containsKey(@"borderLayerColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"borderLayerColor"];
    }
    if (!containsKey(@"customBadgeColor")) {
        [defaults setObject:@"#424242" forKey:@"customBadgeColor"];
    }
    if (!containsKey(@"separatorColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"separatorColor"];
    }
    if (!containsKey(@"recentSeparatorColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"recentSeparatorColor"];
    }
    if (!containsKey(@"indicatorCustomColor")) {
        [defaults setObject:@"#9E9E9E" forKey:@"indicatorCustomColor"];
    }
    
    [defaults synchronize];
    
    int prefs;
    if (notify_register_dispatch(kNotifyPrefsChanged, &prefs, dispatch_get_main_queue(), ^(int token) {
        uint64_t state;
        notify_get_state(token, &state);
        [defaults synchronize];
        updatePreferences();
    }) != NOTIFY_STATUS_OK) {
        
    }
}
