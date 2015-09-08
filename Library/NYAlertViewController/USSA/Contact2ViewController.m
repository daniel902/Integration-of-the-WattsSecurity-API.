//
//  Contact2ViewController.m
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "Contact2ViewController.h"

@interface Contact2ViewController()
{
    BOOL handPhoneStatus;
    NSString * flag, * flag1;
    NSInteger age, curYear;
    REFormattedNumberField *txtPhoneNumber;
    NSUserDefaults * userDefaults;

}

@end

@implementation Contact2ViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.btnHandPhone.layer.borderWidth = 1;
    self.btnHandPhone.layer.cornerRadius = 5;
    self.btnHandPhone.layer.borderColor = (__bridge CGColorRef)([UIColor clearColor]);
    [self.btnHandPhone setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.0f]];
    
    self.btnTelePhone.layer.borderWidth = 1;
    self.btnTelePhone.layer.cornerRadius = 5;
    self.btnTelePhone.layer.borderColor = (__bridge CGColorRef)([UIColor clearColor]);
    [self.btnTelePhone setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.0f]];
    
    handPhoneStatus = YES;
    
    txtPhoneNumber = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(41, 559, 264, 50)];
    txtPhoneNumber.backgroundColor = [UIColor whiteColor];
    [txtPhoneNumber setBackground:[UIImage imageNamed:@"txtBackground"]];
    txtPhoneNumber.format = @"XXX-XXX-XXXX";
    txtPhoneNumber.placeholder = @"222-222-2222";
    txtPhoneNumber.font = [UIFont fontWithName:@"GothamNarrow-Book" size:20.0f];
    [txtPhoneNumber addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:txtPhoneNumber];

    userDefaults = [NSUserDefaults standardUserDefaults];
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload {
    self.btnSelect = nil;
    [self setBtnSelect:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL) isValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter
{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClicked:(id)sender {

    age = [self.btnYear.titleLabel.text integerValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    curYear = [yearString integerValue];
    
    self.strFirstName = self.txtFirstName.text;
    self.strLastName = self.txtLastName.text;
    self.strGender = self.txtGender.text;
    self.strStreet = self.txtStreet.text;
    self.strAvenue = self.txtAvenue.text;
    self.strCity = self.txtCity.text;
    self.strProvince  = self.txtProvince.text;
    self.strEmail = self.txtEmail.text;
    self.strPhoneNumber = txtPhoneNumber.text;
    self.strYear = self.btnYear.titleLabel.text;
    self.strMonth = self.btnMonth.titleLabel.text;
    self.strDay = self.btnDay.titleLabel.text;
    self.strServe = self.btnSelect.titleLabel.text;
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.strEmail = self.strEmail;
    
    [userDefaults setObject:self.strFirstName forKey:@"firstname"];
    [userDefaults setObject:self.strLastName    forKey:@"lastname"];
    [userDefaults setObject:self.strGender forKey:@"title"];
    [userDefaults setObject:self.strEmail forKey:@"email"];
    [userDefaults setObject:self.strPhoneNumber forKey:@"phone"];
    [userDefaults setObject:self.strYear forKey:@"birthday_year"];
    [userDefaults setObject:self.strMonth forKey:@"birthday_month"];
    [userDefaults setObject:self.strDay forKey:@"birthday_day"];
    [userDefaults setObject:self.strServe forKey:@"served"];
    [userDefaults synchronize];

    
    if(self.txtFirstName.text.length ==0 || self.txtLastName.text.length == 0 || self.txtGender.text.length == 0 || self.txtStreet.text.length ==0 || self.txtCity.text.length == 0 || self.txtProvince.text.length == 0 || self.txtAvenue.text.length == 0 || self.txtEmail.text.length == 0 || txtPhoneNumber.text.length == 0 || [self.btnYear.titleLabel.text isEqualToString:@"Year"] || [self.btnMonth.titleLabel.text isEqualToString:@"Month"] || [self.btnDay.titleLabel.text isEqualToString:@"Day"] || [self.btnSelect.titleLabel.text isEqualToString:@"Select"]){
        
        flag = @"Yes";
        [self customAlertShow];
        return;
        
    }else if (![self isValidEmail:self.txtEmail.text Strict:YES]){
        flag = @"No";
        [self customAlertShow];
        return;
        
    }else if(curYear - age < 18){
        flag = @"Exception";
        [self customAlertShow];
        return;

    }else{
//        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        HUD.labelText = @"Uploading";
//        HUD.dimBackground = YES;
//
//        NSDictionary *dictmp = [[NSDictionary alloc] initWithObjectsAndKeys:@"qq" ,@"firstname", @"qq" , @"lastname",@"m" , @"title", @"gmail.com",@"email", @"2342342" ,@"phone", @"1987", @"birthday_year", @"12", @"birthday_month",@"12" ,@"birthday_day", @"yes", @"served", nil];
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mvp-interactive.com/api-usaa/"]]];
//        [request setPostValue:@"saveall" forKey:@"command"];
//        [request setPostValue:dictmp forKey:@"data"];
//        [request addRequestHeader:@"Authorization" value:@"Basic bXZwaW50OmRldnRlMTkyMTA="];
//        [request addRequestHeader:@"Content-Type" value:@"application/json"];
//        [request addRequestHeader:@"Accept" value:@"application/json"];
//        [request setDelegate:self];
//        [request setTimeOutSeconds:30.0];
//        [request setRequestMethod:@"POST"];
//        [request startAsynchronous];
        
        MilitaryViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MilitaryViewController"];
        [self.navigationController pushViewController:VC animated:YES];

    }
}

- (IBAction)yearClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    
    for (int i = 1950; i < 2100; i ++) {
        arr = [arr arrayByAddingObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)monthClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"January", @"Feburary", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"Octorbor", @"November", @"December", nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)dayClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    
    for (int i = 1; i < 32; i ++) {
        arr = [arr arrayByAddingObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Yes", @"No", nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 80;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)handPhoneClicked:(id)sender {
    [self.btnHandPhone setBackgroundColor:[UIColor colorWithRed:0.0f green:0.247f blue:0.361f alpha:1.0f]];
    [self.btnTelePhone setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.0f]];
    handPhoneStatus = YES;
    self.strPhoneType = @"handPhone";
}

- (IBAction)telePhoneClicked:(id)sender {
    [self.btnTelePhone setBackgroundColor:[UIColor colorWithRed:0.0f green:0.247f blue:0.361f alpha:1.0f]];
    [self.btnHandPhone setBackgroundColor:[UIColor colorWithRed:0.914f green:0.914f blue:0.914f alpha:1.0f]];
    handPhoneStatus = NO;
    self.strPhoneType = @"telePhone";
}

- (void) customAlertShow{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"Warning", nil);
    if ([flag isEqualToString:@"No"]) {
        flag1 = @"Please enter a valid email";
    }else if([flag isEqualToString:@"Yes"]){
        flag1 = @"Please fill all required information";
    }else if([flag isEqualToString:@"Exception"]){
        flag1 = @"Date Of Birthday is needed since the prize must be awarded to someone 18 years or older.";
    }else if([flag isEqualToString:@"PhoneNumber Length Error"]){
        flag1 = @"PhoneNumber length can not be larger than 10";
    }

    
    alertViewController.message = NSLocalizedString(flag1, nil);
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.933f green:0.671f blue:0.035f alpha:1.0f];
    alertViewController.messageColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.933f green:0.671f blue:0.035f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - ASIHTTPRequest Delegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MilitaryViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MilitaryViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - NIDropDown Delegate Method.

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

#pragma mark - Execution code

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

#pragma mark Handle events

- (void)textDidChange:(UITextField *)textField
{
    NSLog(@"textField.placeholder %@ textDidChange %@", textField.placeholder, textField.text);
}

@end
