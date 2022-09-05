//
//  NSImage+Stretchable.m
//  airbrush
//
//  Created by berries on 7/1/22.
//

#import "NSImage+Stretchable.h"


TMEdgeInsets TMEdgeInsetsMake (CGFloat top,
                               CGFloat left,
                               CGFloat bottom,
                               CGFloat right)
{
    TMEdgeInsets insets;
    insets.top = top;
    insets.left = left;
    insets.bottom = bottom;
    insets.right = right;
    
    return insets;
}


@implementation NSImage (TMStretchable)

- (void)drawInRect:(CGRect)rect withCapInsets:(TMEdgeInsets)capInsets
{
    rect.origin.x = round(rect.origin.x);
    rect.origin.y = round(rect.origin.y);
    rect.size.width = round(rect.size.width);
    rect.size.height = round(rect.size.height);
    
    //bottom left
    [self drawInRect:NSMakeRect(rect.origin.x, rect.origin.y,
                                capInsets.left, capInsets.bottom)
            fromRect:NSMakeRect(0.0, 0.0,
                                capInsets.left, capInsets.bottom)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    //top left
    [self drawInRect:NSMakeRect(rect.origin.x, rect.origin.y + rect.size.height - capInsets.top,
                                capInsets.left, capInsets.top)
            fromRect:NSMakeRect(0.0, self.size.height - capInsets.top,
                                capInsets.left, capInsets.top)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    //top right
    [self drawInRect:NSMakeRect(rect.origin.x + rect.size.width - capInsets.right, rect.origin.y + rect.size.height - capInsets.top,
                                capInsets.right, capInsets.top)
            fromRect:NSMakeRect(self.size.width - capInsets.right, self.size.height - capInsets.top,
                                capInsets.right, capInsets.top)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    //bottom right
    [self drawInRect:NSMakeRect(rect.origin.x + rect.size.width - capInsets.right, rect.origin.y,
                                capInsets.right, capInsets.bottom)
            fromRect:NSMakeRect(self.size.width - capInsets.right, 0.0,
                                capInsets.right, capInsets.bottom)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    
    //bottom center
    [self drawInRect:NSMakeRect(rect.origin.x + capInsets.left, rect.origin.y,
                                rect.size.width - capInsets.right - capInsets.left, capInsets.bottom)
            fromRect:NSMakeRect(capInsets.left, 0.0,
                                self.size.width - capInsets.right - capInsets.left, capInsets.bottom)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    //top center
    [self drawInRect:NSMakeRect(rect.origin.x + capInsets.left, rect.origin.y + rect.size.height - capInsets.top,
                                rect.size.width - capInsets.right - capInsets.left, capInsets.top)
            fromRect:NSMakeRect(capInsets.left, self.size.height - capInsets.top,
                                self.size.width - capInsets.right - capInsets.left, capInsets.top)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    //left center
    [self drawInRect:NSMakeRect(rect.origin.x, rect.origin.y + capInsets.bottom,
                                capInsets.left, rect.size.height - capInsets.top - capInsets.bottom)
            fromRect:NSMakeRect(0.0, capInsets.bottom,
                                capInsets.left, self.size.height - capInsets.top - capInsets.bottom)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    //right center
    [self drawInRect:NSMakeRect(rect.origin.x + rect.size.width - capInsets.right, rect.origin.y + capInsets.bottom,
                                capInsets.right, rect.size.height - capInsets.top - capInsets.bottom)
            fromRect:NSMakeRect(self.size.width - capInsets.right, capInsets.bottom,
                                capInsets.right, self.size.height - capInsets.top - capInsets.bottom)
           operation:NSCompositingOperationSourceOver fraction:0.5];
    
    
    //center center
    [self drawInRect:NSMakeRect(rect.origin.x + capInsets.left, rect.origin.y + capInsets.bottom,
                                rect.size.width - capInsets.right - capInsets.left, rect.size.height - capInsets.top - capInsets.bottom)
            fromRect:NSMakeRect(capInsets.left, capInsets.bottom,
                                self.size.width - capInsets.right - capInsets.left, self.size.height - capInsets.top - capInsets.bottom)
           operation:NSCompositingOperationSourceOver fraction:0.5];
}

@end
