//
//  XPAppBaseTableViewCell.h
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPAppBaseTableViewCell : UITableViewCell

/**indexPath*/
@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)addSubViewInCell;

@end

NS_ASSUME_NONNULL_END
