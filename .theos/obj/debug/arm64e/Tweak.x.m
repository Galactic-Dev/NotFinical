#line 1 "Tweak.x"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MediaRemote.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface SBDisplayItem: NSObject
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;
@property (nonatomic,copy,readonly) NSString * displayIdentifier;
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;
@end

@interface SBMediaController : NSObject
@property (nonatomic, weak,readonly) SBApplication * nowPlayingApplication;
+(id)sharedInstance;
@end

@interface SBMainSwitcherViewController: UIViewController
+ (id)sharedInstance;
-(id)recentAppLayouts;
-(id)appLayouts;
-(void)_rebuildAppListCache;
-(void)_destroyAppListCache;
-(void)_removeCardForDisplayIdentifier:(id)arg1 ;
-(void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
-(void)_quitAppsRepresentedByAppLayout:(id)arg1 forReason:(long long)arg2;
-(void)_deleteAppLayoutsMatchingBundleIdentifier:(NSString *)arg1;
@end

@interface SBAppLayout:NSObject
@property (nonatomic,copy) NSDictionary * rolesToLayoutItemsMap;
@end

@interface SBRecentAppLayouts: NSObject
+ (id)sharedInstance;
-(id)_recentsFromPrefs;
-(void)remove:(SBAppLayout* )arg1;
-(void)removeAppLayouts:(id)arg1 ;
@end


@interface CSNotificationAdjunctListViewController : UIViewController
@property (nonatomic,retain) NSMutableDictionary * identifiersToItems;
-(void)_removeItem:(id)arg1 animated:(BOOL)arg2;
-(void)adjunctListModel:(id)arg1 didRemoveItem:(id)arg2;
-(void)dismissMediaControls:(id)arg1;
-(void)isPlayingChanged;
@end


@interface SBDashBoardNotificationAdjunctListViewController : UIViewController
@property (nonatomic,retain) NSMutableDictionary * identifiersToItems;
-(void)_removeItem:(id)arg1 animated:(BOOL)arg2;
-(void)adjunctListModel:(id)arg1 didRemoveItem:(id)arg2;
-(void)dismissMediaControls:(id)arg1;
-(void)isPlayingChanged;
@end


@interface CSMediaControlsViewController : UIViewController
@end


@interface SBDashBoardMediaControlsViewController : UIViewController
@end

@interface MediaControlsHeaderView : UIView
@end

BOOL isMusicPlaying;
CSNotificationAdjunctListViewController *adjunctListViewController;
SBDashBoardNotificationAdjunctListViewController *adjunctListViewControllerTwelve;


BOOL isEnabled;
int swipeDirection;
int numberOfTouches;
BOOL dismissAutomatically;
int dismissDuration;
int timeInterval;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBMainSwitcherViewController; @class SBDashBoardNotificationAdjunctListViewController; @class SBDashBoardMediaControlsViewController; @class MediaControlsHeaderView; @class CSNotificationAdjunctListViewController; @class CSMediaControlsViewController; @class SBMediaController; 

static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBMediaController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBMediaController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBMainSwitcherViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBMainSwitcherViewController"); } return _klass; }
#line 85 "Tweak.x"
static CSNotificationAdjunctListViewController* (*_logos_orig$iOS13$CSNotificationAdjunctListViewController$init)(_LOGOS_SELF_TYPE_INIT CSNotificationAdjunctListViewController*, SEL) _LOGOS_RETURN_RETAINED; static CSNotificationAdjunctListViewController* _logos_method$iOS13$CSNotificationAdjunctListViewController$init(_LOGOS_SELF_TYPE_INIT CSNotificationAdjunctListViewController*, SEL) _LOGOS_RETURN_RETAINED; static void _logos_method$iOS13$CSNotificationAdjunctListViewController$dismissMediaControls$(_LOGOS_SELF_TYPE_NORMAL CSNotificationAdjunctListViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$iOS13$CSNotificationAdjunctListViewController$isPlayingChanged(_LOGOS_SELF_TYPE_NORMAL CSNotificationAdjunctListViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$iOS13$CSMediaControlsViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS13$CSMediaControlsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS13$CSMediaControlsViewController$swipeDetected$(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsViewController* _LOGOS_SELF_CONST, SEL, UISwipeGestureRecognizer *); static void (*_logos_orig$iOS13$MediaControlsHeaderView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL MediaControlsHeaderView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$iOS13$MediaControlsHeaderView$setFrame$(_LOGOS_SELF_TYPE_NORMAL MediaControlsHeaderView* _LOGOS_SELF_CONST, SEL, CGRect); 
	
	static CSNotificationAdjunctListViewController* _logos_method$iOS13$CSNotificationAdjunctListViewController$init(_LOGOS_SELF_TYPE_INIT CSNotificationAdjunctListViewController* __unused self, SEL __unused _cmd) _LOGOS_RETURN_RETAINED {
		adjunctListViewController = self;
		MRMediaRemoteRegisterForNowPlayingNotifications(dispatch_get_main_queue());
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayingChanged) name:(__bridge NSString *)kMRMediaRemoteNowPlayingApplicationIsPlayingDidChangeNotification object:nil];
		return _logos_orig$iOS13$CSNotificationAdjunctListViewController$init(self, _cmd);
	}
	
	static void _logos_method$iOS13$CSNotificationAdjunctListViewController$dismissMediaControls$(_LOGOS_SELF_TYPE_NORMAL CSNotificationAdjunctListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
		if(!isMusicPlaying){
		id nowPlayingItem = [self.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
		[self adjunctListModel:[self valueForKey:@"_model"] didRemoveItem:nowPlayingItem];

		
		SBMainSwitcherViewController *mainSwitcher = [_logos_static_class_lookup$SBMainSwitcherViewController() sharedInstance];
		NSArray *items = mainSwitcher.recentAppLayouts;
			for(SBAppLayout *item in items) {
				SBDisplayItem *displayItem = [[item valueForKey:@"_rolesToLayoutItemsMap"] objectForKey:@1];
				NSString *bundleID = displayItem.bundleIdentifier;
				NSString *nowPlayingID = [[[_logos_static_class_lookup$SBMediaController() sharedInstance] nowPlayingApplication] bundleIdentifier];
				if([mainSwitcher respondsToSelector:@selector(_deleteAppLayoutsMatchingBundleIdentifier:)]) {
					[mainSwitcher _deleteAppLayoutsMatchingBundleIdentifier:bundleID];
				}
				if ([mainSwitcher respondsToSelector:@selector(_deleteAppLayout:forReason:)] && [bundleID isEqualToString: nowPlayingID]) {
					[mainSwitcher _deleteAppLayout:item forReason: 1];
				}

			}
		}
	}
	
	static void _logos_method$iOS13$CSNotificationAdjunctListViewController$isPlayingChanged(_LOGOS_SELF_TYPE_NORMAL CSNotificationAdjunctListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		MRMediaRemoteGetNowPlayingApplicationIsPlaying(dispatch_get_main_queue(), ^(Boolean isPlaying){
			isMusicPlaying = isPlaying;
			if(dismissAutomatically){
				int timerTime;
				switch (timeInterval) {
				case 0:
					timerTime = dismissDuration;
					break;
				case 1:
					timerTime = dismissDuration * 60;
					break;
				case 2:
					timerTime = dismissDuration * 60 * 60;
					break;
				}
				[NSTimer scheduledTimerWithTimeInterval:(CGFloat)timerTime target:self selector:@selector(dismissMediaControls:) userInfo:nil repeats:NO];
			}
		});
	}
	

	
	static void _logos_method$iOS13$CSMediaControlsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		_logos_orig$iOS13$CSMediaControlsViewController$viewDidLoad(self, _cmd);
		UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
		switch (swipeDirection) {
		case 0 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
			break;
		case 1 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
			break;
		case 2 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
			break;
		case 3 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
			break;
		}

		switch (numberOfTouches) {
		case 0 :
			[swipeRecognizer setNumberOfTouchesRequired:1];
			break;
		case 1 :
			[swipeRecognizer setNumberOfTouchesRequired:2];
			break;
		case 2 :
			[swipeRecognizer setNumberOfTouchesRequired:3];
			break;
		}

		[self.view addGestureRecognizer:swipeRecognizer];
	}
	
	static void _logos_method$iOS13$CSMediaControlsViewController$swipeDetected$(_LOGOS_SELF_TYPE_NORMAL CSMediaControlsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UISwipeGestureRecognizer * swipeGesture) {
		[adjunctListViewController dismissMediaControls:nil];
	}
	

	
	
	static void _logos_method$iOS13$MediaControlsHeaderView$setFrame$(_LOGOS_SELF_TYPE_NORMAL MediaControlsHeaderView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1) {
		_logos_orig$iOS13$MediaControlsHeaderView$setFrame$(self, _cmd, arg1);
		self.userInteractionEnabled = YES;
	}
	


static SBDashBoardNotificationAdjunctListViewController* (*_logos_orig$iOS12$SBDashBoardNotificationAdjunctListViewController$init)(_LOGOS_SELF_TYPE_INIT SBDashBoardNotificationAdjunctListViewController*, SEL) _LOGOS_RETURN_RETAINED; static SBDashBoardNotificationAdjunctListViewController* _logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$init(_LOGOS_SELF_TYPE_INIT SBDashBoardNotificationAdjunctListViewController*, SEL) _LOGOS_RETURN_RETAINED; static void _logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$dismissMediaControls$(_LOGOS_SELF_TYPE_NORMAL SBDashBoardNotificationAdjunctListViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$isPlayingChanged(_LOGOS_SELF_TYPE_NORMAL SBDashBoardNotificationAdjunctListViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$iOS12$SBDashBoardMediaControlsViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBDashBoardMediaControlsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS12$SBDashBoardMediaControlsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBDashBoardMediaControlsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$iOS12$SBDashBoardMediaControlsViewController$swipeDetected$(_LOGOS_SELF_TYPE_NORMAL SBDashBoardMediaControlsViewController* _LOGOS_SELF_CONST, SEL, UISwipeGestureRecognizer *); static void (*_logos_orig$iOS12$MediaControlsHeaderView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL MediaControlsHeaderView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$iOS12$MediaControlsHeaderView$setFrame$(_LOGOS_SELF_TYPE_NORMAL MediaControlsHeaderView* _LOGOS_SELF_CONST, SEL, CGRect); 
	
	static SBDashBoardNotificationAdjunctListViewController* _logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$init(_LOGOS_SELF_TYPE_INIT SBDashBoardNotificationAdjunctListViewController* __unused self, SEL __unused _cmd) _LOGOS_RETURN_RETAINED {
		adjunctListViewControllerTwelve = self;
		MRMediaRemoteRegisterForNowPlayingNotifications(dispatch_get_main_queue());
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayingChanged) name:(__bridge NSString *)kMRMediaRemoteNowPlayingApplicationIsPlayingDidChangeNotification object:nil];
		return _logos_orig$iOS12$SBDashBoardNotificationAdjunctListViewController$init(self, _cmd);
	}
	
	static void _logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$dismissMediaControls$(_LOGOS_SELF_TYPE_NORMAL SBDashBoardNotificationAdjunctListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
		if(!isMusicPlaying){
			id nowPlayingItem = [self.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
			[self adjunctListModel:[self valueForKey:@"_model"] didRemoveItem:nowPlayingItem];

			
			
			SBMainSwitcherViewController *mainSwitcher = [_logos_static_class_lookup$SBMainSwitcherViewController() sharedInstance];
			NSArray *items = mainSwitcher.appLayouts;
			for(SBAppLayout *item in items) {
				SBDisplayItem *displayItem = [item.rolesToLayoutItemsMap objectForKey:@1];
				NSString *bundleID = displayItem.displayIdentifier;
				NSString *nowPlayingID = [[[_logos_static_class_lookup$SBMediaController() sharedInstance] nowPlayingApplication] bundleIdentifier];

				if ([bundleID isEqualToString: nowPlayingID]) {
					[mainSwitcher _quitAppsRepresentedByAppLayout:item forReason:1];
				}

			}
		}
	}
	
	static void _logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$isPlayingChanged(_LOGOS_SELF_TYPE_NORMAL SBDashBoardNotificationAdjunctListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		MRMediaRemoteGetNowPlayingApplicationIsPlaying(dispatch_get_main_queue(), ^(Boolean isPlaying){
			isMusicPlaying = isPlaying;
			if(dismissAutomatically){
				int timerTime;
				switch (timeInterval) {
				case 0:
					timerTime = dismissDuration;
					break;
				case 1:
					timerTime = dismissDuration * 60;
					break;
				case 2:
					timerTime = dismissDuration * 60 * 60;
					break;
				}
				[NSTimer scheduledTimerWithTimeInterval:(CGFloat)timerTime target:self selector:@selector(dismissMediaControls:) userInfo:nil repeats:NO];
			}
		});
	}
	

	
	static void _logos_method$iOS12$SBDashBoardMediaControlsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBDashBoardMediaControlsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		_logos_orig$iOS12$SBDashBoardMediaControlsViewController$viewDidLoad(self, _cmd);
		UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
		switch (swipeDirection) {
		case 0 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
			break;
		case 1 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
			break;
		case 2 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
			break;
		case 3 :
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
			break;
		}

		switch (numberOfTouches) {
		case 0 :
			[swipeRecognizer setNumberOfTouchesRequired:1];
			break;
		case 1 :
			[swipeRecognizer setNumberOfTouchesRequired:2];
			break;
		case 2 :
			[swipeRecognizer setNumberOfTouchesRequired:3];
			break;
		}

		[self.view addGestureRecognizer:swipeRecognizer];
	}
	
	static void _logos_method$iOS12$SBDashBoardMediaControlsViewController$swipeDetected$(_LOGOS_SELF_TYPE_NORMAL SBDashBoardMediaControlsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UISwipeGestureRecognizer * swipeGesture) {
		[adjunctListViewControllerTwelve dismissMediaControls:nil];
	}
	

	
	
	static void _logos_method$iOS12$MediaControlsHeaderView$setFrame$(_LOGOS_SELF_TYPE_NORMAL MediaControlsHeaderView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1) {
		_logos_orig$iOS12$MediaControlsHeaderView$setFrame$(self, _cmd, arg1);
		self.userInteractionEnabled = YES;
	}
	


static void loadPrefs(){
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.galacticdev.notfinicalprefs.plist"];
	isEnabled = [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : YES;
	swipeDirection = [prefs objectForKey:@"swipeDirection"] ? [[prefs objectForKey:@"swipeDirection"] intValue] : 0;
	numberOfTouches = [prefs objectForKey:@"numberOfTouches"] ? [[prefs objectForKey:@"numberOfTouches"] intValue] : 0;
	dismissAutomatically = [prefs objectForKey:@"dismissAutomatically"] ? [[prefs objectForKey:@"dismissAutomatically"] boolValue] : NO;
	dismissDuration = [prefs objectForKey:@"dismissDuration"] ? [[prefs objectForKey:@"dismissDuration"] intValue] : 30;
	timeInterval = [prefs objectForKey:@"timeInterval"] ? [[prefs objectForKey:@"timeInterval"] intValue] : 0;
}


static __attribute__((constructor)) void _logosLocalCtor_92845753(int __unused argc, char __unused **argv, char __unused **envp) {
	loadPrefs();
	if(isEnabled){
		if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
			{Class _logos_class$iOS13$CSNotificationAdjunctListViewController = objc_getClass("CSNotificationAdjunctListViewController"); { MSHookMessageEx(_logos_class$iOS13$CSNotificationAdjunctListViewController, @selector(init), (IMP)&_logos_method$iOS13$CSNotificationAdjunctListViewController$init, (IMP*)&_logos_orig$iOS13$CSNotificationAdjunctListViewController$init);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS13$CSNotificationAdjunctListViewController, @selector(dismissMediaControls:), (IMP)&_logos_method$iOS13$CSNotificationAdjunctListViewController$dismissMediaControls$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS13$CSNotificationAdjunctListViewController, @selector(isPlayingChanged), (IMP)&_logos_method$iOS13$CSNotificationAdjunctListViewController$isPlayingChanged, _typeEncoding); }Class _logos_class$iOS13$CSMediaControlsViewController = objc_getClass("CSMediaControlsViewController"); { MSHookMessageEx(_logos_class$iOS13$CSMediaControlsViewController, @selector(viewDidLoad), (IMP)&_logos_method$iOS13$CSMediaControlsViewController$viewDidLoad, (IMP*)&_logos_orig$iOS13$CSMediaControlsViewController$viewDidLoad);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UISwipeGestureRecognizer *), strlen(@encode(UISwipeGestureRecognizer *))); i += strlen(@encode(UISwipeGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS13$CSMediaControlsViewController, @selector(swipeDetected:), (IMP)&_logos_method$iOS13$CSMediaControlsViewController$swipeDetected$, _typeEncoding); }Class _logos_class$iOS13$MediaControlsHeaderView = objc_getClass("MediaControlsHeaderView"); { MSHookMessageEx(_logos_class$iOS13$MediaControlsHeaderView, @selector(setFrame:), (IMP)&_logos_method$iOS13$MediaControlsHeaderView$setFrame$, (IMP*)&_logos_orig$iOS13$MediaControlsHeaderView$setFrame$);}}
		} else {
			{Class _logos_class$iOS12$SBDashBoardNotificationAdjunctListViewController = objc_getClass("SBDashBoardNotificationAdjunctListViewController"); { MSHookMessageEx(_logos_class$iOS12$SBDashBoardNotificationAdjunctListViewController, @selector(init), (IMP)&_logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$init, (IMP*)&_logos_orig$iOS12$SBDashBoardNotificationAdjunctListViewController$init);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS12$SBDashBoardNotificationAdjunctListViewController, @selector(dismissMediaControls:), (IMP)&_logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$dismissMediaControls$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS12$SBDashBoardNotificationAdjunctListViewController, @selector(isPlayingChanged), (IMP)&_logos_method$iOS12$SBDashBoardNotificationAdjunctListViewController$isPlayingChanged, _typeEncoding); }Class _logos_class$iOS12$SBDashBoardMediaControlsViewController = objc_getClass("SBDashBoardMediaControlsViewController"); { MSHookMessageEx(_logos_class$iOS12$SBDashBoardMediaControlsViewController, @selector(viewDidLoad), (IMP)&_logos_method$iOS12$SBDashBoardMediaControlsViewController$viewDidLoad, (IMP*)&_logos_orig$iOS12$SBDashBoardMediaControlsViewController$viewDidLoad);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UISwipeGestureRecognizer *), strlen(@encode(UISwipeGestureRecognizer *))); i += strlen(@encode(UISwipeGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS12$SBDashBoardMediaControlsViewController, @selector(swipeDetected:), (IMP)&_logos_method$iOS12$SBDashBoardMediaControlsViewController$swipeDetected$, _typeEncoding); }Class _logos_class$iOS12$MediaControlsHeaderView = objc_getClass("MediaControlsHeaderView"); { MSHookMessageEx(_logos_class$iOS12$MediaControlsHeaderView, @selector(setFrame:), (IMP)&_logos_method$iOS12$MediaControlsHeaderView$setFrame$, (IMP*)&_logos_orig$iOS12$MediaControlsHeaderView$setFrame$);}}
		}
	}
}
