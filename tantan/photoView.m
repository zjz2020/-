//
//  photoView.m
//  tantan
//
//  Created by 张君泽 on 16/7/13.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import "photoView.h"

@implementation photoView
- (void)awakeFromNib{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 2;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
