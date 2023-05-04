//
//  JourneyViewModel+Test.swift
//  ios-geofencing-demoTests
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import XCTest
import Combine
@testable import ios_geofencing_demo

class JourneyViewModelTest: XCTestCase {
    var sut: Journey.ViewModel!
    var flickrService: Flickr.ServiceMock!
    var journeyStorageService: Journey.StorageServiceMock!
    var locationService: Location.ServiceMock!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        flickrService = Flickr.ServiceMock()
        InjectedValues[\.flickrService] = flickrService
        
        journeyStorageService = Journey.StorageServiceMock()
        InjectedValues[\.journeyStorageProvider] = journeyStorageService
        
        locationService = Location.ServiceMock()
        InjectedValues[\.locationProvider] = locationService
        sut = Journey.ViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        flickrService = nil
        InjectedValues[\.flickrService] = Flickr.Service()
        
        journeyStorageService = nil
        InjectedValues[\.journeyStorageProvider] = Journey.StorageService()
        
        locationService = nil
        InjectedValues[\.locationProvider] = Location.Service()
        sut = nil
        cancellables = []
    }
    
    func testInitialState() {
        // Given
        // When
        // Then
        XCTAssertFalse(sut.isLocationTrackingEnabled)
        XCTAssertNil(sut.alert)
        XCTAssertTrue(sut.images.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isJourneyExist)
    }
    
    func testStartStopLocationTracking_Start() {
        // Given
        XCTAssertFalse(journeyStorageService.removeLocationsCalled)
        XCTAssertFalse(locationService.stopMonitoringCalled)
        XCTAssertFalse(locationService.requestLocationCalled)
        
        // When
        sut.startStopLocationTracking()
        
        // Then
        XCTAssertTrue(sut.isLocationTrackingEnabled)
        XCTAssertTrue(journeyStorageService.removeLocationsCalled)
        XCTAssertTrue(locationService.stopMonitoringCalled)
        XCTAssertTrue(locationService.requestLocationCalled)
    }
    
    func testStartStopLocationTracking_Stop() {
        // Given
        sut.startStopLocationTracking()
        
        // When
        sut.startStopLocationTracking()
        
        // Then
        XCTAssertFalse(sut.isLocationTrackingEnabled)
    }
    
    func testLoadImages() throws {
        // Given
        journeyStorageService.locations = Journey.Location.mocked
        flickrService.images = Flickr.Image.mocked
        let imagesExpectation = XCTestExpectation(description: "Images loaded")
        
        // When
        sut.loadImages()
        
        // Then
        XCTAssertTrue(sut.isLoading)
        
        sut.$images
            .dropFirst() // Drop the initial empty array
            .sink { images in
                if !images.isEmpty {
                    imagesExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [imagesExpectation], timeout: 5.0)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.images.isEmpty)
    }
    
    func testLoadImagesWithError() {
        // Given
        journeyStorageService.locations = Journey.Location.mocked
        flickrService.error = Network.Errors.badRequest
        let imagesExpectation = XCTestExpectation(description: "Images loaded")
        XCTAssertNil(sut.alert)
        
        // When
        sut.loadImages()
        
        // Then
        var result: AlertData?
        XCTAssertTrue(sut.isLoading)
        sut.$alert
            .dropFirst()
            .sink { alertData in
                result = alertData
                imagesExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [imagesExpectation], timeout: 5.0)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(result)
        XCTAssertNotNil(sut.alert)
    }
}
