### Wut?

This is a test app to try to find the best way to force iOS 6 to change the
orientation of a view controller, regardless of device orientation.

The simplest solution is to present a view controller modal, but this app tries
to solve it for a navigation stack.

Currently the app tries to solve it by setting the status bar orientation and
applying the required transform on the view hierarchy, but this feels way to
hacky and has an issue when you physically rotate the device after, which is
pribably due to iOS internally not having updated the current orientation.

The app and its issues can be seen in this video: http://cl.ly/3z2m2T3e401f
