//
//  DetailViewController.h
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleText;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImage;

@end
