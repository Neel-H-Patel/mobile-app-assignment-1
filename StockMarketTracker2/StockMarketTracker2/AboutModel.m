//
//  AboutModel.m
//  StockMarketTracker2
//
//  Created by Adeel Allawala on 9/22/24.
//

#import "AboutModel.h"
#import <UIKit/UIKit.h>

@interface AboutModel ()
// Declare the private property here
@property (nonatomic, strong) NSArray *images;

@end


@implementation AboutModel
@synthesize images = _images;

// lazy instantiation
- (NSArray *) images {
    if (!_images) {
        _images = @[[UIImage imageNamed:@"Neel"],
                    [UIImage imageNamed:@"Adeel"]];
    }
    return _images;
}


// creates a singleton class
+(AboutModel*)sharedInstance{
    static AboutModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    // runs this block of code only one time
    dispatch_once(&predicate, ^{
        // we have access to 'alloc' and 'init' because we inherit from NSObject
        _sharedInstance = [[AboutModel alloc] init];
        
    });
    
    return _sharedInstance;
}

// return UIImage pointer
- (nonnull UIImage *) getImageWithIndex:(int)index {
        return self.images[index];
}

// for iteration
- (NSUInteger) getImageCount {
    return [self.images count];
}


@end
