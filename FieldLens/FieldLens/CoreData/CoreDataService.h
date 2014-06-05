//
//  CoreDataService.h
//  FieldLens
//
//  Created by Antonio Hung on 6/3/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
@interface CoreDataService : NSObject
+ (CoreDataService *)sharedCoreDataService;
-(id)init;
-(BOOL)removeAllMovies;
-(Movie *)insertMovieFromDictionary:(NSDictionary *)movieDict;
-(BOOL)updateMovie:(Movie *)movie fromDictionary:(NSDictionary *)movieDict;
-(Movie *)getMovieFromMovieID:(NSString *)movieID;

-(NSArray *)getAllMovies;


@end
