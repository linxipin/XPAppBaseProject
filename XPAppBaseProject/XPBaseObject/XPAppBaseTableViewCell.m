//
//  XPAppBaseTableViewCell.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import "XPAppBaseTableViewCell.h"

@implementation XPAppBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViewInCell];
    }
    return self;
}
- (void)addSubViewInCell {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
