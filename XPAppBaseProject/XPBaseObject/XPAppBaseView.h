//
//  XPAppBaseView.h
//  XPAppBaseProject
//
//  Created by LinXipin on 2021/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPAppBaseView<__covariant ObjectType> : UIView

/**baseViewModel*/
@property (strong, nonatomic) ObjectType viewModel;


-(instancetype)initWithFrame:(CGRect)frame viewModel:(ObjectType)viewModel;

- (void)addSubviewInThisView;

@end

NS_ASSUME_NONNULL_END
