//
//  HLBVerificationCodeView.h
//  HLBVerificationCodeView
//
//  Created by HuangLibo on 2019/6/23.
//  Copyright © 2019 HuangLibo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 验证码输入的 View
 */
@interface HLBVerificationCodeView : UIView <UIKeyInput, UITextInputTraits>

/// 获取当前已输入的内容 (可以通过 KVO 监听这个值的变化)
@property (nonatomic, copy, readonly) NSString *currentText;

/// 第一个下划线和 view 的间隔, 默认值是 10
@property (nonatomic, assign) CGFloat margin;

/// 下划线之间的距离, 默认值是 10
@property (nonatomic, assign) CGFloat padding;

/// 下划线的高度, 默认值是 2
@property (nonatomic, assign) CGFloat underLineHeight;

/// 下划线的颜色, 默认值是 grayColor
@property (nonatomic, strong) UIColor *underLineColor;

/// 验证码字体的属性
@property (nonatomic, strong) NSDictionary<NSAttributedStringKey, id> *attrs;

/// 验证码数字的个数, 默认值是 4
@property (nonatomic, assign) NSInteger digitCount;

@end
