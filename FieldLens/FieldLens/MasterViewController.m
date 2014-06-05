//
//  MasterViewController.m
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"


@interface MasterViewController ()
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [[WebService sharedWebService]getUpcomingMoviesWithBlock:^(NSArray *movies) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if(movies.count ==0)
        {
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Could Not Load Data" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
            return;
        }
        self.movies = movies;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            Movie *movie = self.movies[0];
            [self.detailViewController setMovieItem:movie];
        }
        [self.tableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Movie *movie = self.movies[indexPath.row];
    //NSLog(@"title - %@ releaseDate - %@",movie.title,movie.releaseDate);
    cell.textLabel.text = movie.title;
    
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];

    cell.imageView.image = placeholderImage;
    if(movie.posterImage)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:movie.posterImage]];
        
        __weak UITableViewCell *weakCell = cell;
        
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           weakCell.imageView.image = image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];
    }

    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Movie *movie = self.movies[indexPath.row];
        [self.detailViewController setMovieItem:movie];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *movie = self.movies[indexPath.row];
        [[segue destinationViewController]setMovie:movie];
    }
}
@end
