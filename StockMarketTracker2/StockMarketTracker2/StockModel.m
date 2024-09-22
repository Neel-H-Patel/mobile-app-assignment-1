//
//  StockModel.m
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

#import "StockModel.h"

@interface StockModel()

@property (strong, nonatomic) NSArray* stockNames;
@property (strong, nonatomic) NSDictionary* stockImagesDict;

@end

@implementation StockModel

// need to synthesize property
@synthesize stockNames = _stockNames;
@synthesize stockImagesDict = _stockImagesDict;

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
        _stockNames = @[@"AAPL", @"AMZN", @"ADBE", @"COST", @"XOM", @"GOOGL", @"HD", @"JNJ", @"JPM", @"MA", @"META", @"MSFT", @"NVDA", @"TSLA", @"V"];
    }
    
    return _stockNames;
}

-(NSDictionary*)stockImagesDict{
    if(!_stockImagesDict){
        _stockImagesDict = @{
            @"AAPL":[UIImage imageNamed:@"Apple"],
            @"AMZN":[UIImage imageNamed:@"Amazon"],
            @"ADBE":[UIImage imageNamed:@"Adobe"],
            @"COST":[UIImage imageNamed:@"Costco"],
            @"XOM":[UIImage imageNamed:@"Exxon"],
            @"GOOGL":[UIImage imageNamed:@"Google"],
            @"HD":[UIImage imageNamed:@"Home Depot"],
            @"JNJ":[UIImage imageNamed:@"Johnson&Johnson"],
            @"JPM":[UIImage imageNamed:@"JPMorgan"],
            @"MA":[UIImage imageNamed:@"Mastercard"],
            @"META":[UIImage imageNamed:@"Meta"],
            @"MSFT":[UIImage imageNamed:@"Microsoft"],
            @"NVDA":[UIImage imageNamed:@"Nvidia"],
            @"TSLA":[UIImage imageNamed:@"Tesla"],
            @"V":[UIImage imageNamed:@"Visa"]
        };
    }
    
    return _stockImagesDict;
}

-(NSInteger)numberOfStocks{
    return self.stockNames.count;
}

-(NSString*)getStockNameForIndex:(NSInteger)index{
    return self.stockNames[index];
}

-(UIImage*)getStockImageWithName:(NSString*)name{
    return self.stockImagesDict[name];
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

- (void)getStockFullNameWithName:(NSString *)stockName completion:(void (^)(NSString *stockFullName))completion {
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/stock/profile2?symbol=%@&token=%@", stockName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *stockFullName = @"Name not available";
        if (data && !error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            stockFullName = json[@"name"];
        }
        
        // Call the completion handler on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(stockFullName);
            }
        });
    }];
    [task resume];
}

@end
