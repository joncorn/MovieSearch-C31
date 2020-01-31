//
//  JDCMovieController.m
//  MovieSearch-C31
//
//  Created by Jon Corn on 1/31/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//  ░░░░░░░░▀████▀▄▄░░░░░░░░░░░░░░▄█
//  ░░░░░░░░░░█▀░░░░▀▀▄▄▄▄▄░░░░▄▄▀▀█
//  ░░▄░░░░░░░░█░░░░░░░░░░▀▀▀▀▄░░▄▀
//  ░▄▀░▀▄░░░░░░▀▄░░░░░░░░░░░░░░▀▄▀
//  ▄▀░░░░█░░░░░█▀░░░▄█▀▄░░░░░░▄█
//  ▀▄░░░░░▀▄░░█░░░░░▀██▀░░░░░██▄█
//  ░▀▄░░░░▄▀░█░░░▄██▄░░░▄░░▄░░▀▀░█
//  ░░█░░▄▀░░█░░░░▀██▀░░░░▀▀░▀▀░░▄▀
//  ░█░░░█░░█░░░░░░▄▄░░░░░░░░░░░▄▀

#import "JDCMovieController.h"

#pragma mark - String helpers
// Base URL
static NSString *const baseURLString = @"https://api.themoviedb.org/3";
static NSString *const searchComponent = @"search";
static NSString *const movieComponent = @"movie";
// Query strings
static NSString *const APIKeyQueryKeyName = @"api_key";
static NSString *const APIKeyQueryValue = @"1c22df5949de6e4243d3f54553ddfbf1";
static NSString *const searchQueryKeyName = @"query";
static NSString *const resultsKey = @"results";
// Poster URL
static NSString *const posterURLString = @"http://image.tmdb.org/t/p/w500/";

#pragma mark - JDCMovieController
@implementation JDCMovieController

// Fetch movie with (searchTerm)
+ (void)fetchMoviesWith:(NSString *)searchTerm completion:(void (^)(NSArray<JDCMovie *> * _Nonnull))completion
{
    // Build URL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:searchComponent];
    NSURL *movieURL = [searchURL URLByAppendingPathComponent:movieComponent];
    // Query items
    NSURLComponents *components = [NSURLComponents componentsWithURL:movieURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:APIKeyQueryKeyName value:APIKeyQueryValue];
    NSURLQueryItem *searchQuery = [NSURLQueryItem queryItemWithName:searchQueryKeyName value:searchTerm];
    components.queryItems = @[apiQuery, searchQuery];
    NSURL *finalURL = components.URL;
    // Data task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            return completion([NSArray new]);
        }
        if (!data)
        {
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            return completion([NSArray new]);
        }
        
        // Grabbing dictionary
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        // Placeholder array
        NSMutableArray *movieArray = [NSMutableArray new];
        // Pull movies from dictionary then add to array
        for (NSDictionary *movieDict in dataDictionary[resultsKey])
        {
            JDCMovie *movie = [[JDCMovie alloc]initWithDictionary:movieDict];
            [movieArray addObject:movie];
        }
        return completion(movieArray);
    }] resume];
}

// Fetch poster for (movie)
+ (void)fetchPosterFor:(JDCMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    // Base URL
    NSURL *baseURL = [NSURL URLWithString:posterURLString];
    
    if (![movie.poster isKindOfClass:[NSNull class]])
    {
        NSURL *posterURL = [baseURL URLByAppendingPathComponent:movie.poster];
        
        // Data task
        [[[NSURLSession sharedSession] dataTaskWithURL:posterURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error)
            {
                NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
                return completion(nil);
            }
            if (!data)
            {
                NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
                return completion(nil);
            }
            
            // Create and return image
            UIImage *poster = [UIImage imageWithData:data];
            return completion(poster);
        }] resume];
    }
    return completion(nil);
}

@end
