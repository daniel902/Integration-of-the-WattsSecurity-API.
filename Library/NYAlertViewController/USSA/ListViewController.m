//
//  ListViewController.m
//  USSA
//
//  Created by Dragon on 8/28/15.
//  Copyright (c) 2015 Dragon. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController()
{
    NSMutableArray * dataArray;
    NSMutableArray * newArray;
    NSURL * curURL;
    NSString * lastUpdateTime, * tempStr, *strMessage, * string, * accessType;
    AppDelegate * appDelegate;
    NSUserDefaults *userDefaults;
    UIScrollView *scrView;
    NSInteger lastUpdate, tempUpdate;
}

@end

@implementation ListViewController

@synthesize timer;

- (void) viewDidLoad{
    [super viewDidLoad];
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Downloading";
    HUD.dimBackground = YES;
    
    dataArray = [[NSMutableArray alloc] init];
    newArray = [[NSMutableArray alloc] init];

    if (![[GlobalModel sharedManager] CheckInternetConnectivity]) {
        string = @"Network Error";
        [self customAlertShow];
        return;
    }else{
        [self pullDownImage:1];

    }
    
    [self customCollectionView];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    accessType = @"";
}

- (void) viewDidDisappear:(BOOL)animated{
    [timer invalidate];
    timer = nil;
}

- (void) customCollectionView{
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    
    self.numberOfRows = 15;
    
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.collectionView.contentInset = UIEdgeInsetsMake(100.0f, 0.0f, 100.0f, 0.0f);
    }
    
    [self.collectionView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [scrollView ins_endPullToRefresh];
            
        });
    }];
    
    self.collectionView.ins_pullToRefreshBackgroundView.preserveContentInset = NO;
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.collectionView.ins_pullToRefreshBackgroundView.preserveContentInset = YES;
    }
    
    if (self.style == INSPullToRefreshStyleText) {
        self.collectionView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    }
    
    __weak typeof(self) weakSelf = self;

    [self.collectionView ins_addInfinityScrollWithHeight:60 handler:^(UIScrollView *scrollView) {
    
        scrView = scrollView;

        if([dataArray count] > 0 || [dataArray count] % 20 == 0)
        {
            NSInteger pageIndex = ([dataArray count] ) / 20 + 1;
            NSLog(@"Page Index : %ld", (long)pageIndex);
            [weakSelf pullDownImage:pageIndex];
        }
    }];
    
    UIView <INSAnimatable> *infinityIndicator = [self infinityIndicatorViewFromCurrentStyle];
    [self.collectionView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
    [infinityIndicator startAnimating];
    
    self.collectionView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
    if (self.style == INSPullToRefreshStylePreserveContentInset) {
        self.collectionView.ins_infiniteScrollBackgroundView.preserveContentInset = YES;
    }
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [self pullToRefreshViewFromCurrentStyle];
    self.collectionView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.collectionView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
    
    if (self.style == INSPullToRefreshStyleText) {
        pullToRefresh.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        pullToRefresh.translatesAutoresizingMaskIntoConstraints = YES;
        pullToRefresh.frame = self.collectionView.ins_pullToRefreshBackgroundView.bounds;
        
    }

}

- (void) addMoreCells{
    
    [scrView ins_endInfinityScroll];
    [self.collectionView reloadData];
}

- (void) pullDownImage:(NSInteger) pageIndex
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mvp-interactive.com/api-usaa/"]]];
    [request setPostValue:@"photoslist_part" forKey:@"command"];
    [request setPostValue:[NSString stringWithFormat:@"%d", pageIndex] forKey:@"part"];
    
    [request addRequestHeader:@"Authorization" value:@"Basic bXZwaW50OmRldnRlMTkyMTA="];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    [request setDelegate:self];
    [request setTimeOutSeconds:30.0];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];

}


#pragma mark - ASIHTTPRequest Delegate

