//
//  MilitaryViewController.h
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface MilitaryViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown * dropDown;
}

@property (weak, nonatomic) IBOutlet UIButton *btnMilitaryStatus;

@property (weak, nonatomic) IBOutlet UIView *firstSubView;

@property (weak, nonatomic) IBOutlet UIView *secondSubView;

@property (weak, nonatomic) IBOutlet UIView *thirdSubView;

@property (weak, nonatomic) IBOutlet UIView *fourthSubView;

@property (weak, nonatomic) IBOutlet UIButton *btn1Select;

@property (weak, nonatomic) IBOutlet UIButton *btn2Select;

@property (weak, nonatomic) IBOutlet UIButton *btnRetireYear;

@property (weak, nonatomic) IBOutlet UIButton *btnRetireMonth;

@property (weak, nonatomic) IBOutlet UIButton *btnSeparateYear;

@property (weak, nonatomic) IBOutlet UIButton *btnSeparateMonth;

@property (weak, nonatomic) IBOutlet UIButton *btnComponent;

@property (weak, nonatomic) IBOutlet UIButton *btnDischarge;

@property (weak, nonatomic) IBOutlet UIButton *btnServe;

@property (nonatomic, strong) NSString * strStatus;

- (IBAction)selectClicked:(id)sender;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

- (IBAction)select1Clicked:(id)sender;

- (IBAction)btnYearClicked:(id)sender;

- (IBAction)btnMonthClicked:(id)sender;

- (IBAction)btnSelect1Clicked:(id)sender;

- (IBAction)btnServeClicked:(id)sender;

- (IBAction)btn2SelectClicked:(id)sender;

-(void)rel;

@end
