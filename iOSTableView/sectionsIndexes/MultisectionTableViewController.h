//
//  MultisectionTableViewController.h
//  iOSTableView
//
//  Created by alex on 13/7/21.
//  Copyright © 2021 alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultisectionTableViewController : UITableViewController

@property (nonatomic, retain) NSArray* multiSectionArray;

-(void) createAlphabetArray;


@end

NS_ASSUME_NONNULL_END
