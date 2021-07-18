//
//  Car.h
//  iOSTableView
//
//  Created by alex on 15/7/21.
//  Copyright © 2021 alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject

@property NSString* brand;
@property NSString* model;
@property NSInteger* doors;
@property NSDecimalNumber* price ;

- (instancetype)initWithBrand: (NSString *)brand
                        model: (NSString *)model
                        doors: (NSInteger *)doors
                        price: (NSDecimalNumber *)price;

@end

NS_ASSUME_NONNULL_END
