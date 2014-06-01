//
//  WebService.h
//  FieldLens
//
//  Created by Antonio Hung on 5/22/13.
//  Copyright (c) 2013 Dark Bear Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject
+ (WebService *)sharedWebService;
-(id)init;
-(void)popUpWithMessage:(NSString*)msg andTitle:(NSString *)title;

-(void)getUpcomingMoviesWithBlock:(void (^)(NSArray *movies))block;
@end
