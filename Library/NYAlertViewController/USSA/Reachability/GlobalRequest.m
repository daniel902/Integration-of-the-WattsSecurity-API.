//
//  GlobalRequest.m
//  Firsty
//
//  Created by Yuan on 15/2/13.
//  Copyright (c) 2015 Kick Labs Co. All rights reserved.
//

#import "GlobalRequest.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "GlobalModel.h"

@interface GlobalRequest() {
    AppDelegate *delegate;
}

@property (nonatomic, strong) NSArray *placeArray;

@end

@implementation GlobalRequest

@synthesize placeArray;

-(void)parseGetAllPlaceListWithBlock:(ArrayResultBlock)block{
    delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSMutableArray *resultArray = [NSMutableArray new];
    
    //Get User current location
    [delegate updateCurrentLocation];
    CLLocation *myLocation = [delegate getCurrentLocation];
    NSString *str_lat = [NSString stringWithFormat:@"%f", myLocation.coordinate.latitude];
    NSString *str_lng = [NSString stringWithFormat:@"%f", myLocation.coordinate.longitude];
    
    //Update in DB user current location
    PFUser *user = [PFUser currentUser];
    user[@"Latitude"] = str_lat;
    user[@"Longitude"] = str_lng;
    [user saveInBackground];
    
    //Find All places from DB
    PFQuery *query = [PFQuery queryWithClassName:@"Places"]; //1
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            self.placeArray = nil;
            self.placeArray = [[NSArray alloc] initWithArray:objects];
            
            if([self.placeArray count]>0){
                for (int i=0; i<self.placeArray.count; i++) {
                    //Get Distance between user's current location and place location
                    float Distance=     [self getDistance:str_lat andCurrentLongitude:str_lng andLat:[[self.placeArray objectAtIndex:i]valueForKey:@"Latitude"] Lng:[[self.placeArray objectAtIndex:i]valueForKey:@"Longitude"]];
                    
                    NSArray *componentArray = [[[self.placeArray objectAtIndex:i]valueForKey:@"openingTime"] componentsSeparatedByString:@":"];
                    NSArray *componentArray1 = [[[self.placeArray objectAtIndex:i]valueForKey:@"closingTime"] componentsSeparatedByString:@":"];
                    
                    NSString *str_Status=   [self getRightTime:[componentArray objectAtIndex:0] andClosetime:[componentArray1 objectAtIndex:0]];
                    
                    //Filter nearby places
                    // if (Distance<5000) {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    
                    NSData *imageData = [[[self.placeArray objectAtIndex:i] valueForKey:@"PlaceLogo"] getData];
                    if (imageData == nil) {
                        imageData = UIImagePNGRepresentation([UIImage imageNamed:@"placePlaceholder@2x"]);
                    }
                    [dict setValue:imageData forKey:@"PlaceLogo"];
                    NSData *backgroundData = [[[self.placeArray objectAtIndex:i] valueForKey:@"backgroundFile"] getData];
                    [dict setValue:backgroundData forKey:@"BackgroundFile"];
                    [dict setValue:[[self.placeArray objectAtIndex:i] valueForKey:@"Name"] forKey:@"Name"];
                    [dict setValue:[[self.placeArray objectAtIndex:i] valueForKey:@"CityOfPlace"] forKey:@"Address"];
                    [dict setValue:[NSString stringWithFormat:@"%.2f",Distance] forKey:@"Distance"];
                    [dict setValue:[NSString stringWithFormat:@"%@",str_Status] forKey:@"Status"];
                    [resultArray addObject:dict];
                    // }
                }
            }
        }
        block(resultArray, error);
    }];
}

-(void)parseGetLoginUser:(StringResultBlock)block {
    PFUser *user = [PFUser currentUser];
    if (user) {
        block(user.username, nil);
    } else {
        block(nil, nil);
    }
}

-(float)getDistance:(NSString*)CLat andCurrentLongitude:(NSString*)CLng andLat:(NSString*)lat2 Lng:(NSString*)long2{
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[CLat floatValue] longitude:[CLng floatValue]];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:[lat2 floatValue] longitude:[long2 floatValue]];
    NSLog(@"Distance in meters: %f", [location1 distanceFromLocation:location2]);
    
    float myInt = (float)[location1 distanceFromLocation:location2];
    return myInt;
    
    
}

-(NSString*)getRightTime:(NSString*)open andClosetime:(NSString*)close{
    
    // For calculating the current date
    NSDate *date = [NSDate date];
    
    // Make Date Formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh a"];
    
    // hh for hour mm for minutes and a will show you AM or PM
    [dateFormatter setLocale:[NSLocale systemLocale]];
    
    NSString *str = [dateFormatter stringFromDate:date];
    NSLog(@"%@", str);
    
    // Seperate str by space i.e. you will get time and AM/PM at index 0 and 1 respectively
    NSArray *array = [str componentsSeparatedByString:@" "];
    
    // Now you can check it by 12. If < 12 means Its morning > 12 means its evening or night
    NSString * timeInHour = array[0];
    NSString * am_pm      = array[1];
    
    if([timeInHour integerValue] < 12 && [am_pm isEqualToString:@"AM"])
    {
        if([timeInHour integerValue] < [open integerValue]){
            return @"Close";
        }
        else{
            return @"Open";
        }
        
    }
    else if ([timeInHour integerValue] <= 12 && [am_pm isEqualToString:@"PM"])
    {
        if([timeInHour integerValue]+12 < [close integerValue]){
            return @"Open";
        }
        else{
            return @"Close";
        }
        
    }
    else
    {
        
        return @"Close";
        
    }
    
}

@end
