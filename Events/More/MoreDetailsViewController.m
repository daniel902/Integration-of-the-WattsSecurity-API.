//
//  MoreDetailsViewController.m
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "MoreDetailsViewController.h"
#import "Header.h"

@interface MoreDetailsViewController ()
{
    NSString *requestReply;

}
@end

@implementation MoreDetailsViewController

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
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Loading";
    HUD.dimBackground = YES;
    self.title = @"Details";
    [self retriveData];
    
}

- (void)viewDidLayoutSubviews
{
    if (IS_IPHONE_5) {
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height+88);
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 800)];

}

- (void) retriveData{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://wattssecurity.com/api/help"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self JSONParse];
        });
        
    }] resume];
    
}

- (void) JSONParse{
    
    NSDictionary *tempDict = [requestReply JSONValue];
    NSDictionary *dataDict = [tempDict objectForKey:@"data"];
    NSArray * viewDict = [dataDict objectForKey:@"view"];
    
    if ([self.strCondition isEqualToString:@"About"]) {
        NSDictionary * itemDict = [viewDict objectAtIndex:0];
//        NSString * strImageURL = [itemDict objectForKey:@"image"];
//        NSURL * imageURL = [NSURL URLWithString:strImageURL];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        [self.imageView setImageWithURL:imageURL];
        NSString * strContent = [itemDict objectForKey:@"content"];
        self.txtView.text = strContent;

    }else if ([self.strCondition isEqualToString:@"Help"]) {
        NSMutableDictionary * itemDict = [viewDict objectAtIndex:1];
//        NSString * strImageURL = [itemDict objectForKey:@"image"];
//        NSURL * imageURL = [NSURL URLWithString:strImageURL];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        [self.imageView setImageWithURL:imageURL];
        NSString * strContent = [itemDict objectForKey:@"content"];
        self.txtView.text = strContent;

    }else if ([self.strCondition isEqualToString:@"Privacy"]){
        NSMutableDictionary * itemDict = [viewDict objectAtIndex:2];
//        NSString * strImageURL = [itemDict objectForKey:@"image"];
//        NSURL * imageURL = [NSURL URLWithString:strImageURL];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        [self.imageView setImageWithURL:imageURL];
        NSString * strContent = [itemDict objectForKey:@"content"];
        self.txtView.text = strContent;

    }else if ([self.strCondition isEqualToString:@"Term"]){
        NSMutableDictionary * itemDict = [viewDict objectAtIndex:3];
//        NSString * strImageURL = [itemDict objectForKey:@"image"];
//        NSURL * imageURL = [NSURL URLWithString:strImageURL];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        [self.imageView setImageWithURL:imageURL];
        NSString * strContent = [itemDict objectForKey:@"content"];
        self.txtView.text = strContent;

    }else{
        NSMutableDictionary * itemDict = [viewDict objectAtIndex:4];
//        NSString * strImageURL = [itemDict objectForKey:@"image"];
//        NSURL * imageURL = [NSURL URLWithString:strImageURL];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        [self.imageView setImageWithURL:imageURL];
        NSString * strContent = [itemDict objectForKey:@"content"];
        self.txtView.text = strContent;

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
