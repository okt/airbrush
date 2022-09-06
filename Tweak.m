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
		titlebarBlacklist = @[@"com.apple.Finder", @"com.microsoft.VSCode", @"ooo.toysinc.colorninja", @"com.apple.TV", @"5584CR723U.ooo.toysinc.colorninja", @"com.spotify.client", @"com.google.Chrome", @"org.mozilla.firefox", @"com.apple.coreservices.uiagent", @"com.apple.Music", @"com.apple.podcasts", @"com.hnc.Discord"];
		appID = [[NSBundle mainBundle] bundleIdentifier];
		
		[[NSFileManager defaultManager] createDirectoryAtPath: FilePath withIntermediateDirectories:YES attributes:nil error:nil];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/Airbrush/Config.ini"])
		{
			ini_t *config;
			config = ini_load("/Library/Airbrush/Config.ini");
			
			nine_slice = [NSString stringWithUTF8String:ini_get(config, "Settings", "NineSlicing")];
			button_slice = [NSString stringWithUTF8String:ini_get(config, "Slices", "Button")];
			segment_slice = [NSString stringWithUTF8String:ini_get(config, "Slices", "Segment")];
			mini_segment_slice = [NSString stringWithUTF8String:ini_get(config, "Slices", "MiniSegment")];
		} else
		{
			nine_slice = @"17, 25, 17, 25";
			button_slice = @"1, 1, 1, 1";
			segment_slice = @"14, 16, 22, 16";
			mini_segment_slice = @"1, 1, 1, 1";
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
ZKSwizzleInterface(MinimizeDrawing, _NSThemeWidget, NSButton)
ZKSwizzleInterface(ZoomDrawing, _NSThemeZoomWidget, NSButton)
ZKSwizzleInterface(CloseDrawing, _NSThemeCloseWidget, NSButton)

@implementation MinimizeDrawing
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
		NSArray *segmentSlices = [segment_slice componentsSeparatedByString:@","];
		NSArray *miniSlices = [mini_segment_slice componentsSeparatedByString:@","];
		
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
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/SegmentBack.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake([segmentSlices[0] floatValue], [segmentSlices[1] floatValue], [segmentSlices[2] floatValue], [segmentSlices[3] floatValue])];
					 }
				 } else
				 {
					 if (self.bounds.size.width < 40)
					 {
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniSegmentBackAlt.png", FilePath]] drawInRect:dirtyRect];
					 } else
					 {
						 [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniSegmentBack.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake([miniSlices[0] floatValue], [miniSlices[1] floatValue], [miniSlices[2] floatValue], [miniSlices[3] floatValue])];
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

#pragma mark More toolbar theming
ZKSwizzleInterface(SegCtrl, NSSegmentedControl, NSView)
ZKSwizzleInterface(ColorButtons, NSButton, NSView)

@interface ColorButtons (BezelStyle)
@property unsigned long long bezelStyle;
@end

@implementation ColorButtons
	-(void)drawRect:(NSRect)dirtyRect
	{
		NSArray *slices = [button_slice componentsSeparatedByString:@","];
		
		// Draw DirtyRect
		
		//Draw custom
		if ([self.superview.className isEqual:@"NSToolbarItemViewer"])
		{
			if (self.bezelStyle == NSBezelStyleTexturedRounded)
			{
				[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/ToolbarButton.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake([slices[0] floatValue], [slices[1] floatValue], [slices[2] floatValue], [slices[3] floatValue])];
			}
		}
		ZKOrig(void, dirtyRect);

	}
@end

@implementation SegCtrl
	-(void)drawRect:(NSRect)dirtyRect
	{
		NSArray *slices = [button_slice componentsSeparatedByString:@","];
		
		// Draw DirtyRect
		//Draw custom
		if ([self.superview.className isEqual:@"NSToolbarItemViewer"])
		{
			[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/ToolbarButton.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake([slices[0] floatValue], [slices[1] floatValue], [slices[2] floatValue], [slices[3] floatValue])];
		}
		ZKOrig(void, dirtyRect);
		
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
