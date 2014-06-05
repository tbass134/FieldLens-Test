//
//  MasterViewController.h
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "MBProgressHUD.h"

@class DetailViewController;
@interface MasterViewController : UITableViewController
@property(nonatomic,strong)NSArray *movies;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
