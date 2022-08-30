//
//  Tweak.m
//  airbrush
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "ZKSwizzle.h"
#import "NSImage+Stretchable.h"

#pragma mark Main CTor
NSString *FilePath;
@interface Main : NSObject {} @end
@implementation Main
    +(void)load { FilePath = [[NSString alloc] initWithFormat:@"/Library/Airbrush"]; }
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
ZKSwizzleInterface(SegmentBGDrawing, NSSegmentItemView, NSButton)
ZKSwizzleInterface(SegmentDrawing, NSToolbarItemViewer, NSView)
ZKSwizzleInterface(RemoveBez, NSButtonBezelView, NSView)

@implementation SegmentBGDrawing
	-(void)drawRect:(NSRect)dirtyRect
	{
		[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Segment.png", FilePath]] drawInRect:dirtyRect];
		[self setDrawsBezel: NO];
	}

	-(void)setDrawsBezel:(BOOL)arg1
	{
		ZKOrig(void, arg1);
	}
@end
@implementation SegmentDrawing
	-(void)drawRect:(NSRect)dirtyRect
	{
		if (self.isSpace == NO)
		{
			if (self.window.toolbarStyle != NSWindowToolbarStyleUnifiedCompact)
			{
				if (self.bounds.size.width < 40)
				{
					[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/SegmentBackAlt.png", FilePath]] drawInRect:dirtyRect];
				} else
				{
					[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/SegmentBack.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake(17, 25, 17, 25)];
				}
			} else
			{
				if (self.bounds.size.width < 40)
				{
					[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniSegmentBackAlt.png", FilePath]] drawInRect:dirtyRect];
				} else
				{
					[[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/MiniSegmentBack.png", FilePath]] drawInRect:dirtyRect withCapInsets:TMEdgeInsetsMake(17, 25, 17, 25)];
				}
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
	   return NO;
   }
@end
@implementation RemoveBez
	-(BOOL)isHidden
	{
		if ([self.superview.superview.className isEqual:@"NSToolbarItemViewer"])
		{
			return YES;
		} else
		{
			return ZKOrig(BOOL);
		}
	}
@end

#pragma mark Toolbar Backgrounds
ZKSwizzleInterface(TitlebarBackground, NSTitlebarView, NSView)
ZKSwizzleInterface(ToolbarBackground, NSToolbarView, NSView)

@implementation TitlebarBackground
	-(void)viewDidMoveToSuperview
   {
	   ZKOrig(void);
	   if (!self.window.titlebarAppearsTransparent)
	   {
		   if (!self.window.toolbar)
		   {
			   self.wantsLayer = YES;
			   self.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Titlebar.png", FilePath]];
		   }
	   }
	}
@end
@implementation ToolbarBackground
	-(void)viewDidMoveToSuperview
   {
	   ZKOrig(void);
	   if (!self.window.titlebarAppearsTransparent)
	   {
		   self.wantsLayer = YES;
		   self.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Titlebar.png", FilePath]];
	   }
	}
@end
