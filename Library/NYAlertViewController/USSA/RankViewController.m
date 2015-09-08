//
//  RankViewController.m
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController()
{
    NSUserDefaults * userDefaults;
}

@end

@implementation RankViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFifthView) name:@"fifthEvent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSixView) name:@"sixthEvent" object:nil];

    userDefaults = [NSUserDefaults standardUserDefaults];

}

- (void)showFifthView{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.strACTST isEqualToString:@"No"]) {
        [self.fifthSubView setHidden:NO];
        [self.sixthSubView setHidden:YES];
    }

}

- (void) showSixView{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];

    if ([appDelegate.strACTST isEqualToString:@"No"]) {
        [self.sixthSubView setHidden:NO];
        [self.fifthSubView setHidden:YES];
    }
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClicked:(id)sender {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];

    if ((![self.btnServiceBranch.titleLabel.text isEqualToString:@"Select"]) && (![self.btnServiceRank.titleLabel.text isEqualToString:@"Select"])) {
        
        [userDefaults setObject:self.btnServiceBranch.titleLabel.text forKey:@"served_branch"];
        [userDefaults setObject:self.btnServiceRank.titleLabel.text forKey:@"served_rank"];
        [userDefaults synchronize];
        
        if ([appDelegate.strACTST isEqualToString:@"Yes"]) {
            EventViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            if ([self.btnServiceRank.titleLabel.text isEqualToString:@"E-1"] || [self.btnServiceRank.titleLabel.text isEqualToString:@"E-2"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-3"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-4"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-5"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-6"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-7"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-8"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"E-9"]) {
                if ((![self.btnEnlistYear.titleLabel.text isEqualToString:@"Year"]) && (![self.btnEnlistMonth.titleLabel.text isEqualToString:@"Month"])) {
                    [userDefaults setObject:self.btnEnlistYear.titleLabel.text forKey:@"enlist_year"];
                    [userDefaults setObject:self.btnEnlistMonth.titleLabel.text forKey:@"enlist_month"];
                    [userDefaults synchronize];
                    if([appDelegate.strACTST isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"other"]){
                        EventViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
                        [self.navigationController pushViewController:VC animated:YES];
                    }else if([appDelegate.strACTST isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"army"]){
                        ListViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
                        [self.navigationController pushViewController:VC animated:YES];
                    }

                }else{
                    [self customAlertShow];
                }
                
            }else if ([self.btnServiceRank.titleLabel.text isEqualToString:@"O-1"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-2"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-3"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-4"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-5"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-6"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-7"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-8"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-9"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"O-10"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"WO-1"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"WO-2"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"WO-3"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"WO-4"] ||[self.btnServiceRank.titleLabel.text isEqualToString:@"WO-5"] ){
                if ((![self.btnComYear.titleLabel.text isEqualToString:@"Year"]) && (![self.btnComMonth.titleLabel.text isEqualToString:@"Month"]) && (![self.btnComSource.titleLabel.text isEqualToString:@"Select"])) {
                    [userDefaults setObject:self.btnComYear.titleLabel.text forKey:@"comm_year"];
                    [userDefaults setObject:self.btnComMonth.titleLabel.text forKey:@"comm_month"];
                    [userDefaults setObject:self.btnComSource.titleLabel.text forKey:@"comm_source"];
                    [userDefaults synchronize];
                    
                    if([appDelegate.strACTST isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"other"]){
                        EventViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
                        [self.navigationController pushViewController:VC animated:YES];
                    }else if([appDelegate.strACTST isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"army"]){
                        ListViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
                        [self.navigationController pushViewController:VC animated:YES];
                    }

                }else{
                    [self customAlertShow];
                }
        }
        
        }
    }
    else{
        [self customAlertShow];
    }
}

- (void) customAlertShow{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"Warning", nil);
    alertViewController.message = NSLocalizedString(@"You can not go to next page without selecting your status, Please select your status.", nil);
    
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

- (IBAction)btnSelectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Army", @"Marine Corps", @"Navy", @"Air Force", @"Coast Guard", nil];
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

- (IBAction)btnSelect1Clicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"E-1", @"E-2", @"E-3", @"E-4", @"E-5", @"E-6", @"E-7", @"E-8", @"E-9", @"O-1", @"O-2", @"O-3", @"O-4", @"O-5", @"O-6", @"O-7", @"O-8", @"O-9", @"O-10", @"WO-1", @"WO-2", @"WO-3", @"WO-4", @"WO-5", nil];
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

- (IBAction)btnSelect2Clicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Direct Commission - Civilian", @"Direct Commission - Enlisted", @"West Point Graduate",  @"ROTC Scholarship", @"Officer Candidate School", @"Officer Training School", @"None", @"ROTC Non-Scholarship", @"Air Force Academy", @"Naval Academy", @"Coast Guard Academy", @"Merchant Marine Academy", @"Other", @"Presidential Appointment", nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"up"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

}

- (IBAction)btnYearClicked:(id)sender {
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

- (IBAction)btnMonthClicked:(id)sender {
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

#pragma mark - NIDropDown Delegate Method.

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

@end
