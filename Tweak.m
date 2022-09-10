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
		NSLog(@"We in.");
	}
@end


@interface _NSThemeWidget : NSButton {} @end
ZKSwizzleInterface(MinimizeButton, _NSThemeWidget, NSButton)
@implementation MinimizeButton
    -(void)drawRect:(NSRect)dirtyRect
    {
        dirtyRect.size.height = dirtyRect.size.width;
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@/Minimize.png", FilePath]] drawInRect:dirtyRect];
    }
@end
