//
//  Theatre.m
//  Rotten Mangoes
//
//  Created by Alex on 2015-11-10.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle;
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
        _title = aTitle;
        _subtitle = aSubtitle;
    }
    return self;
}

@end
