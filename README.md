# ios-geofencing-demo
## User stories
- **User story 1.** As a user of the application, I want to be able to start a journey by clicking the "Start" button, and then end the journey by clicking the "Stop" button. It should be one button, but the title should change depending on the mode.
- **User story 2.** As a user of the application, I have to receive a permission request to use location.
- **User story 3.** As a user of the app, every time I open the app, I have to see a list of pictures from Flickr that are tied to the user's location during the journey every 100 meters. New pictures should be at the top. Whenever the user takes a look at their phone, they see the most recent picture and can scroll through a stream of pictures that shows where the user has been.
- **User story 4.** As a user of the app, I should be able to use the travel mode for at least a two-hour walk.

## TODO
- [x] define git repository and initial README, .gitignore etc.
- [x] make initial project setup with SwiftUI interface and UIKit AppDelegate 
- [ ] create basic UI start / stop button with SwiftUI
- [ ] add location usage description and enable location updates in the background on Signing & Capabilities
- [ ] add feature to fetch user startign location at the beginning of the journey
- [ ] define UserLocation codable model to keep coordinate and identifier, add helper method to create CLCircularRegion from model
- [ ] add feature to fetch image from Flickr that tied to the location using UserLocation model
- [ ] define initial monitoring region for user starting location and start monotoring when user exit region, create 'startMonitoring' method
- [ ] create 'stopMonitoring' method to remove monitoring region
- [ ] add service to store locations list, fetch by id
- [ ] handle location errors
- [ ] handle location event 'didExitRegion', remove current  region, save / get current location, store it, define new region
- [ ] add simulated locations
- [ ] create UI for images list
- [ ] refactor to TCA
