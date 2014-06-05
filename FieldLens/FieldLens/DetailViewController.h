//
//  DetailViewController.h
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MBProgressHUD.h"

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate>
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) Movie *movie;
- (void)setMovieItem:(id)newMovieItem;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionText;

@end
