//
//  DetailViewController.m
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "WebService.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    
    [self configureData];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)setMovieItem:(id)newMovieItem
{
    if (self.movie != newMovieItem)
        self.movie  = newMovieItem;

    [self configureData];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        if (self.masterPopoverController != nil) {
            [self.masterPopoverController dismissPopoverAnimated:YES];
        }
    }
}
-(void)configureData
{
    if(!self.movie)
        return;
    
    self.title = self.movie.title;
    self.movieDescriptionText.text = @"";
    
    
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [self.moviePosterImage setImageWithURL:[NSURL URLWithString:self.movie.posterImage] placeholderImage:placeholderImage];
    
    if(self.movie.desc)
        self.movieDescriptionText.text = self.movie.desc;
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[WebService sharedWebService]getMovieDetailForMovie:self.movie withBlock:^(Movie *movie) {
            
            [MBProgressHUD hideHUDForView:self.view animated:NO];

            if(!movie)
            {
                [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Could Not Movie Detail Data" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
                return;
            }
            if(movie.desc)
            {
                self.movieDescriptionText.text = movie.desc;
            }
        }];
    }

}
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Movies", @"Movies");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
