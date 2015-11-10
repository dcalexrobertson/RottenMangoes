//
//  MoviesCollectionViewCell.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "MoviesCollectionViewCell.h"
#import "Movie.h"

@interface MoviesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;
@property (strong, nonatomic) NSURLSessionTask *task;

@end

@implementation MoviesCollectionViewCell

- (void)configureWithMovie:(Movie *)movie {
    
    self.movieTitle.text = movie.title;
    self.movieYear.text = [movie.year stringValue];
    self.movieImage.image = nil;
    
    [self.task cancel];
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.task = [session dataTaskWithURL:movie.movieImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error loading image %@", error);
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (image) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                movie.cachedImage = image;
                self.movieImage.image = image;
                
            });
        }
        
    }];
    
    if (!movie.cachedImage) {
        [self.task resume];
    } else {
        self.movieImage.image = movie.cachedImage;
    }
    
}


@end
