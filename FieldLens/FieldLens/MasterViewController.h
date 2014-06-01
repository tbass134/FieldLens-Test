//
//  MasterViewController.h
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)NSArray *movies;
@property(nonatomic,strong)NSDictionary *images;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
