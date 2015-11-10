//
//  ReviewController.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-09.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ReviewController.h"
#import "Movie.h"

@interface ReviewController ()

@property (nonatomic) NSMutableArray *reviewsArray;

@property (weak, nonatomic) IBOutlet UILabel *reviewLabel1;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel2;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel3;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel4;

@end

@implementation ReviewController

-(void)viewDidLoad {

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:self.movie.reviewLink completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *reviews = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            self.reviewsArray = [NSMutableArray new];
            
            for (int i = 0; i < 4; i++) {
                
                NSString *quote = reviews[@"reviews"][i][@"quote"];
                NSString *critic = reviews[@"reviews"][i][@"critic"];
                NSString *publication = reviews[@"reviews"][i][@"publication"];
                
                NSString *review = [NSString stringWithFormat:@"'%@'\n%@\n%@", quote, critic, publication];
                
                [self.reviewsArray addObject:review];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.reviewLabel1.text = self.reviewsArray[0];
                self.reviewLabel2.text = self.reviewsArray[1];
                self.reviewLabel3.text = self.reviewsArray[2];
                self.reviewLabel4.text = self.reviewsArray[3];
                
            });
            

        }
        
    }];
    
    [dataTask resume];
}

@end
