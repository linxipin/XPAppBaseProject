//
//  XPAppMainView.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import "XPAppMainView.h"
#import "XPAppBaseTableViewCell.h"

@interface XPAppMainView ()

/**tableView*/
@property (strong, nonatomic) UITableView *tableView;

/**XPDataSource*/
@property (strong, nonatomic) XPDataSource *tableViewDataSource;

@end

@implementation XPAppMainView

- (void)addSubviewInThisView {
    [self addSubview:self.tableView];
    /**tableView*/
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

/**属性懒加载*/
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self.tableViewDataSource;
        _tableView.dataSource=self.tableViewDataSource;
        // _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[XPAppBaseTableViewCell class] forCellReuseIdentifier:@"XPAppBaseTableViewCell"];

    }
    return _tableView;
}

/**tableViewDataSource*/
- (XPDataSource *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[XPDataSource alloc]initWithIdentifier:@"XPAppBaseTableViewCell" configureBlock:^(XPAppBaseTableViewCell *cell, id model, NSIndexPath *indexPath) {
            cell.indexPath = indexPath;
            cell.textLabel.text =@"哈哈哈";
        } selectBlock:^(NSIndexPath *indexPath) {
            NSLog(@"google");
        }];
        _tableViewDataSource.dataArray = @[@"",@"",@""].mutableCopy;
    }
    return _tableViewDataSource;
}



@end
