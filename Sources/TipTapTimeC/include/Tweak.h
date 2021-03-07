#import <UIKit/UIKit.h>

@interface _UIStatusBarStringView: UILabel
@end

@interface _UIStatusBarTimeItem
@property (nonatomic, strong, readwrite) _UIStatusBarStringView *timeView;
@property (nonatomic, strong, readwrite) _UIStatusBarStringView *shortTimeView;
@property (nonatomic, strong, readwrite) _UIStatusBarStringView *pillTimeView;
@property (nonatomic, strong, readwrite) _UIStatusBarStringView *dateView;
@end
