//
//  RankViewController.h
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface RankViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown * dropDown;
}

@property (weak, nonatomic) IBOutlet UIButton *btnServiceBranch;

@property (weak, nonatomic) IBOutlet UIButton *btnServiceRank;

@property (weak, nonatomic) IBOutlet UIButton *btnComSource;

@property (weak, nonatomic) IBOutlet UIButton *btnComYear;

@property (weak, nonatomic) IBOutlet UIButton *btnEnlistMonth;

@property (weak, nonatomic) IBOutlet UIView *fifthSubView;

@property (weak, nonatomic) IBOutlet UIView *sixthSubView;

@property (weak, nonatomic) IBOutlet UIButton *btnEnlistYear;

@property (weak, nonatomic) IBOutlet UIButton *btnComMonth;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

- (IBAction)btnSelectClicked:(id)sender;

- (IBAction)btnSelect1Clicked:(id)sender;

- (IBAction)btnSelect2Clicked:(id)sender;

- (IBAction)btnYearClicked:(id)sender;

- (IBAction)btnMonthClicked:(id)sender;

-(void)rel;

@end
