#import "Tweak.h"

vm_address_t addOne = 0;
BOOL score;

static void reloadPrefs() {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500), dispatch_get_main_queue(), ^{
		NSDictionary *pref = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];
		NSLog(@"Pref: %@", [pref description]);
		score = [[pref objectForKey:@"score"] ?: @(NO) boolValue];
		NSLog(@"Score: %d", score);
		if (score)
		{
			vm_writeData("2A9D0FB1", addOne);
		}
		else
		{
			vm_writeData("2A0500B1", addOne);
		}
	});
}

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR(PREF_CHANGED), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadPrefs();

	// Find addresses and record original value
	addOne = vm_searchData("2A0500B1E8779F1AEA2F00F9", [AppTool getBinarySize]);
	NSLog(@"Address: 0x%lx", addOne);
}
