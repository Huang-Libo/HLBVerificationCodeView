//
//  HLBDemoView.m
//  HLBVerificationCodeViewDemo
//
//  Created by HuangLibo on 2019/6/23.
//  Copyright © 2019 HuangLibo. All rights reserved.
//

#import "HLBDemoView.h"
#import <HLBVerificationCodeView/HLBVerificationCodeView.h>

@implementation HLBDemoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.verificationCodeView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.verificationCodeView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                         constant:150.],
                           
                           [NSLayoutConstraint constraintWithItem:self.verificationCodeView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:.0],
                           
                           [NSLayoutConstraint constraintWithItem:self.verificationCodeView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1
                                                         constant:300.],
                           
                           [NSLayoutConstraint constraintWithItem:self.verificationCodeView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1
                                                         constant:84.],
                           ]];
}

#pragma mark - 懒加载控件

- (HLBVerificationCodeView *)verificationCodeView {
    if (!_verificationCodeView) {
        _verificationCodeView = [[HLBVerificationCodeView alloc] init];
        _verificationCodeView.digitCount = 6;
        _verificationCodeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _verificationCodeView;
}

@end
