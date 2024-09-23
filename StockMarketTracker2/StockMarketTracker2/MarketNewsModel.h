//
//  MarketNewsModel.h
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/22/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketNewsModel : NSObject

+(MarketNewsModel*)sharedInstance;

- (void)getNewsArticleWithCategoryName:(NSString *)categoryName completion:(void (^)(NSDictionary * _Nullable article))completion;

@end

NS_ASSUME_NONNULL_END
