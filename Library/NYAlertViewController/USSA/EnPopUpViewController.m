//
//  EnPopUpViewController.m
//  USSA
//
//  Created by Dragon on 8/31/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "EnPopUpViewController.h"
#import "Public.h"

@interface EnPopUpViewController()
{
    NSUserDefaults *userDefaults;
    NSMutableDictionary * dataDict;
    NSString * flag;
    AppDelegate * appDelegate;
}

@end

@implementation EnPopUpViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToThanks) name:@"mailSent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToList) name:@"mailCancel" object:nil];

    userDefaults = [NSUserDefaults standardUserDefaults];
    dataDict = [[NSMutableDictionary alloc] init];
    flag = @"Yes";
    appDelegate = [[UIApplication sharedApplication]delegate];

}

- (void) goToThanks{
    appDelegate.imageURL = [NSURL URLWithString:self.strCurURL];
    [self dismissPopUpViewController];
    ThanksViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThanksViewController"];
//    VC.imageURL = self.strCurURL;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void) goToList{
    [self dismissPopUpViewController];
}

- (IBAction)btnSendClicked:(id)sender {

    if (![[GlobalModel sharedManager] CheckInternetConnectivity]) {
        [self customAlertShow];
        return;
    }else{
        flag = @"No";
        
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.imageView animated:YES];
        HUD.labelText = @"Uploading";
        HUD.dimBackground = YES;
        
        
        NSString * strPrev = [userDefaults objectForKey:@"prevaccount"];
        NSString * strFirstName = [userDefaults objectForKey:@"firstname"];
        NSString * strLastName = [userDefaults objectForKey:@"lastname"];
        NSString * strTitle = [userDefaults objectForKey:@"title"];
        NSString * strEmail = [userDefaults objectForKey:@"email"];
        NSString * strPhoneNumber = [userDefaults objectForKey:@"phone"];
        NSString * strBirthYear = [userDefaults objectForKey:@"birthday_year"];
        NSString * strBirthMonth = [userDefaults objectForKey:@"birthday_month"];
        NSString * strBirthDay = [userDefaults objectForKey:@"birthday_day"];
        NSString * strServe = [userDefaults objectForKey:@"served"];
        NSString * strBranch = [userDefaults objectForKey:@"served_branch"];
        NSString * strRank = [userDefaults objectForKey:@"served_rank"];
        NSString * strService = [userDefaults objectForKey:@"served_service"];
        NSString * strEnlistYear = [userDefaults objectForKey:@"enlist_year"];
        if (strEnlistYear == nil) {
            strEnlistYear = @"";
        }
        NSString * strEnlistMonth = [userDefaults objectForKey:@"enlist_month"];
        if (strEnlistMonth == nil) {
            strEnlistMonth = @"";
        }
        NSString * strRetireYear = [userDefaults objectForKey:@"retired_year"];
        if (strRetireYear == nil) {
            strRetireYear = @"";
        }
        NSString * strRetireMonth = [userDefaults objectForKey:@"retired_month"];
        if (strRetireMonth == nil) {
            strRetireMonth = @"";
        }
        NSString * strSeperateYear = [userDefaults objectForKey:@"separated_year"];
        if (strSeperateYear == nil) {
            strSeperateYear = @"";
        }
        NSString * strSepearateMonth = [userDefaults objectForKey:@"separated_month"];
        if (strSepearateMonth == nil) {
            strSepearateMonth = @"";
        }
        NSString * strSeperateHonor = [userDefaults objectForKey:@"separated_honor"];
        if (strSeperateHonor == nil) {
            strSeperateHonor = @"";
        }
        NSString * strComYear = [userDefaults objectForKey:@"comm_year"];
        if (strComYear == nil) {
            strComYear = @"";
        }
        NSString * strComMonth = [userDefaults objectForKey:@"comm_month"];
        if (strComMonth == nil) {
            strComMonth = @"";
        }
        NSString * strComSource = [userDefaults objectForKey:@"comm_source"];
        if (strComSource == nil) {
            strComSource = @"";
        }
        NSString * strPhotoUrl = self.strCurURL;
        [userDefaults setObject:strPhotoUrl forKey:@"selectedPhoto"];
        [userDefaults synchronize];
        
        [dataDict setObject:strPrev forKey:@"prevaccount"];
        [dataDict setObject:strFirstName forKey:@"firstname"];
        [dataDict setObject:strLastName forKey:@"lastname"];
        [dataDict setObject:strTitle forKey:@"title"];
        [dataDict setObject:strEmail forKey:@"email"];
        [dataDict setObject:strPhoneNumber forKey:@"phone"];
        [dataDict setObject:strBirthYear forKey:@"birthday_year"];
        [dataDict setObject:strBirthMonth forKey:@"birthday_month"];
        [dataDict setObject:strBirthDay forKey:@"birthday_day"];
        [dataDict setObject:strServe forKey:@"served"];
        [dataDict setObject:strBranch forKey:@"served_branch"];
        [dataDict setObject:strRank forKey:@"served_rank"];
        [dataDict setObject:strService forKey:@"served_service"];
        [dataDict setObject:strEnlistYear forKey:@"enlist_year"];
        [dataDict setObject:strEnlistMonth forKey:@"enlist_month"];
        [dataDict setObject:strRetireYear forKey:@"retired_year"];
        [dataDict setObject:strRetireMonth forKey:@"retired_month"];
        [dataDict setObject:strSeperateYear forKey:@"separated_year"];
        [dataDict setObject:strSepearateMonth forKey:@"separated_month"];
        [dataDict setObject:strSeperateHonor forKey:@"separated_honor"];
        [dataDict setObject:strComYear forKey:@"comm_year"];
        [dataDict setObject:strComMonth forKey:@"comm_month"];
        [dataDict setObject:strComSource forKey:@"comm_source"];
        [dataDict setObject:strPhotoUrl forKey:@"selectedphoto"];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mvp-interactive.com/api-usaa/"]]];
        [request setPostValue:@"saveall" forKey:@"command"];
        [request setPostValue:dataDict forKey:@"data"];
        [request addRequestHeader:@"Authorization" value:@"Basic bXZwaW50OmRldnRlMTkyMTA="];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        [request setDelegate:self];
        [request setTimeOutSeconds:30.0];
        [request setRequestMethod:@"POST"];
        [request startAsynchronous];
        
    }
}

- (void) customAlertShow{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    alertViewController.title = NSLocalizedString(@"Warning", nil);
    alertViewController.message = NSLocalizedString(@"The connection appears to be offline. Please Connect and try again.", nil);
    
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
    
    if ([flag isEqualToString:@"No"]) {
        
        appDelegate = [[UIApplication sharedApplication] delegate];
        NSString *messageBody = @"Please type here.";
        NSArray *toRecipents = [NSArray arrayWithObject:appDelegate.strEmail];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.strCurURL]];
        UIImage *pic = [UIImage imageWithData:imageData];
        NSData *exportData = UIImageJPEGRepresentation(pic ,1.0);
        [mc addAttachmentData:exportData mimeType:@"image/jpeg" fileName:@"Picture.jpeg"];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
    NSLog(@"Success");
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"Fail");
}



#pragma mark - MFMailComposeViewControllerDelegate

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"mailCancel" object:self];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"mailSent" object:self];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
