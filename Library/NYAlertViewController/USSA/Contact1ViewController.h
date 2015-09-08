//
//  Contact1ViewController.h
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface Contact1ViewController : UIViewController<NIDropDownDelegate, MBProgressHUDDelegate>
{
    NIDropDown *dropDown;
}

@property (weak, nonatomic) IBOutlet UITextField *firstNameText;

@property (weak, nonatomic) IBOutlet UITextField *lastNameText;

@property (weak, nonatomic) IBOutlet UITextField *genderText;

@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UIButton *handPhone;

@property (weak, nonatomic) IBOutlet UIButton *telePhone;

@property (weak, nonatomic) IBOutlet UIButton *btnYear;

@property (weak, nonatomic) IBOutlet UIButton *btnMonth;

@property (weak, nonatomic) IBOutlet UIButton *btnDay;

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (strong, nonatomic) NSString * strFirstName;

@property (strong, nonatomic) NSString * strLastName;

@property (strong, nonatomic) NSString * strGender;

@property (strong, nonatomic) NSString * strEmail;

@property (strong, nonatomic) NSString * strPhoneNumber;

@property (strong, nonatomic) NSString * strPhoneType;

@property (strong, nonatomic) NSString * strYear;

@property (strong, nonatomic) NSString * strMonth;

@property (strong, nonatomic) NSString * strDay;

@property (strong, nonatomic) NSString * strServe;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

- (IBAction)yearClicked:(id)sender;

- (IBAction)monthClicked:(id)sender;

- (IBAction)dayClicked:(id)sender;

- (IBAction)selectClicked:(id)sender;

- (IBAction)handPhoneClicked:(id)sender;

- (IBAction)telePhoneClicked:(id)sender;

-(void)rel;

@end
