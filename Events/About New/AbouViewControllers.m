//
//  AbouViewControllers.m
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "AbouViewControllers.h"
#import "Header.h"

@interface AbouViewControllers ()
{
    NSString *requestReply;
}

@end

@implementation AbouViewControllers
@synthesize scrlVW;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.scrlVW.frame = CGRectMake(self.scrlVW.frame.origin.x, self.scrlVW.frame.origin.y, self.scrlVW.frame.size.width, self.scrlVW.frame.size.height+88);
    }
    [self.scrlVW setContentSize:CGSizeMake(self.scrlVW.frame.size.width, 500)];
}

- (void) viewWillAppear:(BOOL)animated{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Loading";
    HUD.dimBackground = YES;
    [self retriveData];
}

- (void) retriveData{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://wattssecurity.com/api/about"]];
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
    NSDictionary * viewDict = [dataDict objectForKey:@"view"];

//    NSString * strImageURL = [strData objectForKey:@"image"];
//    [self.imgView setImageWithURL:[NSURL URLWithString:strImageURL]];
    NSString * strContent = [viewDict objectForKey:@"content"];
    txtVWContent.text = strContent;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
