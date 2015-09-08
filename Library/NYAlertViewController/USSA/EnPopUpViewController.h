//
//  EnPopUpViewController.h
//  USSA
//
//  Created by Dragon on 8/31/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface EnPopUpViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)btnSendClicked:(id)sender;

@property (nonatomic, strong) NSString * strCurURL;

@property (nonatomic, strong) NSURL * imageURL;

@end
