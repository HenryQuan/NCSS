#import "Tweak.h"

// All addresses
vm_address_t freePlant = 0;
vm_address_t cooldown = 0;
vm_address_t invisiblePlant = 0;
vm_address_t infiniteTime = 0;
vm_address_t maxSun = 0;

// All perferences
BOOL free_plant;
BOOL no_cooldown;
BOOL plant_op;
BOOL max_sun;
BOOL infinite_time;

static void reloadPrefs() {
	NSLog(@"Notification received");
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
