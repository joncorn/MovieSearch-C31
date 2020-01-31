//
//  JDCMovieController.h
//  MovieSearch-C31
//
//  Created by Jon Corn on 1/31/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCMovie.h"
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDCMovieController : NSObject
// 'static' class methods
+ (void)fetchMoviesWith:(NSString *)searchTerm completion:(void (^) (NSArray<JDCMovie *> *))completion;
+ (void)fetchPosterFor:(JDCMovie *)movie completion:(void (^) (UIImage *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
