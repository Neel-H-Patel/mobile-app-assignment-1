//
//  StockModel.h
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StockModel : NSObject

// returns pointer to the stock model
+(StockModel*)sharedInstance;

-(UIImage*)getStockImageWithName:(NSString*)name;

- (void)getStockPriceWithName:(NSString *)stockName completion:(void (^)(NSString *stockPrice))completion;

- (void)getStockPriceChangeWithName:(NSString *)stockName completion:(void (^)(NSString *priceChange))completion;

- (void)getStockFullNameWithName:(NSString *)stockName completion:(void (^)(NSString *stockFullName))completion;

-(NSInteger)numberOfStocks;

-(NSString*)getStockNameForIndex: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
