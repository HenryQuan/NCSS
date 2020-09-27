#import "helper.h"

#define PLIST_PATH @"/var/mobile/Library/Preferences/org.github.henryquan.zhao.plist"
static NSString *updateIdentifier = @"zhao.updated";
static vm_address_t addOne = 0;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	BOOL score = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"score"] boolValue];
	if (score) {
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
	addOne = vm_searchData("2A0500B1E8779F1AEA2F00F9", [AppTool getBinarySize]);
    NSLog(@"Address: 0x%lx", addOne);
}
