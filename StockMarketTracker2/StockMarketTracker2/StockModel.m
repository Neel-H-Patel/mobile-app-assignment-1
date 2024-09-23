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

// Needed to learn how to use the finnhub API in objective C, but could not find any documentation for it on the website or anywhere else on the web, so this is the prompt I entered into ChatGPT to get assistance on how to call the API in objective C: "How do I call the finnhub API in objective C if I want to input the stock name and get the stock price"
// from that, I was able to learn how to use the NSURL and tasks to carry out the API call and used that to create all methods listed here and the method in the MarketNewsModel
// also for testing purposes, I left my apiKey in here so that whoever is testing this can run the app without needing to create a finnhub account
// also learned about completion and how it basically runs after the API call is returned

- (void)getStockPriceWithName:(NSString *)stockName completion:(void (^)(NSString *stockPrice))completion {
    // formats the API URL call and converts to an NSURL object for use during the HTTP request
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/quote?symbol=%@&token=%@", stockName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];

    // Create a data task that receives, the data received by the server (data), the metadata and status code (response), and an error if the request fails(error)
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        // sets a default value for the stockPrice that we will later return
        NSString *stockPrice = @"Price not available";
        
        // converts our json data into an NSDictionary for access to its contents
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSNumber *currentPrice = json[@"c"];
            
            // formats our price to have two decimal places
            if (currentPrice) {
                stockPrice = [NSString stringWithFormat:@"$%.2f", [currentPrice doubleValue]];
            }
        }

        // we call this so that the UI updates occur properly on the main thread, the if block for the completion makes sure to only call the block when it is not equal to nil
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(stockPrice);
            }
        });
    }];
    
    // this is necessary because tasks are in a suspended state until you call this to initiate the network request
    [task resume];
}

- (void)getStockPriceChangeWithName:(NSString *)stockName completion:(void (^)(NSString *priceChange))completion {
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/quote?symbol=%@&token=%@", stockName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * response, NSError * error) {
        
        NSString *priceChange = @"Price change not available";
        
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSNumber *currentPrice = json[@"c"];
            NSNumber *previousClose = json[@"pc"];
            
            // calculate what the dollar amount change and the percent change are
            if (currentPrice && previousClose) {
                
                // have to convert from NSNumber to a double
                double change = [currentPrice doubleValue] - [previousClose doubleValue];
                double percentChange = (change / [previousClose doubleValue]) * 100.0;
                
                // Format the price change string to "0.00 (0.00%)"
                priceChange = [NSString stringWithFormat:@"%.2f (%.2f%%)", change, percentChange];
            }
        }
        
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
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * response, NSError * error) {
        NSString *stockFullName = @"Stock Name not available";
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            stockFullName = json[@"name"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(stockFullName);
            }
        });
    }];
    [task resume];
}

@end
