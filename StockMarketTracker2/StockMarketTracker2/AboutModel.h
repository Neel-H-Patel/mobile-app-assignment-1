//
//  AboutModel.h
//  StockMarketTracker2
//
//  Created by Adeel Allawala on 9/22/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutModel : NSObject

// returns pointer to the stock model
+ (AboutModel*) sharedInstance;

- (NSUInteger)getImageCount;

- (UIImage*) getImageWithIndex:(int)index;



@end

NS_ASSUME_NONNULL_END
