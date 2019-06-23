//
//  HLBVerificationCodeView.m
//  HLBVerificationCodeViewDemo.xcodeproj HLBVerificationCodeView
//
//  Created by HuangLibo on 2019/6/23.
//  Copyright © 2019 HuangLibo. All rights reserved.
//

#import "HLBVerificationCodeView.h"

@interface HLBVerificationCodeView ()

/// 居中的样式
@property (nonatomic, strong) NSMutableParagraphStyle *style;

/// 记录已输入的验证码
@property (nonatomic, strong) NSMutableString *text;

/// 获取当前已输入的内容 (可以通过 KVO 监听这个值的变化)
@property (nonatomic, copy) NSString *currentText;

/// 验证码字体的属性 (对用户给定的 attrs 属性再做一些处理)
@property (nonatomic, strong) NSMutableDictionary<NSAttributedStringKey, id> *attributes;

@end

@implementation HLBVerificationCodeView {
    // 下划线的长度
    CGFloat _underLineLength;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 初始化时, 设置默认值
        _margin = 10;
        _padding = 10;
        _underLineHeight = 2;
        _digitCount = 4;
        _underLineColor = [UIColor grayColor];
        _text = [[NSMutableString alloc] initWithString:@""];
        
        _attributes = [@{NSFontAttributeName : [UIFont systemFontOfSize:40], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName:self.style} mutableCopy];
        
    }
    return self;
}

- (void)setAttrs:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    _attrs = attrs;
    
    _attributes = [_attrs mutableCopy];
    _attributes[NSParagraphStyleAttributeName] = self.style;
}

- (void)drawRect:(CGRect)rect {
    // 下划线坐标的 y 值
    CGFloat y = rect.size.height - _underLineHeight;
    // 根据 view 的总长度, margin, padding 和验证码的个数来计算下划线的长度
    _underLineLength = (rect.size.width - 2 * _margin - (self.digitCount - 1) * _padding) / self.digitCount;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    // 记录当前的 point
    CGPoint currentPoint = CGPointMake(_margin, y);
    // 移动到第一个下划线的起点
    [path moveToPoint:currentPoint];
    
    // 循环绘制下划线和对应的数字
    for (NSUInteger i = 0; i < self.digitCount; i++) {
        // 第一个下划线前面没有 padding
        if (i > 0) {
            currentPoint = CGPointMake(currentPoint.x + _padding , y);
            [path moveToPoint:currentPoint];
        }
        
        if (i < self.text.length) {
            // 取出当前的数字
            NSString *subString = [self.text substringWithRange:NSMakeRange(i, 1)];
            CGSize subStringSize = [subString sizeWithAttributes:_attributes];
            CGRect subStringRect = CGRectMake(currentPoint.x, y - subStringSize.height, _underLineLength, y);
            // 绘制数字
            [subString drawInRect:subStringRect withAttributes:_attributes];
        }
        
        currentPoint = CGPointMake(currentPoint.x + _underLineLength, y);
        [path addLineToPoint:currentPoint];
    }
    
    // 创建矢量图图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = self.underLineColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = self.underLineHeight;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    [path closePath];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - UIKeyInput protocol

- (BOOL)hasText {
    return self.text.length > 0;
}

- (void)insertText:(NSString *)text {
    if (self.text.length == self.digitCount) return;
    
    [self.text appendString:text];
    
    self.currentText = [self.text copy];
    [self setNeedsDisplay];
}

- (void)deleteBackward {
    if (self.text.length == 0) return;
    
    [self.text deleteCharactersInRange:NSMakeRange(self.text.length - 1, 1)];
    
    self.currentText = [self.text copy];
    [self setNeedsDisplay];
}

#pragma mark - UITextInputTraits protocol

-(UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

#pragma mark - 懒加载对象属性

- (NSMutableParagraphStyle *)style {
    if (!_style) {
        _style = [[NSMutableParagraphStyle alloc] init];
        _style.alignment = NSTextAlignmentCenter;
    }
    return _style;
}

@end

