//
//  AppDelegate.h
//  FieldLens
//
//  Created by Antonio Hung on 12/18/12.
//  Copyright (c) 2012 AYO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface WebServiceAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
