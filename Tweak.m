//
//  Tweak.m
//  airbrush
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "ini.h"
#import "Prefs.h"
#import "ZKSwizzle.h"
#import "NSImage+Stretchable.h"

#pragma mark Main CTor
NSString *FilePath;
NSArray *titlebarBlacklist;
NSString *appID;


@interface Main : NSObject {} @end
@implementation Main
    +(void)load
	{
		FilePath = [[NSString alloc] initWithFormat:@"/Library/Airbrush"];
		titlebarBlacklist = @[@"com.apple.Finder", @"com.google.Chrome", @"org.mozilla.firefox", @"com.apple.coreservices.uiagent", @"com.hnc.Discord"];
		appID = [[NSBundle mainBundle] bundleIdentifier];
		
		[[NSFileManager defaultManager] createDirectoryAtPath: FilePath withIntermediateDirectories:YES attributes:nil error:nil];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/Airbrush/Config.ini"])
		{
			ini_t *config;
			config = ini_load("/Library/Airbrush/Config.ini");
			
			nine_slice = [NSString stringWithUTF8String:ini_get(config, "Settings", "NineSlicing")];
		} else
		{
			nine_slice = @"17, 25, 17, 25";
		}
	}
@end

#pragma mark Window Button Controls
@interface NSView ()
@property(readonly) BOOL isSpace;
@end
@interface _NSThemeWidget : NSButton {} @end
@interface _NSThemeZoomWidget : NSButton {} @end
@interface _NSThemeCloseWidget : NSButton {} @end
ZKSwizzleInterface(MinDrawing, _NSThemeWidget, NSButton)
ZKSwizzleInterface(ZoomDrawing, _NSThemeZoomWidget, NSButton)
ZKSwizzleInterface(CloseDrawing, _NSThemeCloseWidget, NSButton)

@implementation MinDrawing
    -(void)drawRect:(NSRect)dirtyRect
    {
        dirtyRect.size.height = dirtyRect.size.width;
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Minimize.png", FilePath]] drawInRect:dirtyRect];
    }
@end
@implementation CloseDrawing
    -(void)drawRect:(NSRect)dirtyRect
    {
        dirtyRect.size.height = dirtyRect.size.width;
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Close.png", FilePath]] drawInRect:dirtyRect];
    }
@end
@implementation ZoomDrawing
	-(void)drawRect:(NSRect)dirtyRect
	{
		dirtyRect.size.height = dirtyRect.size.width;
		[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Zoom.png", FilePath]] drawInRect:dirtyRect];
	}
@end


#pragma mark Toolbar Control Theming
ZKSwizzleInterface(SegmentSetDrawsBezel, NSSegmentItemView, NSButton)
ZKSwizzleInterface(SegmentDrawing, NSToolbarItemViewer, NSView)

@implementation SegmentSetDrawsBezel
	-(void)drawRect:(NSRect)dirtyRect
	{
		[self setDrawsBezel: NO];
	}

	-(void)setDrawsBezel:(BOOL)arg1
	{
		ZKOrig(void, NO);
	}
@end
@implementation SegmentDrawing
	-(void)drawRect:(NSRect)dirtyRect
	{
		NSArray *slices = [nine_slice componentsSeparatedByString:@","];
		
		if (self.isSpace == NO)
		{
			if (self.bounds.size.width > 19)
			 {
				 if (self.window.toolbarStyle != NSWindowToolbarStyleUnifiedCompact)
				 {
					 if (self.bounds.size.width < 40)
					 {
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/SegmentBackAlt.png", FilePath]] drawInRect:dirtyRect];
					 } else
					 {
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/SegmentBack.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake([slices[0] floatValue], [slices[1] floatValue], [slices[2] floatValue], [slices[3] floatValue])];
					 }
				 } else
				 {
					 if (self.bounds.size.width < 40)
					 {
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniSegmentBackAlt.png", FilePath]] drawInRect:dirtyRect];
					 } else
					 {
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniSegmentBack.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake([slices[0] floatValue], [slices[1] floatValue], [slices[2] floatValue], [slices[3] floatValue])];
					 }
				 }
			 } else
			 {
				 ZKOrig(void, dirtyRect);
			 }
		} else
		{
			ZKOrig(void, dirtyRect);
		}
	}

	-(BOOL)_shouldDrawFocus
	{
	  return NO;
	}

	-(BOOL)canDrawSubviewsIntoLayer
   {
	   return YES;
   }

	-(BOOL)canDrawConcurrently
   {
	   return YES;
   }
@end

#pragma mark Toolbar Backgrounds
ZKSwizzleInterface(ToolbarBackground, NSToolbarView, NSView)
ZKSwizzleInterface(TitlebarBackground, NSTitlebarView, NSView)
ZKSwizzleInterface(TitlebarBackgroundFix, NSVisualEffectView, NSView)

@implementation TitlebarBackgroundFix
	-(void)updateLayer
	{
		ZKOrig(void);
		if ([self.superview.className isEqual:@"NSTitlebarView"])
		{
			[self setAlphaValue:0.0];
		}
	}
@end


@implementation TitlebarBackground
	-(void)viewDidMoveToSuperview
	{
		BOOL isTheObjectThere = [titlebarBlacklist containsObject:appID];
		ZKOrig(void);
		
		if (!isTheObjectThere)
		{
			self.wantsLayer = YES;
			self.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniTitlebar.png", FilePath]];
		}
	}
@end


@implementation ToolbarBackground
	-(void)viewDidMoveToSuperview
	{
		ZKOrig(void);
		if (self.window.toolbarStyle != NSWindowToolbarStyleUnifiedCompact)
		{
			self.wantsLayer = YES;
		 	self.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Titlebar.png", FilePath]];
		} else {
			self.wantsLayer = YES;
			self.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniTitlebar.png", FilePath]];
		}
	}
@end
