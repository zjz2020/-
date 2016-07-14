//
//  ViewController.m
//  tantan
//
//  Created by 张君泽 on 16/7/13.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import "ViewController.h"
#import "photoView.h"
@interface ViewController ()
@property (nonatomic)CGPoint aPoint;
@property (nonatomic)CGFloat theX;
@property (nonatomic, strong)photoView *theUpView;
//移动之前的中心点
@property (nonatomic)CGPoint oldPoint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    for (int i = 0; i < 3; i ++) {
        photoView *i = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([photoView class]) owner:nil options:nil].firstObject;
        [self.view addSubview:i];
    }
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidLayoutSubviews{
    NSMutableArray *array = [NSMutableArray new];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[photoView class]]) {
            [array addObject:view];
        }
    }
    for (int i = 0; i < array.count; i ++) {
        photoView *photov = (photoView *)array[i];
        photov.frame = CGRectMake(0, 0, 300, 400);
        photov.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 - i *10, [UIScreen mainScreen].bounds.size.height/2 - i *10);
        if (i == (array.count - 1)) {
            self.theUpView = photov;
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    self.aPoint = point;
    self.oldPoint = self.theUpView.center;
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    self.theUpView.center = point;
    CGFloat x = point.x - self.aPoint.x;
    self.theX += x;
    self.aPoint = point;
    if (self.theX > 0) {
        self.theUpView.heartImage.image = [UIImage imageNamed:@"3"];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%.2f",fabs(self.theX));
    if (fabs(self.theX) > 20) {
        if (self.theX > 0) {//喜欢
            NSLog(@"哈哈");
            [self alartWithString:@"你喜欢TA"];
        }else if(self.theX < 0){
            [self alartWithString:@"你不喜欢TA"];
        }
        [self.theUpView removeFromSuperview];
        //添加一直图片
        photoView *photV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([photoView class]) owner:nil options:nil].firstObject;
        photV.imageV.image = [UIImage imageNamed:self.RandomImageName];
        [self.view insertSubview:photV atIndex:1];
        self.theX = 0;
    }else{
        self.theUpView.center = self.oldPoint;
    }
}
- (void)alartWithString:(NSString *)string{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"注意" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}
- (void)setRandomImageName:(NSString *)RandomImageName{
   _RandomImageName = RandomImageName;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
