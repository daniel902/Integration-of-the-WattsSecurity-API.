//
//  ThanksViewController.h
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThanksViewController : UIViewController

@property (nonatomic, strong) NSString * imageURL;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

- (IBAction)cancelClicked:(id)sender;

@end
