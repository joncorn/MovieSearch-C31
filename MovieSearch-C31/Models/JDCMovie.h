//
//  JDCMovie.h
//  MovieSearch-C31
//
//  Created by Jon Corn on 1/31/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCMovie : NSObject

// Properties
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, copy, readonly) NSNumber *rating;

// Initializer
- (instancetype)
@end

NS_ASSUME_NONNULL_END