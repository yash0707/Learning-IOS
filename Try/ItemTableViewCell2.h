//
//  ItemTableViewCell2.h
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCellModel2 : NSObject

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface ItemTableViewCell2 : UITableViewCell

- (void)updateCellWithModel:(ItemTableViewCellModel2 *)model;

@end

