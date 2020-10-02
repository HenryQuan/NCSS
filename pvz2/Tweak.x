#import "Tweak.h"

vm_address_t cooldown = 0;
BOOL score;

static void reloadPrefs() {
	// NSDictionary *pref = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];
}

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR(PREF_CHANGED), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadPrefs();

	// Find addresses and record original value
	cooldown = vm_searchData("F40300AAE10313AAE2070032", [AppTool getBinarySize]) + 8;
	vm_writeData("E803271E", cooldown);
}
