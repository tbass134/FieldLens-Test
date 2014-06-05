//
//  CoreDataService.m
//  FieldLens
//
//  Created by Antonio Hung on 6/3/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import "CoreDataService.h"
#import "AppDelegate.h"
#import "Movie.h"
static CoreDataService* sharedCoreDataService = nil;

@implementation CoreDataService

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}
-(BOOL)removeAllMovies
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest * allMovies = [[NSFetchRequest alloc] init];
    [allMovies setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:appDelegate.managedObjectContext]];
    [allMovies setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * movies = [appDelegate.managedObjectContext executeFetchRequest:allMovies error:&error];
    for (NSManagedObject * movie in movies) {
        [appDelegate.managedObjectContext deleteObject:movie];
    }
    NSError *saveError = nil;
    [appDelegate.managedObjectContext save:&saveError];
    return !saveError;
}
-(Movie *)insertMovieFromDictionary:(NSDictionary *)movieDict
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    Movie *movie = [[Movie alloc]initWithEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:appDelegate.managedObjectContext] insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    
    movie.movieID = [movieDict[@"id"] stringValue];
    movie.title = movieDict[@"title"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYY-MM-DD"];
    
    NSDate *releaseDate = [dateFormat dateFromString:movieDict[@"release_date"]];
    movie.releaseDate = releaseDate;
    
    if(movieDict[@"poster_path"] && movieDict[@"poster_path"] != [NSNull null])
    {
        NSString *imageURL = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@",movieDict[@"poster_path"]];
        movie.posterImage =imageURL;
    }
    NSError *saveError = nil;
    [appDelegate.managedObjectContext save:&saveError];
    if(!saveError)
        return movie;
    
    return NULL;
}
-(BOOL)updateMovie:(Movie *)movie fromDictionary:(NSDictionary *)movieDict
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    movie.desc = movieDict[@"overview"];
    NSError *saveError = nil;
    [appDelegate.managedObjectContext save:&saveError];
    return !saveError;
    
}
-(Movie *)getMovieFromMovieID:(NSString *)movieID
{
    NSArray *savedMovies = [self getAllMovies];
    
    for(Movie *theMovie in savedMovies)
    {
        if([theMovie.movieID isEqualToString:movieID])
        {
            return theMovie;
        }
    }
    return NULL;

}
-(NSArray *)getAllMovies
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Movie" inManagedObjectContext:appDelegate.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *err = nil;
    return [appDelegate.managedObjectContext executeFetchRequest:request error:&err];
}
+ (id) sharedCoreDataService {
    @synchronized(self) {
        if (sharedCoreDataService == nil)
            sharedCoreDataService = [[self alloc] init];
    }
    return sharedCoreDataService;
}

@end
