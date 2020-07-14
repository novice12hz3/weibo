//
//  ZHWriteTextView.m
//  微博text
//
//  Created by fu00 on 2020/5/7.
//  Copyright © 2020 fu00. All rights reserved.
//

#import "ZHWriteTextView.h"

@implementation ZHWriteTextView
- (UILabel *)placeHolderLabel{
    if(!_placeHolderLabel){
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}


- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
    self.placeHolderLabel.font = [UIFont systemFontOfSize:30];
    [self.placeHolderLabel sizeToFit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
