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

-(NSString*)getStockInfoWithName:(NSString*)name;

@property (strong, nonatomic) NSArray* stockNames;

@end

NS_ASSUME_NONNULL_END
