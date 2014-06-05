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
#import "CoreDataService.h"
static NSString *TMDB_API_KEY = @"45b53fed0a34751a8fda0043801d6e08";
@implementation WebService

static WebService* sharedWebService = nil;
- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}
-(void)getUpcomingMoviesWithBlock:(void (^)(NSArray *movies))block;
{
    NSMutableArray *moviesArray = [[NSMutableArray alloc]init];
                            
    [[WebServiceAPIClient sharedClient]GET:[NSString stringWithFormat:@"movie/upcoming?api_key=%@",TMDB_API_KEY] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //clear the items in core data since we are online and are able to load the full list
        [[CoreDataService sharedCoreDataService] removeAllMovies];
        for(NSDictionary *movieDict in responseObject[@"results"])
        {
            Movie *movie = [[CoreDataService sharedCoreDataService]insertMovieFromDictionary:movieDict];
            if(movie)
                [moviesArray addObject:movie];
        }
        if(block)
            block([self sortedArray:moviesArray]);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSArray *allMovies = [[CoreDataService sharedCoreDataService]getAllMovies];
        if(block)
            block([self sortedArray:allMovies]);

//        [self getSavedMoviesWithBlock:^(NSArray *movies) {
//            
//            if(block)
//                block(movies);
//        }];
    }];
}
//-(void)getSavedMoviesWithBlock:(void (^)(NSArray *movies))block;
//{
//    NSArray *allMovies = [[CoreDataService sharedCoreDataService]getAllMovies];
//    if(block)
//        block([self sortedArray:allMovies]);
//}

-(void)getMovieDetailForMovie:(Movie *)movie withBlock:(void (^)(Movie *movie))block;
{
    //__block Movie *foundMovie = nil;
    
    [[WebServiceAPIClient sharedClient]GET:[NSString stringWithFormat:@"movie/%@i?api_key=%@",movie.movieID,TMDB_API_KEY] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        __block NSArray *savedMovies;
//        [self getSavedMoviesWithBlock:^(NSArray *movies) {
//            savedMovies = movies;
//        }];
//
//        for(Movie *theMovie in savedMovies)
//        {
//            if([theMovie.movieID isEqualToString:movie.movieID])
//            {
//                foundMovie = theMovie;
//                break;
//                
//            }
//        }
        Movie *foundMovie = [[CoreDataService sharedCoreDataService]getMovieFromMovieID:movie.movieID];
        if(foundMovie)
        {
           if([[CoreDataService sharedCoreDataService]updateMovie:foundMovie fromDictionary:responseObject])
                block(foundMovie);
        }
                
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
//        __block NSArray *savedMovies;
//        [self getSavedMoviesWithBlock:^(NSArray *movies) {
//            savedMovies = movies;
//        }];
//
//        //return the movie from Core Data
//        for(Movie *savedMovie in savedMovies)
//        {
//            if([savedMovie.movieID isEqualToString:movie.movieID])
//            {
//                foundMovie = savedMovie;
//                break;
//            }
//        }
        Movie *foundMovie = [[CoreDataService sharedCoreDataService]getMovieFromMovieID:movie.movieID];
        if(foundMovie && block)
        {
            block(foundMovie);
        }
    }];
}
-(NSArray *)sortedArray:(NSArray *)array
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"releaseDate"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [array sortedArrayUsingDescriptors:sortDescriptors];
}

+ (id) sharedWebService {
    @synchronized(self) {
        if (sharedWebService == nil)
            sharedWebService = [[self alloc] init];
    }
    return sharedWebService;
}

@end
