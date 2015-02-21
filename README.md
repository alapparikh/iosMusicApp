# iosMusicApp
iOS app in Objective-C that enables a user to act as a DJ. 5 music instruments are available (as 5 separate music loops) which can be started and stopped individually. These loops were composed on Garageband. The user is encouraged to synchronize these loops to form a wholesome sound - to aid in this synchronization a basic visualizer is programmed to keep beat with the first instrument to start playing. The AVAudioPlayer kit is used to play music loops and UIBezierPath to draw out graphics.
The app also records the amount of time a certain user spends playing music, and persistently stores this data using NSUserDefaults. 
Extensions to this app include being able to start and stop recording sound. 
