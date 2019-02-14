//
//  ItemTableViewCellProtocol.h
//  Try
//
//  Created by Admin on 14/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemTableViewCellProtocol <NSObject>

- (void) updateCellSelectedStatusWhereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString*)data;

@end
