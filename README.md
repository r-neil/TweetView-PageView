# TweetView-PageView
An app that pulls in the latest tweets from a twitter user.  The tweets are then displayed in a UIPageViewController. Up to five Tweets will be displayed.  

<img  src="https://github.com/r-neil/TweetView-PageView/blob/master/README-Img/Screen.png" alt="screenshot" width="320" height="568">


#Requirements
TweetView-PageView was written in Swift 2.0.  Requires a Twitter Account to access tweets.  User must log into Twitter on their device (Settings->Twitter). May not run on older versions of Xcode or iOS.

#Known 'Bug'
When running in the Simulator you may notice a “_BSMachError: (os/kern) invalid capability (20)” or “_BSMachError: (os/kern) invalid name (15)” error in the debug log. Researching this error it appears to be a bug with iOS 9 and the UIKeyboard. It doesn’t affect the app.