- (void)requestFinished:(ASIHTTPRequest *)request
{

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *str = [request responseString];
    NSMutableDictionary *dictjson = [str JSONValue];
    
    lastUpdateTime = [dictjson objectForKey:@"lastupdate"];
    
    if ([accessType isEqualToString:@"refresh"]) {
        
        newArray = [dictjson objectForKey:@"data"];
        if ([newArray count] == 0) {
            string = @"No Update";
            [self customAlertShow];
        }else{
            NSLog(@"Update");
            [newArray addObjectsFromArray:dataArray];
            dataArray = newArray;
            NSLog(@"%@", dataArray);
            [self.collectionView reloadData];
        }
        return;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[dictjson objectForKey:@"data"]];
    [dataArray addObjectsFromArray:array];
    
    if ([dataArray count] == 0) {
        string = @"No Image";
        [self customAlertShow];
        return;
    }
    
    if([dataArray count] > 20)
        [self addMoreCells];

    if([array count] < 20)
        [self.collectionView ins_removeInfinityScroll];
    
    [scrView ins_endInfinityScroll];
    
    [userDefaults setObject:dataArray forKey:@"urlArray"];
    [userDefaults synchronize];

    [self.collectionView reloadData];
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void) customAlertShow{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    if ([string isEqualToString:@"No Image"]) {
        strMessage = @"There is no image on server";
    }else if ([string isEqualToString:@"No Update"]){
        strMessage = @"There is no new image on Server";
    }else if([string isEqualToString:@"Network Error"]){
        strMessage = @"The connection appears to be offline. Please Connect and try again.";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    alertViewController.message = NSLocalizedString(strMessage, nil);
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.933f green:0.671f blue:0.035f alpha:1.0f];
    alertViewController.messageColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.933f green:0.671f blue:0.035f alpha:1.0f];
    alertViewController.buttonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    CustomCollectionViewCell * cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.imageView setShowActivityIndicatorView:YES];
    [cell.imageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[dataArray objectAtIndex:indexPath.row]]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.imageView.layer.cornerRadius = 10;
    
    return cell;
}

#pragma mark - UICollectionView Delegate 
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EnPopUpViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopUp"];
    vc.view.frame = CGRectMake(0, 0, 400.0f, 500.0f);
    [vc.imageView sd_setImageWithURL:[NSURL URLWithString:[dataArray objectAtIndex:indexPath.row]]
                                                                           placeholderImage:[UIImage imageNamed:@"placeholder"]];
    vc.strCurURL = [dataArray objectAtIndex:indexPath.row];
    [self presentPopUpViewController:vc];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.style == INSPullToRefreshStyleText) {
        if (scrollView.contentOffset.y <= -200) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -200);
        }
    }
}

#pragma mark - Execution code

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

- (IBAction)pullDown:(id)sender {
   
    if (![[GlobalModel sharedManager] CheckInternetConnectivity]) {
        string = @"Network Error";
        [self customAlertShow];
        return;
    }else{
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"Downloading";
        HUD.dimBackground = YES;

    }
    
    accessType = @"refresh";
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(runScheduledTask) userInfo:nil repeats:YES];

}

- (void)runScheduledTask {
    
    tempUpdate = [lastUpdateTime integerValue];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dev.mvp-interactive.com/api-usaa/"]]];
    [request setPostValue:@"new_photos" forKey:@"command"];
    NSLog(@"%ld", (long)tempUpdate);
    [request setPostValue:[NSString stringWithFormat:@"%ld", (long)tempUpdate] forKey:@"newerthan"];
    [request addRequestHeader:@"Authorization" value:@"Basic bXZwaW50OmRldnRlMTkyMTA="];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request setTimeOutSeconds:30.0];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];

}

- (IBAction)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClicked:(id)sender {
    
}

- (IBAction)click:(id)sender {
    [timer invalidate];
    timer = nil;
}

- (void)pullToRefreshBackgroundView:(INSPullToRefreshBackgroundView *)pullToRefreshBackgroundView didChangeState:(INSPullToRefreshBackgroundViewState)state
{
    NSLog(@"pulled");
}

@end
