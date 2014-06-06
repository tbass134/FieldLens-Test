//
//  WebService.h
//  FieldLens
//
//  Created by Antonio Hung on 5/22/13.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface WebService : NSObject
+ (WebService *)sharedWebService;
-(id)init;
-(void)getUpcomingMoviesWithBlock:(void (^)(NSArray *movies))block;

-(void)getMovieDetailForMovie:(Movie *)movie withBlock:(void (^)(Movie *movie))block;

@end
