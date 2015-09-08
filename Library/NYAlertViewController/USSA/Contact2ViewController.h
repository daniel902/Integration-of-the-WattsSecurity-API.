//
//  Contact2ViewController.h
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface Contact2ViewController : UIViewController<NIDropDownDelegate, MBProgressHUDDelegate>
{
    NIDropDown *dropDown;
}

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtGender;

@property (weak, nonatomic) IBOutlet UITextField *txtStreet;

@property (weak, nonatomic) IBOutlet UITextField *txtAvenue;

@property (weak, nonatomic) IBOutlet UITextField *txtCity;

@property (weak, nonatomic) IBOutlet UITextField *txtProvince;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

//@property (weak, nonatomic) IBOutlet REFormattedNumberField *txtPhoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnHandPhone;

@property (weak, nonatomic) IBOutlet UIButton *btnTelePhone;

@property (weak, nonatomic) IBOutlet UIButton *btnYear;

@property (weak, nonatomic) IBOutlet UIButton *btnMonth;

@property (weak, nonatomic) IBOutlet UIButton *btnDay;

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (nonatomic, strong) NSString *strFirstName;

@property (nonatomic, strong) NSString * strLastName;

@property (nonatomic, strong) NSString * strGender;

@property (nonatomic, strong) NSString * strStreet;

@property (nonatomic, strong) NSString * strAvenue;

@property (nonatomic, strong) NSString * strCity;

@property (nonatomic, strong) NSString * strProvince;

@property (nonatomic, strong) NSString * strEmail;

@property (nonatomic, strong) NSString * strPhoneNumber;

@property (nonatomic, strong) NSString * strPhoneType;

@property (nonatomic, strong) NSString * strYear;

@property (nonatomic, strong) NSString * strMonth;

@property (nonatomic, strong) NSString * strDay;

@property (nonatomic, strong) NSString * strServe;

- (IBAction)yearClicked:(id)sender;

- (IBAction)monthClicked:(id)sender;

- (IBAction)dayClicked:(id)sender;

- (IBAction)selectClicked:(id)sender;

- (IBAction)handPhoneClicked:(id)sender;

- (IBAction)telePhoneClicked:(id)sender;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

-(void)rel;

@end
