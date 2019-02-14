//
//  ItemTableViewCell.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTableViewCellProtocol.h"
#import "ItemCellDataModel.h"

@interface ButtonLeftAlignedItemTableViewCell : UITableViewCell

@property (nonatomic,weak) id buttonLeftAlignedDelegate;
- (void)updateCellWithModel:(ItemCellDataModel *)model;

@end
