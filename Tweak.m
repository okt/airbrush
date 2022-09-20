//
//  Tweak.m
//  airbrush
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZKSwizzle.h"

@interface Main : NSObject {} @end
@implementation Main
	+(void)load
	{
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
