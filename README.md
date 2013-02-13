### Wut?

This is a test app to try to find the best way to force iOS 6 to change the
orientation of a view controller, regardless of device orientation.

The only know ways are:
* Present a view controller modally.
* Change status bar orientation and apply rotation transforms manually.

Currently the app tries to solve it by modally presenting a dummy view
controller (with the same supported interface orientations as the view
controller that the user actually wants to add to the navigation stack) and
immediately dismissing it afterwards.

While this works, there is one issue with this approach. After a force-change,
the first non-force-change will have a slightly incorrect animation.

The app and the issues can be seen in this video: http://cl.ly/3z2m2T3e401f
