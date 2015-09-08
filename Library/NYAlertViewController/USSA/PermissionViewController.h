//
//  PermissionViewController.h
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PermissionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnCheck;

- (IBAction)checkClicked:(id)sender;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

@end
