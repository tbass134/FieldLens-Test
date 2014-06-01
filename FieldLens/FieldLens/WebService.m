//
//  WebService.m
//  FieldLens
//
//  Created by Antonio Hung on 5/22/13.
//  Copyright (c) 2013 Dark Bear Interactive. All rights reserved.
//

#import "WebService.h"
#import "AFHTTPRequestOperation.h"
#import "WebServiceAPIClient.h"
#import "AppDelegate.h"
#import "Movie.h"

#define IN_TESTING 0
static NSString *TMDB_API_KEY = @"45b53fed0a34751a8fda0043801d6e08";
@implementation WebService

static WebService* sharedWebService = nil;
- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}
-(void)popUpWithMessage:(NSString*)msg andTitle:(NSString *)title {
    
    if(msg == NULL)
        msg = @"Error!";
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msg
                                                        message:title
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    [alertView show];
}
-(void)getUpcomingMoviesWithBlock:(void (^)(NSArray *movies))block;
{
    NSMutableArray *moviesArray = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    __block NSArray *savedMovies;
    [self getSavedMoviesWithBlock:^(NSArray *movies) {
        savedMovies = movies;
    }];
                            
    [[WebServiceAPIClient sharedClient]GET:[NSString stringWithFormat:@"movie/upcoming?api_key=%@",TMDB_API_KEY] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        for(NSDictionary *moveDict in responseObject[@"results"])
        {
            BOOL insertItem = YES;
            for(Movie *movie in savedMovies)
            {
                if([movie.title isEqualToString:moveDict[@"title"]])
                {
                    insertItem = NO;
                    [moviesArray addObject:movie];
                    break;
                    
                }
            }
            if(insertItem)
            {
                Movie *movie = [[Movie alloc]initWithEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:appDelegate.managedObjectContext] insertIntoManagedObjectContext:appDelegate.managedObjectContext];
                movie.title = moveDict[@"title"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYY-MM-DD"];
                
                NSDate *releaseDate = [dateFormat dateFromString:moveDict[@"release_date"]];
                movie.releaseDate = releaseDate;
                
                if(moveDict[@"poster_path"] && moveDict[@"poster_path"] != [NSNull null])
                {
                   NSString *imageURL = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@",moveDict[@"poster_path"]];
                    movie.posterImage =imageURL;
                }
                NSError *saveError = nil;
                [appDelegate.managedObjectContext save:&saveError];
                if(!saveError)
                    [moviesArray addObject:movie];
            }
        }
        //NSLog(@"responseObject %@",responseObject);
        if(block)
            block(moviesArray);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self getSavedMoviesWithBlock:^(NSArray *movies) {
            block(movies);
        }];
        
    }];
}
-(void)getSavedMoviesWithBlock:(void (^)(NSArray *movies))block;
{
    //NSLog(@"erorr %@",error);
    NSError *err = nil;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Movie" inManagedObjectContext:appDelegate.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"title" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:request error:&err];
    if(block)
        block(array);
    

}
+ (id)sharedWebService {
    @synchronized(self) {
        if (sharedWebService == nil)
            sharedWebService = [[self alloc] init];
    }
    return sharedWebService;
}

@end
