//
//  AppDelegate.h
//  FieldLens
//
//  Created by Antonio Hung on 12/18/12.
//  Copyright (c) 2012 Dark Bear Interactive. All rights reserved.
//

#import "WebServiceAPIClient.h"


@implementation WebServiceAPIClient
+ (WebServiceAPIClient *)sharedClient {
    static WebServiceAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        NSString *url = @"https://api.themoviedb.org/3";
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:url]];
        //[_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];

    });
    
    return _sharedClient;
}
@end
