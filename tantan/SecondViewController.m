//
//  SecondViewController.m
//  tantan
//
//  Created by 张君泽 on 16/7/13.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import "SecondViewController.h"
#import <ContactsUI/ContactsUI.h>
@interface SecondViewController ()<CNContactPickerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.RandomImageName = @"22";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, 375, 40);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(didClickTheContacts:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
//获取联系人
- (void)didClickTheContacts:(UIButton *)sender{
    CNContactPickerViewController *contactC = [[CNContactPickerViewController alloc] init];
    contactC.delegate = self;
    //弹出通讯录
    [self presentViewController:contactC animated:YES completion:nil];
}
#pragma mark CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    NSLog(@"%@",contact);
    NSString *firstName = contact.familyName;
    NSString *lastName = contact.givenName;
    NSLog(@"%@--%@",lastName,firstName);
    NSArray *phoneArray = contact.phoneNumbers;
    for (CNLabeledValue *labelV in phoneArray) {
        CNPhoneNumber *value = labelV.value;
        NSString *phoneValue = value.stringValue;
        NSString *phoneLabel = labelV.label;
        [self teleleWithPhoNum:phoneValue];
        NSLog(@"%@_电话:_%@",phoneLabel,phoneValue);
    }
}
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alartWithString:(NSString *)string{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"注意" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}
//拨打电话操作
- (void)teleleWithPhoNum:(NSString *)phoNum{
    UIWebView *webV = [[UIWebView alloc] init];
    NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoNum]];
    [webV loadRequest:[NSURLRequest requestWithURL:telUrl]];
    [self.view addSubview:webV];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
