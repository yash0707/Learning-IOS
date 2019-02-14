//
//  ItemTableViewCell2.m
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ButtonRightAlignedItemTableViewCell.h"

static CGFloat const kImageViewHeight = 30;
static CGFloat const kImageViewWidth = 30;

@interface ButtonRightAlignedItemTableViewCell()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *taskTextLabel;
@property (nonatomic, strong) UIButton *tickButton;
@property (nonatomic,assign) BOOL isCurrentlySelected;

@end

@implementation ButtonRightAlignedItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self makeCustomCell];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize selfSize = self.frame.size;
    _containerView.frame = CGRectMake(10, 5, selfSize.width - 20, selfSize.height - 10);
    _tickButton.frame = CGRectMake((_containerView.frame.size.width-20-kImageViewWidth), (_containerView.frame.size.height - kImageViewHeight)/2, kImageViewWidth, kImageViewHeight);
    _taskTextLabel.frame = CGRectMake(0, 0, 100, CGRectGetHeight(_containerView.frame));
}

#pragma mark - Public methods

- (void)updateCellWithModel:(ItemCellDataModel *)model {
    _taskTextLabel.text = model.titleText;
    
    if(model.isSelected){
        _isCurrentlySelected = YES;
        [_tickButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    } else {
        _isCurrentlySelected = NO;
        [_tickButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    }
}

#pragma mark - Private methods

- (void)makeCustomCell {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor yellowColor];
    
    _taskTextLabel= [[UILabel alloc] init];
    _taskTextLabel.backgroundColor = [UIColor redColor];
    
    _tickButton = [[UIButton alloc] init];
    _tickButton.backgroundColor = [UIColor cyanColor];
    [_tickButton addTarget:self action:@selector(changeSelectedState:) forControlEvents:UIControlEventTouchUpInside];
    
    [_containerView addSubview:_taskTextLabel];
    [_containerView addSubview:_tickButton];
    [self addSubview:_containerView];
    
}

-(void) changeSelectedState:(UIButton*)sender{
    if(_isCurrentlySelected){
        _isCurrentlySelected = NO;
        [_tickButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    } else {
        _isCurrentlySelected = YES;
        [_tickButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    }
    
    if ([_buttonRightAlignedDelegate respondsToSelector:@selector(updateCellSelectedStatusWhereStatusIs:forItem:)]) {
        [self.buttonRightAlignedDelegate updateCellSelectedStatusWhereStatusIs:_isCurrentlySelected forItem:_taskTextLabel.text];
    }
}

@end
