//
//  ItemTableViewCell2.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemTableViewCellDelegate2;

@interface ItemTableViewCellModel2 : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface ButtonRightAlignedItemTableViewCell : UITableViewCell

@property (nonatomic,weak) id<ItemTableViewCellDelegate2> delegate2;
- (void)updateCellWithModel:(ItemTableViewCellModel2 *)model;

@end

@protocol ItemTableViewCellDelegate2 <NSObject>

- (void) updateCellSelectedStatus2:(ButtonRightAlignedItemTableViewCell*)itemTableViewCell2 whereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString*)data;

@end
