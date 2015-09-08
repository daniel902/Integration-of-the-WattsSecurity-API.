//
//  GlobalModel.m
//  Firsty
//
//  Created by Hyacinthe Hamon on 10/11/2014.
//  Copyright (c) 2015 Kick Labs Co. All rights reserved.
//

#import "GlobalModel.h"

@implementation GlobalModel


+ (GlobalModel *)sharedManager{
    
    
    static GlobalModel *sharedManager = nil;
    
    if (sharedManager == nil)
    {   
        sharedManager = [[[self class] alloc] init];
        
    }
    return sharedManager;
}


//Check InternetContectivity
-(BOOL)CheckInternetConnectivity{
    //return isReachable;
    
    Reachability* reachability;
    reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
        return FALSE;
    else
        return TRUE;
    return FALSE;
    
}

@end
