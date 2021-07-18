//
//  Car.m
//  iOSTableView
//
//  Created by alex on 15/7/21.
//  Copyright © 2021 alex. All rights reserved.
//

#import "Car.h"

@implementation Car

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithBrand: (NSString *)brand
                        model: (NSString *)model
                        doors: (NSInteger *)doors
                        price: (NSDecimalNumber *)price
 {
    self = [super init];
    if (self) {
        _brand = brand;
        _model = model;
        _doors = doors;
        _price = price;
    }
    return self;
}



@end
