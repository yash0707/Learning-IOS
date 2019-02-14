//
//  ItemTableViewCell.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTableViewCellProtocol.h"

@interface ItemTableViewCellModel : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface ButtonLeftAlignedItemTableViewCell : UITableViewCell

@property (nonatomic,weak) id buttonLeftAlignedDelegate;
- (void)updateCellWithModel:(ItemTableViewCellModel *)model;

@end
