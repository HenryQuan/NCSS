#import "helper/Tools.h"
#import "helper/vm_tool.h"

#define PLIST_PATH @"/Library/PreferenceLoader/Preferences/zhao.plist"
static NSString * updateIdentifier = @"zhao.updated";
static vm_address_t addOne = 0;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSLog(@"Notification received");
	NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
	BOOL enabled = [[pref valueForKey:@"score"] boolValue];
	NSLog(@"Enabled is %d", enabled);
	if (enabled) {
		vm_writeData("2A9D0FB1", addOne);
	} else {
		vm_writeData("2A0500B1", addOne);
	}
}


void addListerner(NSString *identifier) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
									notificationCallback, (CFStringRef)identifier, NULL, 
									CFNotificationSuspensionBehaviorCoalesce);
}

%ctor {
	// Set variables on start up
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	// Register for 'PostNotification' notifications
	addListerner(updateIdentifier);

	// Add any personal initializations
	addOne = vm_searchData("2A0500B1E8779F1AEA2F00F9", [Tools getBinarySize]);
    NSLog(@"Address: 0x%lx", addOne);
}
