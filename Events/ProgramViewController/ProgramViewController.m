//
//  ProgramViewController.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ProgramViewController.h"
#import "ProgramCustomCell.h"
#import "EventList.h"
#import "MyEventTickets.h"
#import "AboutViewController.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@interface ProgramViewController (){
    
    NSMutableArray *arrayEventList;
    NSString * requestReply;
    NSMutableArray * desArray;
    NSMutableArray * timeArray;
    NSMutableArray * urlArray;
    NSMutableArray * tabDict;
}

@end

@implementation ProgramViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    desArray = [[NSMutableArray alloc] init];
    timeArray = [[NSMutableArray alloc] init];
    urlArray = [[NSMutableArray alloc] init];
    tabDict = [[NSMutableArray alloc] init];

    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Loading";
    HUD.dimBackground = YES;
    
    [self retriveData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

//    [Utility afterDelay:0.01 withCompletion:^{
//        [DSBezelActivityView newActivityViewForView:self.view.window];
//        [self getEventListFromServer];
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) retriveData{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://wattssecurity.com/api/events"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self JSONParse];
            });
 
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Loading Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }] resume];
    
}

- (void) JSONParse{
    
    [desArray removeAllObjects];
    [timeArray removeAllObjects];
    [urlArray removeAllObjects];
    [tabDict removeAllObjects];
    
    NSMutableDictionary *tempDict = [requestReply JSONValue];
    NSMutableDictionary *strData = [tempDict objectForKey:@"data"];
    tabDict = [strData objectForKey:@"events"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView reloadData];
}


