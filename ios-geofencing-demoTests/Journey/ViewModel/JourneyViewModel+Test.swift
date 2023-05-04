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
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        InjectedValues[\.flickrService] = Flickr.ServiceMock()
        InjectedValues[\.journeyStorageProvider] = Journey.StorageServiceMock()
        InjectedValues[\.locationProvider] = Location.ServiceMock()
        sut = Journey.ViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        InjectedValues[\.flickrService] = Flickr.Service()
        InjectedValues[\.journeyStorageProvider] = Journey.StorageService()
        InjectedValues[\.locationProvider] = Location.Service()
        sut = nil
    }
    
    func testInitialState() {
        XCTAssertFalse(sut.isLocationTrackingEnabled)
        XCTAssertNil(sut.alert)
        XCTAssertTrue(sut.images.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isJourneyExist)
    }
}
