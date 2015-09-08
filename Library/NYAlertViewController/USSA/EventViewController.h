//
//  EventViewController.h
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface EventViewController : UIViewController<SHMultipleSelectDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet UILabel *lblFirst;

@property (weak, nonatomic) IBOutlet UILabel *lblSecond;

@property (weak, nonatomic) IBOutlet UILabel *lblThird;

@property (weak, nonatomic) IBOutlet UILabel *lblFourth;

@property (weak, nonatomic) IBOutlet UILabel *lblFifth;

@property (weak, nonatomic) IBOutlet UILabel *lblSixth;

@property (weak, nonatomic) IBOutlet UILabel *lblSeventh;

@property (weak, nonatomic) IBOutlet UILabel *lblEigth;

@property (weak, nonatomic) IBOutlet UIButton *btnCheck;

@property (weak, nonatomic) IBOutlet UIButton *btnCheck1;

@property (weak, nonatomic) IBOutlet UIView *chooseSubView;

@property (weak, nonatomic) IBOutlet UIView *checkSubView;

@property (weak, nonatomic) IBOutlet UIView *bothSubView;

@property (weak, nonatomic) IBOutlet UILabel *lblFirst2;

@property (weak, nonatomic) IBOutlet UILabel *lblSecond2;

@property (weak, nonatomic) IBOutlet UILabel *lblThird2;

@property (weak, nonatomic) IBOutlet UILabel *lblFourth2;

@property (weak, nonatomic) IBOutlet UILabel *lblFifth2;

@property (weak, nonatomic) IBOutlet UILabel *lblSixth2;

@property (weak, nonatomic) IBOutlet UILabel *lblSeventh2;

@property (weak, nonatomic) IBOutlet UILabel *lblEigth2;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

- (IBAction)btnSelectClicked:(id)sender;

- (IBAction)btnCheckClicked:(id)sender;

- (IBAction)btnCheck1Clicked:(id)sender;

@end
