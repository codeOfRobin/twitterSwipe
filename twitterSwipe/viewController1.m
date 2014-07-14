//
//  viewController1.m
//  twitterSwipe
//
//  Created by Robin Malhotra on 12/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "viewController1.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define url [NSURL URLWithString:@"https://api.instagram.com/v1/tags/IITD/media/recent?access_token=426877925.1fb234f.8d01690752db44a3bcea16e8f540a2c6"]
@interface viewController1 ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation viewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageURLs=[[NSMutableArray alloc]init];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        url];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* data = [json objectForKey:@"data"];
    
    for (NSDictionary *dataObject in data)
    {
        NSDictionary *imagesDict=[dataObject objectForKey:@"images"];
        NSDictionary *lowResImage=[imagesDict objectForKey:@"low_resolution"];
        NSString *urlOfImage=[lowResImage objectForKey:@"url"];
        [self.imageURLs addObject:urlOfImage];
    }
    //2
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.imageURLs count]>0)
    {
        AsyncImageView *imgView=(AsyncImageView *)[cell viewWithTag:1];
        NSString *arr =[self.imageURLs objectAtIndex:indexPath.row];
        imgView.activityIndicatorStyle=UIActivityIndicatorViewStyleWhiteLarge;
        imgView.crossfadeDuration=0.5;
        imgView.imageURL=[NSURL URLWithString:arr];
        NSLog(@"%@",imgView.image);

    }
       return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
