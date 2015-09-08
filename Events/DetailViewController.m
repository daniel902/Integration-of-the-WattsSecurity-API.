//
//  DetailViewController.m
//  Events
//
//  Created by Dragon on 9/8/15.
//  Copyright (c) 2015 Teknowledge Software. All rights reserved.
//

#import "DetailViewController.h"
#import "Header.h"

@interface DetailViewController()
{
    NSString *requestReply;
}
@end

@implementation DetailViewController

- (void) viewDidLoad{
    [super viewDidLoad];

    if (IS_IPHONE_5) {
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height+88);
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 700)];

}

- (void) viewWillAppear:(BOOL)animated{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Loading";
    HUD.dimBackground = YES;
    [self retriveData];
}

- (void) retriveData{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString * serverURL = @"https://wattssecurity.com/api/event";
    NSString * strURL = [NSString stringWithFormat:@"%@/%@", serverURL, [NSString stringWithFormat:@"%ld", (long)self.curIndex]];
    NSLog(@"%@", strURL);
    [request setURL:[NSURL URLWithString:strURL]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self JSONParse];
            });
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Loading Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
            [alert show];
        }
        
    }] resume];

}

- (void) JSONParse{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSDictionary *tempDict = [requestReply JSONValue];
    NSDictionary *dataDict = [tempDict objectForKey:@"data"];
    NSDictionary * eventDict = [dataDict objectForKey:@"events"];
    
    if (![eventDict count] == 0) {
        NSString * strImageURL = [eventDict objectForKey:@"image"];
        [self.imageView setImageWithURL:[NSURL URLWithString:strImageURL]];
        NSString * strContent = [eventDict objectForKey:@"content"];
        self.txtView.text = strContent;
        NSString * strTime = [eventDict objectForKey:@"create_date"];
        self.lblTime.text = strTime;
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You did not pass a valid identifier" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

@end
