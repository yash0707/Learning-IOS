//
//  ItemTableViewCell.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@protocol ItemTableViewCellDelegate;

@interface ItemTableViewCellModel : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface ButtonLeftAlignedItemTableViewCell : UITableViewCell

@property (nonatomic,weak) id delegate;
- (void)updateCellWithModel:(ItemTableViewCellModel *)model;

@end

@protocol ItemTableViewCellDelegate <NSObject>

- (void) updateCellSelectedStatus:(ButtonLeftAlignedItemTableViewCell*)itemTableViewCell whereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString*)data;

@end

NS_ASSUME_NONNULL_END
