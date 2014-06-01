//
//  Movie.h
//  FieldLens
//
//  Created by Tony Hung on 6/1/14.
//  Copyright (c) 2014 Tony Hung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString *posterImage;
@property (nonatomic, retain) NSDate * releaseDate;

@end
