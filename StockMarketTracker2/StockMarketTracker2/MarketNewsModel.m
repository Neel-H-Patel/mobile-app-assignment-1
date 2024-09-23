//
//  MarketNewsModel.m
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/22/24.
//

#import "MarketNewsModel.h"

@interface MarketNewsModel()

@property (strong, nonatomic) NSArray* marketCategoryNames;

@end

@implementation MarketNewsModel

@synthesize marketCategoryNames = _marketCategoryNames;

+(MarketNewsModel*)sharedInstance{
    static MarketNewsModel* _sharedInstance = nil;
    
    static dispatch_once_t predicate;
    // runs this block of code only one time
    dispatch_once(&predicate, ^{
        // we have access to 'alloc' and 'init' because we inherit from NSObject
        _sharedInstance = [[MarketNewsModel alloc] init];
    });
    
    return _sharedInstance;
}

-(NSArray*) marketCategoryNames{
    // if marketCategoryNames is not intialized, initialize it
    if (!_marketCategoryNames) {
        _marketCategoryNames = @[@"Technology", @"Business", @"Top News"];
    }
    
    return _marketCategoryNames;
}

-(void)getNewsArticleWithCategoryName:(NSString *)categoryName completion:(void (^)(NSDictionary * _Nullable article))completion {
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/news?category=%@&token=%@", categoryName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];

    // Create a data task
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSString *mostRecentArticle = @"Article not available";

        if (error) {
            NSLog(@"Error fetching data: %@", error.localizedDescription);
        } else if (data) {
            NSError *jsonError = nil;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

            if (jsonError) {
                NSLog(@"Error parsing JSON: %@", jsonError.localizedDescription);
            } else if ([jsonArray isKindOfClass:[NSArray class]] && jsonArray.count > 0) {
                NSDictionary *firstArticle = jsonArray[0];
                // Call the completion handler with the article
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(firstArticle);
                    }
                });
            } else {
                NSLog(@"JSON is not an array or is empty");
            }
        }

        // Call the completion handler on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(nil);
            }
        });
    }];
    [task resume];
}

@end
