//
//  ItemTableViewCell2.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTableViewCellProtocol.h"
#import "ItemCellDataModel.h"

@interface ButtonRightAlignedItemTableViewCell : UITableViewCell

@property (nonatomic,weak) id buttonRightAlignedDelegate;
- (void)updateCellWithModel:(ItemCellDataModel *)model;

@end

