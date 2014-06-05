//
//  AppDelegate.h
//  FieldLens
//
//  Created by Antonio Hung on 12/18/12.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import "WebServiceAPIClient.h"


@implementation WebServiceAPIClient
+ (WebServiceAPIClient *)sharedClient {
    static WebServiceAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        NSString *url = @"https://api.themoviedb.org/3";
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:url]];
    });
    
    return _sharedClient;
}
@end
