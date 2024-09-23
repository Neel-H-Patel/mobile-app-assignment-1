//
//  MarketNewsModel.m
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/22/24.
//

#import "MarketNewsModel.h"

@implementation MarketNewsModel

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

-(void)getNewsArticleWithCategoryName:(NSString *)categoryName completion:(void (^)(NSDictionary * article))completion {
    NSString *apiKey = @"cro2rthr01qv7t46ovogcro2rthr01qv7t46ovp0";
    NSString *urlString = [NSString stringWithFormat:@"https://finnhub.io/api/v1/news?category=%@&token=%@", categoryName, apiKey];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {

        if (data) {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            // return the first article that is returned for that category
            if (jsonArray.count > 0) {
                NSDictionary *firstArticle = jsonArray[0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(firstArticle);
                    }
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(nil);
                }
            });
        }
    }];
    
    [task resume];
}

@end
