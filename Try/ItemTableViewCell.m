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
@property (nonatomic, strong) UIImageView *tickImageView;

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
    _tickImageView.frame = CGRectMake(10, (_containerView.frame.size.height - kImageViewHeight)/2, kImageViewWidth, kImageViewHeight);
    _taskTextView.frame = CGRectMake(_tickImageView.frame.origin.x + _tickImageView.frame.size.width + 20, 0, 100, CGRectGetHeight(_containerView.frame));

}

#pragma mark - Public methods

- (void)updateCellWithMode:(ItemTableViewCellModel *)model {
    _taskTextView.text = model.titleText;
    if(model.isSelected){
        // change to selected image
    } else {
        // change to default view
    }
}

#pragma mark - Private methods

- (void)makeCustomCell {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor yellowColor];
    
    _taskTextView= [[UITextView alloc] init];
    _taskTextView.backgroundColor = [UIColor redColor];
    // set properties of textview
    
    _tickImageView = [[UIImageView alloc] init];
    _tickImageView.backgroundColor = [UIColor cyanColor];
    // set properties of imageView
    
    [_containerView addSubview:_taskTextView];
    [_containerView addSubview:_tickImageView];
    [self addSubview:_containerView];

}

@end
