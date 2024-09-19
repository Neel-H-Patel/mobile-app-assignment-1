//
//  StockModel.m
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

#import "StockModel.h"

@implementation StockModel

// need to synthesize property
@synthesize stockNames = _stockNames;

// creates a singleton class
+(StockModel*)sharedInstance{
    static StockModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    // runs this block of code only one time
    dispatch_once(&predicate, ^{
        // we have access to 'alloc' and 'init' because we inherit from NSObject
        _sharedInstance = [[StockModel alloc] init];
    });
    
    return _sharedInstance;
}

// override the getter for stockNames
-(NSArray*) stockNames{
    // if stockNames is not intialized, initialize it
    if (!_stockNames) {
        // need to replace this with our stock names
        _stockNames = @[@"Bill", @"Eric", @"Jeff"];
    }
    
    return _stockNames;
}

-(UIImage*)getStockImageWithName:(NSString*)name{
    UIImage* image = nil;
    // as long as image named is valid, we will be able to load it in stockNames array
    image = [UIImage imageNamed:name];
    
    return image;
}

-(NSString*)getStockInfoWithName:(NSString*)name{
    // call the API here and get the stock info to return, format it as needed, maybe we need to create an NSArray to store variables for it, or we do that in the ViewController, not sure
    
    return @"This is just placeholder text for now";
}

@end
