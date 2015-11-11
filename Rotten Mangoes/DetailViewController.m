//
//  DetailViewController.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "DetailViewController.h"
#import "ReviewController.h"
#import "MapViewController.h"
#import "Movie.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *starringLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;

@end

@implementation DetailViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.movieTitle.text = self.movie.title;
    
    self.movieImage.image = self.movie.cachedImage;
    
    self.ratingLabel.text = self.movie.rating;
    self.releaseDateLabel.text = self.movie.releaseDate;
    self.starringLabel.text = [NSString stringWithFormat:@"Starring: %@", self.movie.cast[0][@"name"]];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"reviews"]) {
        
        ReviewController *controller = [segue destinationViewController];
        controller.movie = self.movie;
        
    } else if ([segue.identifier isEqualToString:@"map"]) {
        
        MapViewController *controller = [segue destinationViewController];
        controller.movie = self.movie;
    }
    
}

@end
