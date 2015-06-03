# Web API Calls in an iOS app

- a simple example of several ways you can get data from a web api in objective-c

#API
- just used the openweathermap.org API

#Branches

- master uses dataWithContentsOfUrl on the main thread
- usingGCD uses dataWithContentsOfUrl on a background thread
- usingNSURLConnection uses a delegate pattern
- usingNSURLSession uses blocks 
