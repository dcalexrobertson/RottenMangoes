//
//  MoviesCollectionViewCell.h
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MoviesCollectionViewCell : UICollectionViewCell

- (void)configureWithMovie:(Movie *)movie;

@end
