//
//  ItemTableViewCell2.m
//  Try
//
//  Created by Admin on 12/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ItemTableViewCell2.h"

static CGFloat const kImageViewHeight = 30;
static CGFloat const kImageViewWidth = 30;

@interface ItemTableViewCell2()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextView *taskTextView;
@property (nonatomic, strong) UIButton *tickButton;
@property (nonatomic,assign) BOOL isCurrentlySelected;


@end

@implementation ItemTableViewCellModel2
@end

@implementation ItemTableViewCell2

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
    _taskTextView.frame = CGRectMake(0, 0, 100, CGRectGetHeight(_containerView.frame));
    
}

#pragma mark - Public methods

- (void)updateCellWithModel:(ItemTableViewCellModel2 *)model {
    _taskTextView.text = model.titleText;
    
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
    
    _taskTextView= [[UITextView alloc] init];
    _taskTextView.backgroundColor = [UIColor redColor];
    [_taskTextView setEditable:NO];

    // set properties of textview
    
    _tickButton = [[UIButton alloc] init];
    _tickButton.backgroundColor = [UIColor cyanColor];
    [_tickButton addTarget:self action:@selector(changeSelectedState:) forControlEvents:UIControlEventTouchUpInside];

    // set properties of imageView
    
    [_containerView addSubview:_taskTextView];
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
    
    BOOL selectedStatusToSentBack = _isCurrentlySelected;
    [self.delegate2 updateCellSelectedStatus2:self whereStatusIs:selectedStatusToSentBack forItem:_taskTextView.text];
    
}

@end
