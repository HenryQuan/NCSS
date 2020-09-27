#import "Tweak.h"

vm_address_t addOne = 0;
BOOL score = false;

static void reloadPrefs() {
	NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];

	score = [[settings objectForKey:@"score"] ?: @(NO) boolValue];
  	if (score)
	{
		vm_writeData("2A9D0FB1", addOne);
	}
	else
	{
		vm_writeData("2A0500B1", addOne);
	}
}

// void addListerner(NSString *identifier)
// {
// 	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)identifier, NULL, CFNotificationSuspensionBehaviorCoalesce);
// }

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR(PREF_CHANGED), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	reloadPrefs();

	// Find addresses and record original value
	addOne = vm_searchData("2A0500B1E8779F1AEA2F00F9", [AppTool getBinarySize]);
	NSLog(@"Address: 0x%lx", addOne);
}