///**
// *  getEventListFromServer
// *
// *  @return This method will get events data from server and store all data in EventList modal class.
// */
//
//#pragma mark - Get All Event's from server
//-(void)getEventListFromServer
//{
//    NSDictionary *dictOfEventRequestParameter = [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id", nil];
//
//    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTS_METHOD", @"GETEVENTS_METHOD") parameters:dictOfEventRequestParameter key:@"" withCompletion:^(id response){
//        
//        [DSBezelActivityView removeViewAnimated:NO];
//        arrayEventList  =   [[NSMutableArray alloc] init];
//        
//        if ([response isKindOfClass:[NSArray class]]) {
//            if ([[[response objectAtIndex:0] allKeys] containsObject:@"status"]) {
//                if ([[[response objectAtIndex:0] objectForKey:@"status"] intValue] == 0) {
//                    [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
//                    gArrayEvents = [[NSMutableArray alloc] initWithArray:arrayEventList];
//                    [self.tableView reloadData];
//                    return ;
//                    
//                }
//            }
//            
//            NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"event_start_date"  ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
//            NSArray *sortedArrayEventList = [response sortedArrayUsingDescriptors:@[descriptor]];
//            
//            for (NSDictionary *dict in sortedArrayEventList) {
//                EventList *eventObj = [[EventList alloc] init];
//                eventObj.eventID                =   [NSNumber numberWithInt:[[dict objectForKey:@"event_id"] intValue]];
//                eventObj.eventName              =   [dict objectForKey:@"event_name"];
//                eventObj.eventImageURL          =   [dict objectForKey:@"event_image_url"];
//                eventObj.eventDescription       =   [dict objectForKey:@"event_content"];
//                
//                //12.15pm 4 June '14
//                eventObj.eventStartDateTime     =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_start_date"],[dict objectForKey:@"event_start_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"HH:mm a - dd MMM yyyy"];
//                
//                eventObj.eventEndDateTime       =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_end_date"],[dict objectForKey:@"event_end_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"HH:mm a - dd MMM yyyy"];
//                
//                eventObj.eventLocationName      =   [dict objectForKey:@"location_name"];
//                eventObj.eventLocationAddress   =   [dict objectForKey:@"location_address"];
//                eventObj.eventLocationTown      =   [dict objectForKey:@"location_town"];
//                eventObj.eventLocationState     =   [dict objectForKey:@"location_state"];
//                eventObj.eventLocationCountry   =   [dict objectForKey:@"location_country"];
//                eventObj.eventLocationLatitude  =   [NSNumber numberWithFloat:[[dict objectForKey:@"location_latitude"] floatValue]];
//                eventObj.eventLocationLongitude =   [NSNumber numberWithFloat:[[dict objectForKey:@"location_longitude"] floatValue]];
//                
//                if ([[dict objectForKey:@"ticket"] count]>0) {
//                    NSDictionary *dictOfTicket  =   [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"ticket"]];
//                    eventObj.eventTicketName            =   [dictOfTicket objectForKey:@"ticket_name"];
//                    eventObj.eventTicketDescription     =   [dictOfTicket objectForKey:@"ticket_description"];
//                    eventObj.eventTicketPrice           =   [dictOfTicket objectForKey:@"ticket_price"];
//                    eventObj.eventTicketStart           =   [dictOfTicket objectForKey:@"ticket_start"];
//                    eventObj.eventTicketEnd             =   [dictOfTicket objectForKey:@"ticket_end"];
//                    eventObj.eventTicketMembers         =   [dictOfTicket objectForKey:@"ticket_members_roles"];
//                    eventObj.eventTicketGuests          =   [dictOfTicket objectForKey:@"ticket_guests"];
//                    eventObj.eventTicketRequired        =   [dictOfTicket objectForKey:@"ticket_required"];
//                    eventObj.eventTicketAvailSpaces     =   [NSNumber numberWithInt:[[dictOfTicket objectForKey:@"avail_spaces"] intValue]];
//                    eventObj.eventTicketBookedSpaces    =   [NSNumber numberWithInt:[[dictOfTicket objectForKey:@"booked_spaces"] intValue]];
//                    eventObj.eventTicketTotalSpaces     =   [NSNumber numberWithInt:[[dictOfTicket objectForKey:@"total_spaces"] intValue]];
//                }
//                
//                [arrayEventList addObject:eventObj];
//            }
//        }
//        
//        /**
//         *  global array for events data.
//         */
//        gArrayEvents = [[NSMutableArray alloc] initWithArray:arrayEventList];
//        
//        [self.tableView reloadData];
//        
//    }WithFailure:^(NSString *error)
//     {
//         [DSBezelActivityView removeViewAnimated:NO];
//         NSLog(@"%@",error);
//     }];
//}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//     return [arrayEventList count];
    return [tabDict count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgramCustomCell";
    ProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    EventList *obj = [arrayEventList objectAtIndex:indexPath.row];

//    cell.lblDateTime.text   =   [Utility compareDates:obj.eventStartDateTime date:[NSDate date]];
//    cell.lblEventName.text  =   obj.eventName;
//    cell.lblEventDesc.text  =   [obj.eventDescription stringByConvertingHTMLToPlainText];
//    cell.lblEventDesc.text  =   [Utility TrimString:cell.lblEventDesc.text];
//    
//    if ([obj.eventImageURL length]>0) {
//        [cell.imgEventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.eventImageURL]] placeholderImage:nil];
//        [cell.imgEventImage setContentMode:UIViewContentModeScaleAspectFit];
//        [cell.imgEventImage setClipsToBounds:YES];
//    }
//    
    
    [cell.image setImageWithURL:[NSURL URLWithString:[[tabDict objectAtIndex:indexPath.row] objectForKey:@"image"]]];
    cell.lblDescription.text = [[tabDict objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.lblTime.text = [[tabDict objectAtIndex:indexPath.row] objectForKey:@"create_date"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    VC.curIndex = indexPath.row;
    [self.navigationController pushViewController:VC animated:YES];
    NSLog(@"Clicked");
}

//#pragma mark - Navigation
//// In a story board-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
//    AboutViewController *aboutVwController = [segue destinationViewController];
//    EventList *obj  =   [arrayEventList objectAtIndex:selectedRowIndex.row];
//    
//    aboutVwController.eventObj  =   obj;
//}

@end