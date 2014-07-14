//
//  viewController1.h
//  twitterSwipe
//
//  Created by Robin Malhotra on 12/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "MSPageViewControllerPage.h"
#import "AsyncImageView.h"

@interface viewController1 : MSPageViewControllerPage<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *imageURLs;
@end
