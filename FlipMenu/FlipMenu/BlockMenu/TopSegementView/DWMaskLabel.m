//
//  DWMaskLabel.m
//  FlipMenu
//
//  Created by gskl on 16/9/13.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import "DWMaskLabel.h"

@interface DWMaskLabel()
- (void) DW_commonInit;
- (void) DW_drawBackgroundInRect:(CGRect)rect;
@end

@implementation DWMaskLabel{
    UIColor* maskedBackgroundColor;
}

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame]))
        [self DW_commonInit];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder]))
        [self DW_commonInit];
    return self;
}

- (UIColor*) backgroundColor{
    return maskedBackgroundColor;
    
}

- (void) setBackgroundColor:(UIColor *)backgroundColor{
    maskedBackgroundColor = backgroundColor;
    [self setNeedsDisplay];//DrawRect
}

- (void)DW_commonInit{
    maskedBackgroundColor = [super backgroundColor];
    [super setTextColor:[UIColor whiteColor]];
    [super setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [super drawRect:rect];
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(rect)));
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(image), CGImageGetHeight(image), CGImageGetBitsPerComponent(image), CGImageGetBitsPerPixel(image), CGImageGetBytesPerRow(image), CGImageGetDataProvider(image), CGImageGetDecode(image), CGImageGetShouldInterpolate(image));//创建mask
    CFRelease(image); image = NULL;
    CGContextClearRect(context, rect);
    CGRect newRect = CGRectMake(rect.origin.x, rect.origin.y + 5, rect.size.width, rect.size.height);
    CGContextSaveGState(context);
    CGContextClipToMask(context, newRect, mask);//文字颜色必须是白色  白色 mask才透的下去
    
    if (self.layer.cornerRadius != 0.0f) {
        CGPathRef path = CGPathCreateWithRoundedRect(rect, self.layer.cornerRadius, self.layer.cornerRadius, nil);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    CFRelease(mask);  mask = NULL;
    
    [self DW_drawBackgroundInRect:rect];
    
    CGContextRestoreGState(context);
    
}

- (void)DW_drawBackgroundInRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [maskedBackgroundColor set];
    CGContextFillRect(context, rect);
}

@end
