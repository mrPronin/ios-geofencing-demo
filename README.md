# iOS geofencing demo
## Description
- language: Swift
- architecture: MVVM + Combine
- UI: SwiftUI
- location updates in the background, geofencing
- localization & internalization (currently suppotts 'en' and 'de'), example Network+Errors.swift
- zero external dependencies
- property wrappers dependency injection for services
## User stories
- **User story 1.** As a user of the application, I want to be able to start a journey by clicking the "Start" button, and then end the journey by clicking the "Stop" button. It should be one button, but the title should change depending on the mode.
- **User story 2.** As a user of the application, I have to receive a permission request to use location.
- **User story 3.** As a user of the app, every time I open the app, I have to see a list of pictures from Flickr that are tied to the user's location during the journey every 100 meters. New pictures should be at the top. Whenever the user takes a look at their phone, they see the most recent picture and can scroll through a stream of pictures that shows where the user has been.
- **User story 4.** As a user of the app, I should be able to use the travel mode for at least a two-hour walk.

## ENVIRONMENT

For the project to work correctly, you need to set the environment variable FLICKR_API_KEY.
![Edit scheme to setup environment variable](https://user-images.githubusercontent.com/3205852/236679245-b7d5525a-23c9-449e-a9e5-b99ade1ae4a2.png)

## TODO
- [x] define git repository and initial README, .gitignore etc.
- [x] make initial project setup with SwiftUI interface and UIKit AppDelegate
- [x] add scene delegate
- [x] create basic UI start / stop button with SwiftUI
- [x] refactor to MVVM (perhaps temporarily)
- [x] add location usage description and enable location updates in the background on Signing & Capabilities
- [x] add feature to fetch user starting location at the beginning of the journey
- [x] define codable model to keep coordinate and identifier, add helper method to create CLCircularRegion from model
- [x] integrate network service, implement mocket localization service
- [x] implement DI with property wrappers, implement localization service and inject it to network service
- [x] localize app with localization service, error handling in particular
- [x] implement FlickrService to fetch image url from Flickr by location (latitude, longitude)
    - [x] define models - Image and PagedPhotosResponse
    - [x] define flickr photos search endpoint
    - [x] define flickr service protocol
    - [x] implement flickr service and inject it into JourneyViewModel
    - [x] fix issues with base url and flickr response
- [x] add service to persist ordered location list, implement addLocation, getLocations and removeLocations methods
    - [x] define journey storage service protocol
    - [x] implement journey storage service with user defaults
    - [x] implement dependency injection for journey storage service
    - [x] inject journey storage service into JourneyViewModel
- [x] get initial location and store it to the list
- [x] show alert if geofencing is not supported on current device
- [x] define initial monitoring region for user starting location and start monotoring when user exit region
- [x] create 'stopMonitoring' method to remove monitoring region
- [x] implement alert if authorizationStatus != authorizedAlways
- [x] refactor: extract locationManager to separate service - LocationService, handle location errors
- [x] handle location event 'didExitRegion', remove current monitoring region, get current location and save it to the list, define new monitoring region
- [x] add simulated locations, test feature, fix bugs
- [x] implement location log service
- [x] debug didExitRegion on device, small improvements
- [x] create mocked JourneyStorage and feed it with mocked journey json
- [x] fetch images for location list
- [x] clean-up debug and log
- [x] create UI for images list
- [x] create journey view model protocol
- [x] unit-tests
    - [x] implement unit-tests for journey view model
        - [x] create mocked Flickr response and Fllickr mocked service
        - [x] create mocked location service
        - [x] unit-test journey view model: testInitialState
        - [x] unit-test journey view model: testStartStopLocationTracking_Start, testStartStopLocationTracking_Stop
        - [x] unit-test journey view model: testLoadImages and testLoadImagesWithError
    - [x] unit-test endpoint for network
    - [ ] unit-test flickr service (?)
    - [ ] unit-test location service, mock CLLocationManager in LocationService
- [x] feat: use environment variables for sensitive data instead of git
- [ ] fix: improve (?) the accuracy and relevance of images based on geo-location
- [ ] fix: remove images duplication
- [ ] feat: implement background fetch for images
- [ ] add SwiftLint
- [ ] (optional) implement full app localization
- [ ] refactor to TCA
