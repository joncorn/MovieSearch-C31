//
//  JDCMovie.h
//  MovieSearch-C31
//
//  Created by Jon Corn on 1/31/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - JDCMovie
@interface JDCMovie : NSObject

// Movie model properties
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSString *poster;
@property (nonatomic, copy, readonly) NSNumber *rating;

// Movie model initializer
- (instancetype)initWithTitle:(NSString *)title
                     overview:(NSString *)overview
                       poster:(NSString *)poster
                       rating:(NSNumber *)rating;
@end

#pragma mark - Extension
@interface JDCMovie (JSONConvertable)

// Dictionary initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
