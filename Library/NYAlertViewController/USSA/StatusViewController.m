//
//  StatusViewController.m
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "StatusViewController.h"

@interface StatusViewController ()
{
    NSUserDefaults * userDefaults;
    NSString * strMessage, * string;
    BOOL checkStatus;

}
@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [NSUserDefaults standardUserDefaults];

    self.btnEventCheck.layer.borderWidth = 1;
    self.btnEventCheck.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnEventCheck.layer.cornerRadius = 5;
    
    checkStatus = YES;
    
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload {
    //    [btnSelect release];
    self.btnSelect = nil;
    [self setBtnSelect:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClicked:(id)sender {
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSLog(@"%@", appDelegate.strOption);
    
    if ([self.btnSelect.titleLabel.text isEqualToString:@"Yes"]) {
        [userDefaults setObject:@"yes" forKey:@"prevaccount"];
        [userDefaults synchronize];
        appDelegate.strACTST = @"Yes";
    }else{
        [userDefaults setObject:@"no" forKey:@"prevaccount"];
        [userDefaults synchronize];
        appDelegate.strACTST = @"No";
    }
    
    if ([self.btnSelect.titleLabel.text isEqualToString:@"Select"] ) {
        [self customAlertShow];
    }else{
        if ([self.btnSelect.titleLabel.text isEqualToString:@"Yes"]) {
            Contact1ViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact1ViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }else if([self.btnSelect.titleLabel.text isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"other"]){
            Contact2ViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact2ViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }else if([self.btnSelect.titleLabel.text isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"army"]){
            PermissionViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"PermissionViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

- (IBAction)btnOptionClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Army installation event", @"All other events", nil];
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

- (IBAction)btnUnlockClicked:(id)sender {
    [self.passSubView setHidden:NO];
}

- (IBAction)btnConfirmClicked:(id)sender {
    if ([self.txtPassword.text isEqualToString:@"1234"]) {
        [self.passSubView setHidden:YES];
        [self.eventSubView setHidden:NO];
        self.txtPassword.text = @"";
    }else{
        strMessage = @"confirm error";
        [self customAlertShow];
    }
}

- (IBAction)btnEventClicked:(id)sender {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    if (checkStatus == YES) {
        [self.btnEventCheck setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        checkStatus = NO;
        appDelegate.strCheck = @"Yes";
        appDelegate.strOption = @"other";

    }else{
        [self.btnEventCheck setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        checkStatus = YES;
        appDelegate.strCheck = @"No";
        appDelegate.strOption = @"army";
    }
    
}

- (IBAction)btnEventConfirmClicked:(id)sender {
    [self.eventSubView setHidden:YES];
}

- (void) customAlertShow{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    if ([strMessage isEqualToString:@"confirm error"]) {
        string = @"Confirm Failed, Retry later";
    }else{
        string = @"You can not go to next page without selecting your status, Please select your status.";

    }
    alertViewController.title = NSLocalizedString(@"Warning", nil);
    alertViewController.message = NSLocalizedString(string, nil);
    
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

#pragma mark - NIDropDown Delegate Method.

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

@end
