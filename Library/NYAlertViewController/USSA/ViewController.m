//
//  ViewController.m
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "ViewController.h"
#import "Public.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtTermView.editable = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startClicked:(id)sender {
    StatusViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewController"];
    [self.navigationController pushViewController:VC animated:YES];

//    ListViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
//    [self.navigationController pushViewController:VC animated:YES];
}

@end
