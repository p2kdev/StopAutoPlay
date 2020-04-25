#import "MediaRemote.h"
#include <AVFoundation/AVAudioSession.h>

@interface MPRemoteCommandCenter
  -(void)_pushMediaRemoteCommand:(unsigned)arg1 withOptions:(CFDictionaryRef)arg2 completion:(/*^block*/id)arg3;
@end

static BOOL isEnabled = YES;

NSDictionary *pref = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.imkpatil.stopautoplay.plist"];

%hook MPRemoteCommandCenter

  -(void)_pushMediaRemoteCommand:(unsigned)arg1 withOptions:(CFDictionaryRef)arg2 completion:(/*^block*/id)arg3
  {
    BOOL isOtherAudioPlaying = [[AVAudioSession sharedInstance] isOtherAudioPlaying];

    if(arg1 == 0 && isEnabled && !isOtherAudioPlaying)
    {
      arg1 = 1;
      //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startForwardSeek) userInfo:nil repeats:NO];
      //return;
    }

    %orig;
  }

%end

static void reloadSettings()
{
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.imkpatil.stopautoplay.plist"];
  if(prefs)
  {
      isEnabled = [prefs objectForKey:@"twkEnabled"] ? [[prefs objectForKey:@"twkEnabled"] boolValue] : isEnabled;
  }
  [prefs release];
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.imkpatil.stopautoplay.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  reloadSettings();
}
