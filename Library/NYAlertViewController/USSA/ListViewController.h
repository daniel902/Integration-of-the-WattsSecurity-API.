//
//  ListViewController.h
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface ListViewController : INSBaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, MBProgressHUDDelegate,MFMailComposeViewControllerDelegate>
{
    NSTimer * timer;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *alphaView;

@property (weak, nonatomic) IBOutlet UIImageView *detailImgView;

@property (nonatomic, assign) CGFloat numberOfRows;

@property (nonatomic, retain) NSTimer *timer;

- (IBAction)pullDown:(id)sender;

- (IBAction)cancelClicked:(id)sender;

- (IBAction)nextClicked:(id)sender;

- (IBAction)click:(id)sender;
@end
