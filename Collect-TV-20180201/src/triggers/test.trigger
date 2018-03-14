trigger test on Account(before update) {
	system.debug(trigger.new[0].name);
}