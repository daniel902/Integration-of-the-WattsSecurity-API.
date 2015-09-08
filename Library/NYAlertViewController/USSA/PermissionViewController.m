//
//  PermissionViewController.m
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "PermissionViewController.h"
#import "Public.h"

@interface PermissionViewController()
{
    BOOL checkStatus;
}

@end

@implementation PermissionViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.btnCheck.layer.borderWidth = 1;
    self.btnCheck.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnCheck.layer.cornerRadius = 5;

    checkStatus = YES;
}

- (IBAction)checkClicked:(id)sender {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    if (checkStatus == YES) {
        [self.btnCheck setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        checkStatus = NO;
        appDelegate.strCheck = @"Yes";
    }else{
        [self.btnCheck setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        checkStatus = YES;
        appDelegate.strCheck = @"No";
    }
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClicked:(id)sender {
    Contact2ViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact2ViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
