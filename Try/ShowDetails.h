//
//  ShowDetails.h
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowDetails;
@protocol ShowDetailsDelegate <NSObject>
- (void) getUpdatedDataFrom:(ShowDetails*)showDetails whereDataIs:(NSString*)data atIndex:(long)indexOfElement;
@end


@interface ShowDetails : UIViewController

@property (nonatomic,weak) id<ShowDetailsDelegate> delegate;
@property (nonatomic, assign) NSString *itemDetail;
@property (nonatomic) long indexItem;

@end

