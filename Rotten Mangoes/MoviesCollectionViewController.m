//
//  MoviesCollectionViewController.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "MoviesCollectionViewController.h"
#import "Movie.h"
#import "MoviesCollectionViewCell.h"
#import "DetailViewController.h"

@interface MoviesCollectionViewController ()

@property (nonatomic) NSMutableArray *movies;

@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *rottenTomatoesURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:rottenTomatoesURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *movies = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSMutableArray *moviesArray = [NSMutableArray new];
            
            for (NSDictionary *movie in movies[@"movies"]) {
                
                NSString *name = movie[@"title"];
                NSNumber *year = movie[@"year"];
                
                //getting url for hi res images
                NSString *thumbnail = movie[@"posters"][@"thumbnail"];
                NSRange range = [thumbnail rangeOfString:@"dkpu1"];
                NSString *HRImageURLString = [thumbnail substringFromIndex:range.location];
                NSString *urlPrefix = @"http://";
                
                NSURL *imageURL = [NSURL URLWithString:[urlPrefix stringByAppendingString:HRImageURLString]];
                
                NSString *rating = movie[@"ratings"][@"critics_rating"];
                NSString *release = movie[@"release_dates"][@"theater"];
                NSArray *cast = movie[@"abridged_cast"];
                
                Movie *newMovie = [[Movie alloc] initWithTitle:name andYear:year andRating:rating andReleaseDate:release andCast:cast andImageURL:imageURL];
                
                [moviesArray addObject:newMovie];
                
            }
            
            self.movies = moviesArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                
            });
        }
        
    }];
    
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)self.movies.count);
    return self.movies.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Movie *movie = self.movies[indexPath.item];
    
    [cell configureWithMovie:movie];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    
    DetailViewController *detailVC = [segue destinationViewController];
    
    detailVC.movie = self.movies[indexPath.item];
    
}

@end























