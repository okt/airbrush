//
//  Tweak.m
//  airbrush
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "ZKSwizzle.h"

#pragma mark Main CTor
@interface Main : NSObject {} @end
@implementation Main
    +(void)load
	{
		NSLog(@"We in.");
	}
@end

// EX: A hook.
// @interface _NSThemeWidget : NSButton {} @end
// ZKSwizzleInterface(MinimizeButton, _NSThemeWidget, NSButton)
