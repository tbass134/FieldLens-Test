//
//  Movie.h
//  FieldLens
//
//  Created by Antonio Hung on 6/3/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * movieID;
@property (nonatomic, retain) NSString * posterImage;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * title;

@end
