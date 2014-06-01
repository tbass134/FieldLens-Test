//
//  DetailViewController.m
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    self.movieTitleText.text = self.movie.title;
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.movie.posterImage]];
    __weak UIImageView *weakImage = self.moviePosterImage;

    [self.moviePosterImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakImage.image = image;
                                       
                                   } failure:nil];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
