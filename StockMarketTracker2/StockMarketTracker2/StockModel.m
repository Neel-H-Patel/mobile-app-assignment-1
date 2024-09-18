//
//  StockModel.m
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

#import "StockModel.h"

@implementation StockModel


// creates our image class once
+(StockModel*)sharedInstance{
    static StockModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[StockModel alloc] init];
    });
    
    return _sharedInstance;
}

@end
