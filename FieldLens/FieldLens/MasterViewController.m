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
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    self.images = [[NSDictionary alloc]init];
    [[WebService sharedWebService]getUpcomingMoviesWithBlock:^(NSArray *movies) {

        self.movies = movies;
        [self.tableView reloadData];
    }];
    [super viewDidLoad];
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
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *movie = self.movies[indexPath.row];
        [[segue destinationViewController] setMovie:movie];
    }
}
@end
