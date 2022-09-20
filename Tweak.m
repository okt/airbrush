//
//  Tweak.m
//  airbrush
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
<<<<<<< Updated upstream
#import "ZKSwizzle.h"

#pragma mark Main CTor
=======
#import <CoreGraphics/CoreGraphics.h>
#import "ZKSwizzle.h"

>>>>>>> Stashed changes
@interface Main : NSObject {} @end
@implementation Main
    +(void)load
	{
<<<<<<< Updated upstream
		NSLog(@"We in.");
	}
@end

// EX: A hook.
// @interface _NSThemeWidget : NSButton {} @end
// ZKSwizzleInterface(MinimizeButton, _NSThemeWidget, NSButton)
=======
		NSLog(@"Loaded.");
	}
@end

ZKSwizzleInterface(InternalLinkRenditionHook, _CUIInternalLinkRendition, NSObject)
@interface InternalLinkRenditionHook ()
-(id)name;
@end
@implementation InternalLinkRenditionHook
	-(struct CGImage *)unslicedImage
	{
		NSLog([NSString stringWithFormat:@"AIRBRUSH :: Internal :: %@.png, %zux%zu", self.name, CGImageGetWidth(ZKOrig(struct CGImage *)), CGImageGetHeight(ZKOrig(struct CGImage *))]);
		
		CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef)[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"/Library/Airbrush/%@.png", self.name]]);
		struct CGImage *image = CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);
		
		if (image) { return image; } else { return ZKOrig(struct CGImage *); }
	}
@end


ZKSwizzleInterface(RawPixelRenditionHook, _CUIRawPixelRendition, NSObject)
@interface RawPixelRenditionHook ()
-(id)name;
@end
@implementation RawPixelRenditionHook
	-(struct CGImage *)unslicedImage
	{
		NSLog([NSString stringWithFormat:@"AIRBRUSH :: External :: %@.png, %zux%zu", self.name, CGImageGetWidth(ZKOrig(struct CGImage *)), CGImageGetHeight(ZKOrig(struct CGImage *))]);
		
		CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef)[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"/Library/Airbrush/%@.png", self.name]]);
		struct CGImage *image = CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);
		
		if (image) { return image; } else { return ZKOrig(struct CGImage *); }
	}
@end
>>>>>>> Stashed changes
