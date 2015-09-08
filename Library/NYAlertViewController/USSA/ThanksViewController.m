//
//  ThanksViewController.m
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "ThanksViewController.h"
#import "Public.h"

@interface ThanksViewController()

@end

@implementation ThanksViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self.imageView sd_setImageWithURL:appDelegate.imageURL
                    placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.lblEmail.text = appDelegate.strEmail;
    
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
