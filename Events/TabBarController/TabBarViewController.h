//
//  TabBarViewController.h
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;

-(void)changeTab:(int)index;

@end
