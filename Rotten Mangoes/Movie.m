//
//  Movie.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title andYear:(NSNumber *)year andRating:(NSString *)rating andReleaseDate:(NSString *)releaseDate andCast:(NSArray *)cast andImageURL:(NSURL *)imageURL
{
    self = [super init];
    
    if (self) {
        _title = title;
        _year = year;
        _rating = rating;
        _releaseDate = releaseDate;
        _cast = cast;
        _movieImage = imageURL;
    }
    
    return self;
}


@end
