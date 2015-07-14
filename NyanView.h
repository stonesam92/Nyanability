#import <UIKit/UIKit.h>

@interface NyanView : UIView
@property (retain, nonatomic) UIImageView *imageView;
- (void)startAnimating;
- (void)stopAnimating;
@end
