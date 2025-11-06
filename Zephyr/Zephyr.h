//
//  Zephyr.h
//  Zephyr
//
//  Created by DF on 10/7/25.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "ZKSwizzle.h"
#import <objc/runtime.h>
#import "JLMaterialLayer/JLMaterialLayer.h"
#import <notify.h>

@interface Zephyr : NSObject
@end

@interface NSObject (IvarDescription)
- (id)fp__ivarDescriptionForClass:(Class)_class;
- (id)fp__methodDescriptionForClass:(Class)_class;
- (id)fp_ivarDescription;
- (id)fp_methodDescription;
- (id)fp_shortMethodDescription;
@end

@interface NSMenu (Private)
- (id)userInterfaceItemIdentifier;
@end

@interface CALayer (Private)
@property (readonly) NSSet *identifiers;
+ (id)properties;
- (_Bool)_usesCornerRadii;
@end

@interface CABackdropLayer : CALayer
@property (copy) NSString *groupName;
@end

@interface Environment : NSObject
@property (nonatomic, readonly) _Bool darkDock;
@end

@interface ECStatusLabelDescription : NSObject
- (id)initWithDefaultPositioningAndString:(id)string;
@property (nonatomic) _Bool hasImageResource;
@property (readonly, nonatomic) NSString *string;
@end

@interface ECStatusLabelLayer : CALayer {
    CALayer *_imageLayer;
}
@property (nonatomic) NSColor *badgeColor;
@property (retain, nonatomic) ECStatusLabelDescription *labelDescription;
@end

@interface ECSBItemLayer : CALayer
@property (readonly, nonatomic) CALayer *imageLayer;
@property (readonly, nonatomic) ECStatusLabelLayer *statusLayer;
@end

@interface ECSBGroupLayer : CALayer
@property (readonly, nonatomic) CALayer *backdropLayer;
@end

@interface ECSBLayer : CALayer
@property (nonatomic) unsigned long long numberOfRowsPerPage;
@property (nonatomic) unsigned long long numberOfColumnsPerPage;
@end

@interface ECCartoucheBackdropLayerController : NSObject
@property (nonatomic, readonly) CALayer *layer;
@property (nonatomic, retain) CALayer *contentLayer;
@end

@interface DockGlassMaterialLayerController : NSObject
@property (nonatomic, readonly) CALayer *rootLayer;
@end

@interface DockGlassMaterialLayoutConfiguration : NSObject
@property (nonatomic, copy) NSArray *elements;
@property (nonatomic) double smoothness;
@end

@interface DOCKTileLayer : CALayer
@property (readonly, nonatomic) ECStatusLabelLayer *labelLayer;
@property (retain, nonatomic) ECStatusLabelDescription *statusLabel;
@property (retain, nonatomic) ECStatusLabelDescription *debugStatusLabel;
@property (readonly, nonatomic) id realImage;
@property (retain, nonatomic) CALayer *imageLayer;
- (void)_setImage:(id)image;
@end

@interface DOCKStack : NSObject {
    NSMutableArray *_expandedItems;
}
@end

@interface DockBar : NSObject
@property (nonatomic, readonly) NSArray *tiles;
- (void)appearanceDidChange:(id)change;
- (void)scaleFactorChanged;
- (void)updateDisplayFromMainThread:(_Bool)thread;
@end

@interface DOCKIndicatorLayer : CALayer
@end

@interface Tile : NSObject {
    DOCKIndicatorLayer *_indicatorLayer;
}
@property (readonly, nonatomic) ECStatusLabelDescription *statusLabel;
@property (readonly, nonatomic) NSString *bundleIdentifier;
@property (readonly, nonatomic) DOCKStack *stack;
@property (readonly, nonatomic) NSURL *fileURL;
@property (retain, nonatomic) id image;
- (_Bool)hasIndicator;
- (void)addIndicator;
- (void)removeIndicator;
- (void)setStatusLabel:(id)label forType:(long long)type;
- (void)removeStatusLabelForType:(long long)type;
@end

@interface DOCKFolderTile : Tile
@end

@interface DOCKTrashTile : Tile {
    _Bool _trashFull;
}
- (void)open;
- (void)update;
@end

@interface DOCKSeparatorTile : Tile
@end

@interface DockGlobals : NSObject
@property (nonatomic, readonly) _Bool darkDock;
@property (nonatomic, readonly) _Bool useWallpaperTinting;
@property (nonatomic, readonly) unsigned char materialStyle;
@property (nonatomic) _Bool fullScreen;
@end

@interface ECBezelIconListLayer : CALayer
@property (readonly, nonatomic) NSArray *axItemLayers;
@end

@interface FloorLayer : CALayer
@property (nonatomic, retain) JLMaterialLayer *blurLayer;
@end

@interface _TtC8DockCore16ModernFloorLayer : CALayer
@end

@interface Springboard : NSObject {
    CALayer *_backgroundLayer;
}
@property (readonly, nonatomic) _Bool showsDock;
@end
