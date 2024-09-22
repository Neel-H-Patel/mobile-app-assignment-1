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

- (void)getStockPriceWithName:(NSString *)stockName completion:(void (^)(NSString *stockPrice))completion {
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/quote?symbol=%@&token=%@", stockName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];

    // Create a data task
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSString *stockPrice = @"Price not available";
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSNumber *currentPrice = json[@"c"];
            
            if (currentPrice) {
                stockPrice = [NSString stringWithFormat:@"$%.2f", [currentPrice doubleValue]];
            }
        }

        // Call the completion handler on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(stockPrice);
            }
        });
    }];
    [task resume];
}

- (void)getStockPriceChangeWithName:(NSString *)stockName completion:(void (^)(NSString *priceChange))completion {
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/quote?symbol=%@&token=%@", stockName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *priceChange = @"Change not available";
        if (data && !error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSNumber *currentPrice = json[@"c"];
            NSNumber *previousClose = json[@"pc"];
            if (currentPrice && previousClose) {
                double change = [currentPrice doubleValue] - [previousClose doubleValue];
                double percentChange = (change / [previousClose doubleValue]) * 100.0;
                            
                // Determine the sign
                NSString *sign = @"";
                if (change > 0) {
                    sign = @"+";
                } else if (change < 0) {
                    sign = @"-";
                }
                
                // Use absolute values to avoid double signs
                double absChange = fabs(change);
                double absPercentChange = fabs(percentChange);
                
                // Format the string to "0.00 (0.00%)"
                priceChange = [NSString stringWithFormat:@"%@%.2f (%.2f%%)", sign, absChange, absPercentChange];
            }
        }
        
        // Call the completion handler on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(priceChange);
            }
        });
    }];
    [task resume];
}

@end
