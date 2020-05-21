//
//  UIView+GrandLive.m
//  grandlive
//
//  Created by Sea on 2018/4/20.
//

#import "UIView+GrandLive.h"

@implementation UIView (QYGCLPosition)

- (CGFloat)gl_left {
    return self.frame.origin.x;
}

- (void)setGl_left:(CGFloat)gl_left {
    CGRect frame = self.frame;
    frame.origin.x = gl_left;
    self.frame = frame;
}

- (CGFloat)gl_top {
    return self.frame.origin.y;
}

- (void)setGl_top:(CGFloat)gl_top {
    CGRect frame = self.frame;
    frame.origin.y = gl_top;
    self.frame = frame;
}

- (CGFloat)gl_right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)gl_bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)gl_width {
    return self.frame.size.width;
}

- (void)setGl_width:(CGFloat)gl_width {
    CGRect frame = self.frame;
    frame.size.width = gl_width;
    self.frame = frame;
}

- (CGFloat)gl_height {
    return self.frame.size.height;
}

- (void)setGl_height:(CGFloat)gl_height {
    CGRect frame = self.frame;
    frame.size.height = gl_height;
    self.frame = frame;
}

- (CGFloat)gl_centerX {
    return self.center.x;
}

- (void)setGl_centerX:(CGFloat)gl_centerX {
    CGPoint center = self.center;
    center.x = gl_centerX;
    self.center = center;
}

- (CGFloat)gl_centerY {
    return self.center.y;
}

- (void)setGl_centerY:(CGFloat)gl_centerY {
    CGPoint center = self.center;
    center.y = gl_centerY;
    self.center = center;
}

- (CGSize)gl_size {
    return self.frame.size;
}

- (void)setGl_size:(CGSize)gl_size {
    CGRect frame = self.frame;
    frame.size = gl_size;
    self.frame = frame;
}


- (void)setGLBorderColor:(UIColor *)gLBorderColor{
    self.layer.borderColor = gLBorderColor.CGColor;
}

- (UIColor *)gLBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

@end
