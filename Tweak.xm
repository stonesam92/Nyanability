#import "NyanView.h"
#import <UIKit/UIKit.h>

@interface SBWindow : UIWindow
@end

@interface SBReachabilityManager
+ (BOOL)reachabilitySupported;
@end

NyanView *getNyanView(void){
    static NyanView *sharedView = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedView = [[NyanView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        });
    return sharedView;
}

%hook SBWorkspace

-(void)handleReachabilityModeActivated {
	%orig;
	if ([%c(SBReachabilityManager) reachabilitySupported]) {
		SBWindow *backgroundView = MSHookIvar<SBWindow*>(self,"_reachabilityEffectWindow");
        NyanView *nyanView = getNyanView();
        nyanView.frame = backgroundView.bounds;
        [backgroundView addSubview:nyanView];
        [nyanView startAnimating];
	}
}

-(void)handleReachabilityModeDeactivated {
	%orig;
	if ([%c(SBReachabilityManager) reachabilitySupported]) {
        NyanView *nyanView = getNyanView();
        [nyanView stopAnimating];
        [nyanView removeFromSuperview];
	}
}

%end
