//
//  AppDelegate.h
//  FieldLens
//
//  Created by Antonio Hung on 12/18/12.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface WebServiceAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
