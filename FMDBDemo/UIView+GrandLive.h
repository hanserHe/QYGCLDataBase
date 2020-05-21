//
//  UIView+GrandLive.h
//  grandlive
//
//  Created by Sea on 2018/4/20.
//

#import <UIKit/UIKit.h>

@interface UIView (QYGCLPosition)

@property (nonatomic, assign) CGFloat gl_left;
@property (nonatomic, assign) CGFloat gl_top;
@property (nonatomic, readonly, assign) CGFloat gl_right;
@property (nonatomic, readonly, assign) CGFloat gl_bottom;

@property (nonatomic, assign) CGFloat gl_width;
@property (nonatomic, assign) CGFloat gl_height;

@property (nonatomic, assign) CGFloat gl_centerX;
@property (nonatomic, assign) CGFloat gl_centerY;

@property (nonatomic, assign) CGSize gl_size;

@property (nonatomic, assign) IBInspectable UIColor *gLBorderColor;//给xib使用的边线颜色
@end
