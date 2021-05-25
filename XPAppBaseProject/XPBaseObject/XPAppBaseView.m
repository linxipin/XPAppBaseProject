//
//  XPAppBaseView.m
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import "XPAppBaseView.h"

@implementation XPAppBaseView

-(instancetype)initWithFrame:(CGRect)frame viewModel:(id)viewModel
{
    if (self = [super initWithFrame:frame]) {
        self.viewModel = viewModel;
        [self addSubviewInThisView];
        NSLog(@"%@", self);
    }
    return self;
}
- (void)addSubviewInThisView {
    
}

@end
