//
//  ItemTableViewCell2.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTableViewCellProtocol.h"

@interface ItemTableViewCellModel2 : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface ButtonRightAlignedItemTableViewCell : UITableViewCell

@property (nonatomic,weak) id buttonRightAlignedDelegate;
- (void)updateCellWithModel:(ItemTableViewCellModel2 *)model;

@end

