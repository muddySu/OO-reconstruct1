//
//  View.m
//  OO-reconstruct
//
//  Created by su on 12/31/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import "View.h"

@implementation View

#pragma mark
#pragma mark - 设置label
- (void) setLabelStyle:(UILabel *)_Label andText:(NSString *)text andTextColor:(UIColor *)textColor andBackgroundColor:(UIColor *)backgroundColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)textAlignment{
    _Label.text = text;
    _Label.textColor = textColor;
    _Label.backgroundColor = backgroundColor;
    _Label.font = font;
    _Label.textAlignment = textAlignment;
}


#pragma mark
#pragma mark - 设置textField
- (void) setTextStyle:(UITextField *)_textField andBordeStyle:(UITextBorderStyle)borderStyle andBackgroundColor:(UIColor *)backgroundColor andString:(NSString *)placeholder andAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment andFront:(UIFont *)font andModel:(UITextFieldViewMode)clearButtonMode andKeyboardType:(UIKeyboardType)keyboardType andDelegate:(id<UITextFieldDelegate>)delegate{
    _textField.borderStyle = borderStyle;
    _textField.backgroundColor = backgroundColor;
    _textField.placeholder = placeholder;
    _textField.contentVerticalAlignment = contentVerticalAlignment;
    _textField.font = font;
    _textField.clearButtonMode = clearButtonMode;
    _textField.keyboardType = keyboardType;
    _textField.delegate = delegate;
}

#pragma mark
#pragma mark - 设置button
- (void) setButtonStyle:(UIButton *)_button andTitleColor:(UIColor *)titleColor andTitle:(NSString *)titleString withState:(UIControlState)controlState andLayerborderWidth:(CGFloat)borderWidth andLayercornerRadius:(CGFloat)cornerRadius withLayermasksToBounds:(BOOL)flag andBackgroundColor:(UIColor *)backColor withLayerborderColor:(UIColor *)borderColor{
    [_button setTitle:titleString forState:controlState];
    [_button setTitleColor:titleColor forState:controlState];
    _button.backgroundColor = backColor;
    _button.layer.borderWidth = borderWidth;
    _button.layer.cornerRadius = cornerRadius;
    _button.layer.borderColor = (__bridge CGColorRef)(borderColor);
}


@end
