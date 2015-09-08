//
//  GlobalModel.h
//  Firsty
//
//  Created by Hyacinthe Hamon on 10/11/2014.
//  Copyright (c) 2015 Kick Labs Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"



@interface GlobalModel : NSObject


+ (GlobalModel *)sharedManager;

- (BOOL)CheckInternetConnectivity;


@end
