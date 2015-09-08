//
//  EventViewController.m
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController()
{
    NSMutableArray *dataSource;
    NSMutableArray *selectedSource;
    BOOL checkStatus;
    NSString * flag;
}
@end

@implementation EventViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.strACTST isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"other"]) {
        [self.chooseSubView setHidden:NO];
        [self.checkSubView setHidden:YES];
    }else if([appDelegate.strACTST isEqualToString:@"Yes"] && [appDelegate.strOption isEqualToString:@"army"]){
        [self.chooseSubView setHidden:YES];
        [self.checkSubView setHidden:NO];
    }else if ([appDelegate.strACTST isEqualToString:@"Yes"] && [appDelegate.strOption isEqualToString:@"other"]){
        [self.bothSubView setHidden:NO];
    }
    
    dataSource = [[NSMutableArray alloc] initWithObjects:@"Entering the Military", @"Commissioning", @"Permanent Change of Duty Station (PCS)", @"Deployment (Active-duty only)", @"Mobilization (Reservists only)", @"Leaving the Military", @"Military Retirement", @"Moving", nil];
    selectedSource = [[NSMutableArray alloc] init];
    
    self.btnCheck.layer.borderWidth = 1;
    self.btnCheck.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnCheck.layer.cornerRadius = 5;
    
    self.btnCheck1.layer.borderWidth = 1;
    self.btnCheck1.layer.borderColor = [[UIColor blackColor] CGColor];
    self.btnCheck1.layer.cornerRadius = 5;

    checkStatus = YES;
    flag = @"YES";
}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClicked:(id)sender {
//    if ([self.btnSelect.titleLabel.text isEqualToString:@"Select"]) {
//        [self customAlertShow];
//    }else{
        ListViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
        [self.navigationController pushViewController:VC animated:YES];
//    }
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
    SHMultipleSelect *multipleSelect = [[SHMultipleSelect alloc] init];
    multipleSelect.delegate = self;
    multipleSelect.rowsCount = dataSource.count;
    [multipleSelect show];
    
    if ([flag isEqualToString:@"NO"]) {
        self.lblFirst.text = @"";
        self.lblSecond.text = @"";
        self.lblThird.text = @"";
        self.lblFourth.text = @"";
        self.lblFifth.text = @"";
        self.lblSixth.text = @"";
        self.lblSeventh.text = @"";
        self.lblEigth.text = @"";
    }else if ([flag isEqualToString:@"YES"]){
        self.lblFirst2.text = @"";
        self.lblSecond2.text = @"";
        self.lblThird2.text = @"";
        self.lblFourth2.text = @"";
        self.lblFifth2.text = @"";
        self.lblSixth2.text = @"";
        self.lblSeventh2.text = @"";
        self.lblEigth2.text = @"";
    }
}

- (IBAction)btnCheckClicked:(id)sender {
    if (checkStatus == YES) {
        [self.btnCheck setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        checkStatus = NO;
    }else{
        [self.btnCheck setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        checkStatus = YES;
        
    }
}

- (IBAction)btnCheck1Clicked:(id)sender {
    if (checkStatus == YES) {
        [self.btnCheck1 setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        checkStatus = NO;
    }else{
        [self.btnCheck1 setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        checkStatus = YES;
        
    }
}

#pragma mark - SHMultipleSelectDelegate
- (void)multipleSelectView:(SHMultipleSelect*)multipleSelectView clickedBtnAtIndex:(NSInteger)clickedBtnIndex withSelectedIndexPaths:(NSArray *)selectedIndexPaths {
    [selectedSource removeAllObjects];
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (clickedBtnIndex == 1) { // Done btn
        for (NSIndexPath *indexPath in selectedIndexPaths) {
            NSLog(@"%@", dataSource[indexPath.row]);
            [selectedSource addObject:dataSource[indexPath.row]];
        }
        NSLog(@"%@", selectedSource);
        for (int i = 0 ; i < [selectedSource count]; i++) {
            if ([appDelegate.strACTST isEqualToString:@"No"] && [appDelegate.strOption isEqualToString:@"other"]) {
                if (i == 0) {
                    self.lblFirst.text = [selectedSource objectAtIndex:0];
                }else if (i == 1){
                    self.lblSecond.text = [selectedSource objectAtIndex:1];
                }else if (i == 2){
                    self.lblThird.text = [selectedSource objectAtIndex:2];
                }else if (i == 3){
                    self.lblFourth.text = [selectedSource objectAtIndex:3];
                }else if (i == 4){
                    self.lblFifth.text = [selectedSource objectAtIndex:4];
                }else if (i == 5){
                    self.lblSixth.text = [selectedSource objectAtIndex:5];
                }else if (i == 6){
                    self.lblSeventh.text = [selectedSource objectAtIndex:6];
                }else if (i == 7){
                    self.lblEigth.text = [selectedSource objectAtIndex:7];
                }
            }else if([appDelegate.strACTST isEqualToString:@"Yes"] && [appDelegate.strOption isEqualToString:@"other"]){
                if (i == 0) {
                    self.lblFirst2.text = [selectedSource objectAtIndex:0];
                }else if (i == 1){
                    self.lblSecond2.text = [selectedSource objectAtIndex:1];
                }else if (i == 2){
                    self.lblThird2.text = [selectedSource objectAtIndex:2];
                }else if (i == 3){
                    self.lblFourth2.text = [selectedSource objectAtIndex:3];
                }else if (i == 4){
                    self.lblFifth2.text = [selectedSource objectAtIndex:4];
                }else if (i == 5){
                    self.lblSixth2.text = [selectedSource objectAtIndex:5];
                }else if (i == 6){
                    self.lblSeventh2.text = [selectedSource objectAtIndex:6];
                }else if (i == 7){
                    self.lblEigth2.text = [selectedSource objectAtIndex:7];
                }
            }
        }
    }
}

- (NSString*)multipleSelectView:(SHMultipleSelect*)multipleSelectView titleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return dataSource[indexPath.row];
}

- (BOOL)multipleSelectView:(SHMultipleSelect*)multipleSelectView setSelectedForRowAtIndexPath:(NSIndexPath*)indexPath {
    BOOL canSelect = NO;
    if (indexPath.row == dataSource.count - 1) { // last object
        canSelect = YES;
    }
    return canSelect;
}

@end
