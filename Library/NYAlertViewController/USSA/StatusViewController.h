//
//  StatusViewController.h
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface StatusViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown * dropDown;
}

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet UIButton *btnOption;

@property (weak, nonatomic) IBOutlet UIView *passSubView;

@property (weak, nonatomic) IBOutlet UIView *eventSubView;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnEventCheck;

- (IBAction)selectClicked:(id)sender;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

- (IBAction)btnOptionClicked:(id)sender;

- (IBAction)btnUnlockClicked:(id)sender;

- (IBAction)btnConfirmClicked:(id)sender;

- (IBAction)btnEventClicked:(id)sender;

- (IBAction)btnEventConfirmClicked:(id)sender;

-(void)rel;

@end
