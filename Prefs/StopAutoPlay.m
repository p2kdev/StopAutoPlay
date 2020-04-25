#import <Preferences/Preferences.h>

#define prefFilePath @"/User/Library/Preferences/com.imkpatil.stopautoplay.plist"

@interface stopAutoPlayListController : PSListController
- (void)visitPaypal;
- (void)visitTwitter;
@end

@implementation stopAutoPlayListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"StopAutoPlay" target:self] retain];
	}
	return _specifiers;
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
    NSDictionary *prefsettings = [NSDictionary dictionaryWithContentsOfFile:prefFilePath];
    if (!prefsettings[specifier.properties[@"key"]]) {
        return specifier.properties[@"default"];
    }
    return prefsettings[specifier.properties[@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefFilePath]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:prefFilePath atomically:YES];
    //  NSDictionary *powercolorSettings = [NSDictionary dictionaryWithContentsOfFile:powercolorPath];
    CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
    if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}

- (void)visitPaypal {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/patilkiran08/5"]];
}

- (void)visitTwitter {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/imkpatil"]];
}

@end



// vim:ft=objc
