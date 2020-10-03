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

	// 4 * 4 means 4 instructions later so it is the offset
	cooldown = vm_searchData("F30300AA0200801203008052", [AppTool getBinarySize]) + 4 * 4;
	NSLog(@"Cooldown - 0x%lx", cooldown);
	vm_writeData("E803271E", cooldown);
}
