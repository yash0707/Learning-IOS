//
//  ItemTableViewCell.m
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ItemTableViewCell.h"

static CGFloat const kImageViewHeight = 30;
static CGFloat const kImageViewWidth = 30;

@interface ItemTableViewCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextView *taskTextView;

@end

@implementation ItemTableViewCellModel
@end

@implementation ItemTableViewCell

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
    _tickButton.frame = CGRectMake(10, (_containerView.frame.size.height - kImageViewHeight)/2, kImageViewWidth, kImageViewHeight);
    _taskTextView.frame = CGRectMake(_tickButton.frame.origin.x + _tickButton.frame.size.width + 20, 0, 100, CGRectGetHeight(_containerView.frame));

}


#pragma mark - Public methods

- (void)updateCellWithModel:(ItemTableViewCellModel *)model {
    _taskTextView.text = model.titleText;
    if(model.isSelected){
        [_tickButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    } else {
        [_tickButton setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    }
}

#pragma mark - Private methods

- (void)makeCustomCell {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor yellowColor];
    
    _taskTextView= [[UITextView alloc] init];
    _taskTextView.backgroundColor = [UIColor redColor];
    // set properties of textview
    
    _tickButton = [[UIButton alloc] init];
    _tickButton.backgroundColor = [UIColor cyanColor];
    // set properties of imageView
    
    [_containerView addSubview:_taskTextView];
    [_containerView addSubview:_tickButton];
    [self addSubview:_containerView];

}

@end
