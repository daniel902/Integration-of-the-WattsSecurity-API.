//
//  DetailViewController.h
//  Events
//
//  Created by Dragon on 9/8/15.
//  Copyright (c) 2015 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (nonatomic, assign) NSInteger curIndex;

@property (weak, nonatomic) IBOutlet UITextView *txtView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
