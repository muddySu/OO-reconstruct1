//
//  View.h
//  OO-reconstruct
//
//  Created by su on 12/31/14.
//  Copyright (c) 2014 su. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 @des:该view作为所有view的父类，你应该继承他而不是直接实例化他
 */
@interface View : UIView
{
}

//setting uilabel
- (void)setLabelStyle:(UILabel *)_Label
              andText:(NSString *)text
         andTextColor:(UIColor *)textColor
   andBackgroundColor:(UIColor *)backgroundColor
              andFont:(UIFont *)font
     andTextAlignment:(NSTextAlignment)textAlignment;

//setting uitextfield
- (void)setTextStyle:(UITextField*)_textField
       andBordeStyle:(UITextBorderStyle)borderStyle
  andBackgroundColor:(UIColor*)backgroundColor
           andString:(NSString*)placeholder
        andAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment
            andFront:(UIFont*)font
            andModel:(UITextFieldViewMode)clearButtonMode
     andKeyboardType:(UIKeyboardType)keyboardType
         andDelegate:(id<UITextFieldDelegate>)delegate;

//setting uibutton
- (void)setButtonStyle:(UIButton *)_button
         andTitleColor:(UIColor *)titleColor
              andTitle:(NSString *)titleString withState:(UIControlState)controlState
   andLayerborderWidth:(CGFloat)borderWidth
  andLayercornerRadius:(CGFloat)cornerRadius withLayermasksToBounds:(BOOL)flag
    andBackgroundColor:(UIColor *)backColor withLayerborderColor:(UIColor *)borderColor;

@end
