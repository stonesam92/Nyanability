#import "NyanView.h"

static NSString *IMG_FMT = @"/Library/Application Support/Nyanability/nyan-%d.png";

@implementation NyanView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i < 13; i++) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:IMG_FMT, i]]];
        }
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageView.animationImages = images;
        self.imageView.animationDuration = 1.0;
        self.imageView.animationRepeatCount = 0;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        [self _setupConstraints];
    }
    return self;
}

- (void)_setupConstraints {
    for (NSString *constraintString in @[@"H:|-(15)-[img]-(15)-|", @"V:|-(15)-[img]-(15)-|"]) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraintString
                     options:0
                     metrics:0
                       views:@{@"img" : self.imageView}]];
    }
}

- (void)startAnimating {
    [self.imageView startAnimating];
}

- (void)stopAnimating {
    [self.imageView stopAnimating];
}
@end
