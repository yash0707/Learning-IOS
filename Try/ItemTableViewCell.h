//
//  ItemTableViewCell.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ItemTableViewCellModel : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) BOOL isSelected;

@end


@interface ItemTableViewCell : UITableViewCell

- (void)updateCellWithModel:(ItemTableViewCellModel *)model;
@property (nonatomic, strong) UIButton *tickButton;
@end

NS_ASSUME_NONNULL_END
