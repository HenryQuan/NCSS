#import "Tweak.h"

// Module list and the size of it
const int size = 5;
Module modules[size] = {
	// free plant
	{0, "", "888641B91501134B958601B9", "F503082A", 4},
	// no cooldown
	{0, "", "F30300AA0200801203008052", "E803271E", 16},
	// op plant
	{0, "", "617E40BD2038201E607E00BD", "2040201E", 4},
	// max sun
	{0, "", "888641B90801130B1F00086B", "E803002A", 8},
	// infinite time for coin skills
	{0, "", "002840BD611E40BD2038201E", "0090221E", 0},
};

// Preference keys, the order MUST match with the module list
NSString *keys[size] = {
	@"free_plant",
	@"no_cooldown",
	@"plant_op",
	@"max_sun",
	@"infinite_time",
};

static void reloadPrefs()
{
	NSLog(@"Notification received from preference");
	NSDictionary *pref = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];
	for (int i = 0; i < size; i++)
	{
		int value = [[pref objectForKey:keys[i]] ?: @(NO) intValue];
		vm_writeData(modules[i], value);
	}
	NSLog(@"Complete reloading");
}

%ctor
{
	NSLog(@"Searching begins...");
	// Find everything
	vm_searchData(modules, size, [AppTool getBinarySize]);
	NSLog(@"Searching completed!");

	// Setup notification
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR(PREF_CHANGED), NULL, CFNotificationSuspensionBehaviorCoalesce);
	reloadPrefs();
}
