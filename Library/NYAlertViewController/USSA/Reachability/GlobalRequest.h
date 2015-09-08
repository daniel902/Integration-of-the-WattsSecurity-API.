//
//  GlobalRequest.h
//  Firsty
//
//  Created by Yuan on 15/2/13.
//  Copyright (c) 2015 Kick Labs Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalRequest : NSObject
typedef void (^ArrayResultBlock)(NSArray *array, NSError *error);
typedef void (^StringResultBlock)(NSString *string, NSError *error);
-(void)parseGetAllPlaceListWithBlock:(ArrayResultBlock)block;
-(void)parseGetLoginUser:(StringResultBlock)block;
@end
