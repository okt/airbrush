//
//  NSImage+Stretchable.h
//  airbrush
//
//  Created by berries on 7/1/22.
//

#import <AppKit/AppKit.h>

typedef struct {
    CGFloat top, left, bottom, right;
} TMEdgeInsets;

#define UIEdgeInsetsZero { 0.0, 0.0, 0.0, 0.0 }

TMEdgeInsets TMEdgeInsetsMake (CGFloat top,
                   CGFloat left,
                   CGFloat bottom,
                   CGFloat right);


@interface NSImage (TMStretchable)

- (void)drawInRect:(CGRect)rect withCapInsets:(TMEdgeInsets)capInsets;

@end
