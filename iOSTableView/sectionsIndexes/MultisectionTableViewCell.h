//
//  MultisectionTableViewCell.h
//  iOSTableView
//
//  Created by alex on 15/7/21.
//  Copyright © 2021 alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultisectionTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *doorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

NS_ASSUME_NONNULL_END
