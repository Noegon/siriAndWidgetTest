# siriAndWidgetTest

Test App for iOS 14 widgets and Siri shortcuts

### Update 13/11/2020

1. Changed progect structure
2. Changed Widget timeline creation principle from `.never` to `.after` to refresh Widget time after time constantly.
3. Added missing entitlements.

#### Notes (after tries to update widget manually):

1. Widget refreshes according it timeline settings correctly. App Group is working fine.
2. When Host Application is in background mode, manuall calling of `WidgetCenter.shared.reloadTimelines(:_)` in SiriSuggestion extension has no effect.
3. Adding new words using Shortcuts app and with Siri voice commands work fine as well. Words appears in UserDefaults shared container that could be seen after launching an App.
4. I assume that it is valid behavior. When launching on Xcode in debug mode, there is no OS limitations for Widget refresh. Also there is no limitations for refresh Widget when App is in foreground of executing background task. But in other cases only iOS decides if Widget could be refreshed. It follows from [documentstion](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date).
5. Minimal real refresh interval is about 15 minutes, so using bacground fetch is useless because minimal interval for it is about 30 minutes.
6. Tried to use Darwin interprocess notifications (sending notiffication after successful ). But when an App is in background it is useless. And when App in foreground,  `WidgetCenter.shared.reloadTimelines(:_)` method could be used. 

**Summary**: I cannot improve task to keep Widget up-to-date with Siri shortcuts after adding every new word to the list (without direct opening of the application). Or I don't know how, or it is because specific iOS limitations.
