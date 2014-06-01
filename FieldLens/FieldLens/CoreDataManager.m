//
//  CoreDataManager.m
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "Movie.h"
@implementation CoreDataManager
static CoreDataManager* sharedCoreDataManager = nil;
- (id)init {
    if (self = [super init]) {
        
        //init stuff here
    }
    
    return self;
}
+ (id)sharedCoreDataManager {
    @synchronized(self) {
        if (sharedCoreDataManager == nil)
            sharedCoreDataManager = [[self alloc] init];
    }
    return sharedCoreDataManager;
}
-(void)addMovie:(NSDictionary *)movieDict usingManagedContext:(NSManagedObjectContext *)ctx
{
    NSManagedObject *MovieObject= [NSEntityDescription
                  insertNewObjectForEntityForName:@"Movie"
                  inManagedObjectContext:ctx];
    
    [MovieObject setValue:movieDict[@"title"] forKey:@"title"];
    [MovieObject setValue:movieDict[@"title"] forKey:@"address"];
    [MovieObject setValue:movieDict[@"title"] forKey:@"phone"];
    NSError *error;
    [ctx save:&error];
}
@end
