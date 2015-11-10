//
//  Movie.h
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSNumber *year;
@property (nonatomic) NSURL *movieImage;
@property (nonatomic) NSString *rating;
@property (nonatomic) NSString *releaseDate;
@property (nonatomic) NSArray *cast;

@property (nonatomic) NSURL *reviewLink;

@property (nonatomic) UIImage *cachedImage;

- (instancetype)initWithTitle:(NSString *)title andYear:(NSNumber *)year andRating:(NSString *)rating andReleaseDate:(NSString *)releaseDate andCast:(NSArray *)cast andImageURL:(NSURL *)imageURL;

@end
