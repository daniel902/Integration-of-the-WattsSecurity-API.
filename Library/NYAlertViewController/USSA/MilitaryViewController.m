//
//  MilitaryViewController.m
//  USSA
//
//  Created by Dragon on 8/27/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "MilitaryViewController.h"
#import "Public.h"

@interface MilitaryViewController()
{
    NSUserDefaults * userDefaults;
}

@end

@implementation MilitaryViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFirstView) name:@"firstEvent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSecondView) name:@"secondEvent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showThirdView) name:@"thirdEvent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showfourthView) name:@"fourthEvent" object:nil];
    
    userDefaults = [NSUserDefaults standardUserDefaults];

}

- (void) showFirstView{
    [self.firstSubView setHidden:NO];
    [self.secondSubView setHidden:YES];
    [self.thirdSubView setHidden:YES];
    [self.fourthSubView setHidden:YES];
}

- (void) showSecondView{
    [self.firstSubView setHidden:YES];
    [self.secondSubView setHidden:NO];
    [self.thirdSubView setHidden:YES];
    [self.fourthSubView setHidden:YES];
}

- (void) showThirdView{
    [self.firstSubView setHidden:YES];
    [self.secondSubView setHidden:YES];
    [self.thirdSubView setHidden:NO];
    [self.fourthSubView setHidden:YES];
}

- (void) showfourthView{
    [self.firstSubView setHidden:YES];
    [self.secondSubView setHidden:YES];
    [self.thirdSubView setHidden:YES];
    [self.fourthSubView setHidden:NO];
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload {
    self.btnMilitaryStatus = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Active Duty", @"Drilling for Pay", @"Commissioning", @"Retired", @"Separated", @"Never Served", nil];
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

- (IBAction)nextClicked:(id)sender {
    
    self.strStatus = self.btnMilitaryStatus.titleLabel.text;
    
    if ([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Select"]) {
        [self customAlertShow];
        return;
        
    }else if(([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Active Duty"] || [self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Drilling for Pay"] || [self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Commissioning"] ) && [self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Select"]){
        [self customAlertShow];
        return;
        
    }else if(([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Retired"])&& ([self.btnRetireYear.titleLabel.text isEqualToString:@"Year"] || [self.btnRetireMonth.titleLabel.text isEqualToString:@"Month"] || [self.btn2Select.titleLabel.text isEqualToString:@"Select"])){
        [self customAlertShow];
        return;
        
    }else if([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Separated"] && ([self.btnSeparateYear.titleLabel.text isEqualToString:@"Year"] || [self.btnSeparateMonth.titleLabel.text isEqualToString:@"Month"] || [self.btnComponent.titleLabel.text isEqualToString:@"Select"] || [self.btnDischarge.titleLabel.text isEqualToString:@"Select"])){
        [self customAlertShow];
        return;

    }else if([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Never Served"] && (![self.btnServe.titleLabel.text isEqualToString:@"Select"])){
        ListViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
        [self.navigationController pushViewController:VC animated:YES];        
        
    }else{
        if ([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Active Duty"] || [self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Drilling for Pay"] || [self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Commissioning"]) {
            [userDefaults setObject:@"Pre-Commission" forKey:@"served_service"];
            [userDefaults synchronize];
        }else if([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Retired"]){
            [userDefaults setObject:@"Retired" forKey:@"served_service"];
            [userDefaults setObject:self.btnRetireYear.titleLabel.text forKey:@"retired_year"];
            [userDefaults setObject:self.btnRetireMonth.titleLabel.text forKey:@"retired_month"];

            [userDefaults synchronize];
        }else if([self.btnMilitaryStatus.titleLabel.text isEqualToString:@"Separated"]){
            [userDefaults setObject:@"Separated" forKey:@"served_service"];
            [userDefaults setObject:self.btnSeparateYear.titleLabel.text forKey:@"separated_year"];
            [userDefaults setObject:self.btnSeparateMonth forKey:@"separated_month"];
            [userDefaults setObject:self.btnDischarge.titleLabel.text forKey:@"separated_honor"];

            [userDefaults synchronize];
        }
        RankViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"RankViewController"];
        [self.navigationController pushViewController:VC animated:YES];
        
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

- (IBAction)select1Clicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"National Guard", @"Active", @"Reserve", nil];
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

- (IBAction)btnSelect1Clicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Yes", @"No", nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 80;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"up"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

}

- (IBAction)btnServeClicked:(id)sender {
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

- (IBAction)btn2SelectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"National Guard", @"Active", @"Reserve", nil];
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

#pragma mark - NIDropDown Delegate Method.

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}


@end
