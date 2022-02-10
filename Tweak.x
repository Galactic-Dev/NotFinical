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

// iOS 13
@interface CSNotificationAdjunctListViewController : UIViewController
@property (nonatomic,retain) NSMutableDictionary * identifiersToItems;
-(void)_removeItem:(id)arg1 animated:(BOOL)arg2;
-(void)adjunctListModel:(id)arg1 didRemoveItem:(id)arg2;
-(void)dismissMediaControls:(id)arg1;
-(void)isPlayingChanged;
@end

// iOS 12
@interface SBDashBoardNotificationAdjunctListViewController : UIViewController
@property (nonatomic,retain) NSMutableDictionary * identifiersToItems;
-(void)_removeItem:(id)arg1 animated:(BOOL)arg2;
-(void)adjunctListModel:(id)arg1 didRemoveItem:(id)arg2;
-(void)dismissMediaControls:(id)arg1;
-(void)isPlayingChanged;
@end

// iOS 13
@interface CSMediaControlsViewController : UIViewController
@end

// iOS 12
@interface SBDashBoardMediaControlsViewController : UIViewController
@end

@interface MediaControlsHeaderView : UIView
@end

BOOL isMusicPlaying;
CSNotificationAdjunctListViewController *adjunctListViewController;
SBDashBoardNotificationAdjunctListViewController *adjunctListViewControllerTwelve;

// Prefs values:
BOOL isEnabled;
int swipeDirection;
int numberOfTouches;
BOOL dismissAutomatically;
int dismissDuration;
int timeInterval;

%group iOS13
	%hook CSNotificationAdjunctListViewController
	-(id)init {
		adjunctListViewController = self;
		MRMediaRemoteRegisterForNowPlayingNotifications(dispatch_get_main_queue());
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayingChanged) name:(__bridge NSString *)kMRMediaRemoteNowPlayingApplicationIsPlayingDidChangeNotification object:nil];
		return %orig;
	}
	%new
	-(void)dismissMediaControls:(id)arg1 {
		if(!isMusicPlaying){
		id nowPlayingItem = [self.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
		[self adjunctListModel:[self valueForKey:@"_model"] didRemoveItem:nowPlayingItem];

		// Stole this code from Dave van Wijk :P https://github.com/vanwijkdave/QuitAll
		SBMainSwitcherViewController *mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];
		NSArray *items = mainSwitcher.recentAppLayouts;
			for(SBAppLayout *item in items) {
				SBDisplayItem *displayItem = [[item valueForKey:@"_rolesToLayoutItemsMap"] objectForKey:@1];
				NSString *bundleID = displayItem.bundleIdentifier;
				NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];
                if([mainSwitcher respondsToSelector:@selector(_deleteAppLayoutsMatchingBundleIdentifier:)] && [bundleID isEqualToString:nowPlayingID]) {
					[mainSwitcher _deleteAppLayoutsMatchingBundleIdentifier:bundleID];
				}
				if ([mainSwitcher respondsToSelector:@selector(_deleteAppLayout:forReason:)] && [bundleID isEqualToString: nowPlayingID]) {
					[mainSwitcher _deleteAppLayout:item forReason: 1];
				}

			}
		}
	}
	%new
	-(void)isPlayingChanged {
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
	%end

	%hook CSMediaControlsViewController
	-(void)viewDidLoad {
		%orig;
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
	%new
	-(void)swipeDetected:(UISwipeGestureRecognizer *)swipeGesture {
		[adjunctListViewController dismissMediaControls:nil];
	}
	%end

	// Makes it easier to dismiss when using Sylph. Sylph disables userInteraction on this view by default.
	%hook MediaControlsHeaderView
	-(void)setFrame:(CGRect)arg1 {
		%orig;
		self.userInteractionEnabled = YES;
	}
	%end
%end

%group iOS12
	%hook SBDashBoardNotificationAdjunctListViewController
	-(id)init {
		adjunctListViewControllerTwelve = self;
		MRMediaRemoteRegisterForNowPlayingNotifications(dispatch_get_main_queue());
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayingChanged) name:(__bridge NSString *)kMRMediaRemoteNowPlayingApplicationIsPlayingDidChangeNotification object:nil];
		return %orig;
	}
	%new
	-(void)dismissMediaControls:(id)arg1 {
		if(!isMusicPlaying){
			id nowPlayingItem = [self.identifiersToItems objectForKey:@"SBDashBoardNowPlayingAssertionIdentifier"];
			[self adjunctListModel:[self valueForKey:@"_model"] didRemoveItem:nowPlayingItem];

			// Stole this code from Dave van Wijk :P https://github.com/vanwijkdave/QuitAll
			// "Updated" for iOS 12 by iCraze ;) - @iCrazeiOS
			SBMainSwitcherViewController *mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];
			NSArray *items = mainSwitcher.appLayouts;
			for(SBAppLayout *item in items) {
				SBDisplayItem *displayItem = [item.rolesToLayoutItemsMap objectForKey:@1];
				NSString *bundleID = displayItem.displayIdentifier;
				NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];

				if ([bundleID isEqualToString: nowPlayingID]) {
					[mainSwitcher _quitAppsRepresentedByAppLayout:item forReason:1];
				}

			}
		}
	}
	%new
	-(void)isPlayingChanged {
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
	%end

	%hook SBDashBoardMediaControlsViewController
	-(void)viewDidLoad {
		%orig;
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
	%new
	-(void)swipeDetected:(UISwipeGestureRecognizer *)swipeGesture {
		[adjunctListViewControllerTwelve dismissMediaControls:nil];
	}
	%end

	// Makes it easier to dismiss when using Sylph. Sylph disables userInteraction on this view by default.
	%hook MediaControlsHeaderView
	-(void)setFrame:(CGRect)arg1 {
		%orig;
		self.userInteractionEnabled = YES;
	}
	%end
%end

static void loadPrefs(){
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.galacticdev.notfinicalprefs.plist"];
	isEnabled = [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : YES;
	swipeDirection = [prefs objectForKey:@"swipeDirection"] ? [[prefs objectForKey:@"swipeDirection"] intValue] : 0;
	numberOfTouches = [prefs objectForKey:@"numberOfTouches"] ? [[prefs objectForKey:@"numberOfTouches"] intValue] : 0;
	dismissAutomatically = [prefs objectForKey:@"dismissAutomatically"] ? [[prefs objectForKey:@"dismissAutomatically"] boolValue] : NO;
	dismissDuration = [prefs objectForKey:@"dismissDuration"] ? [[prefs objectForKey:@"dismissDuration"] intValue] : 30;
	timeInterval = [prefs objectForKey:@"timeInterval"] ? [[prefs objectForKey:@"timeInterval"] intValue] : 0;
}


%ctor {
	loadPrefs();
	if(isEnabled){
		if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
			%init(iOS13);
		} else {
			%init(iOS12);
		}
	}
}
