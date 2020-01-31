//
//  JDCMovie.m
//  MovieSearch-C31
//
//  Created by Jon Corn on 1/31/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import "JDCMovie.h"

#pragma mark - String helpers
static NSString *const titleKey = @"title";
static NSString *const overviewKey = @"overview";
static NSString *const posterKey = @"poster_path";
static NSString *const ratingKey = @"vote_average";

#pragma mark - JDCMovie
@implementation JDCMovie

// Movie model initializer
- (instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview poster:(NSString *)poster rating:(NSNumber *)rating
{
    self = [super init];
    if (self)
    {
        _title = title;
        _overview = overview;
        _poster = poster;
        _rating = rating;
    }
    return self;
}

@end

#pragma mark - Dictionary extension
@implementation JDCMovie (JSONConvertable)

// Dictionary initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[titleKey];
    NSString *overview = dictionary[overviewKey];
    NSString *poster = dictionary[posterKey];
    NSNumber *rating = dictionary[ratingKey];
    
    return [self initWithTitle:title overview:overview poster:poster rating:rating];
}

@end
