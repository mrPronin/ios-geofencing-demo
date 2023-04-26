//
//  GeofencingDemoApp.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 25.04.23.
//

import SwiftUI

@main
struct GeofencingDemoApp: App {
    @UIApplicationDelegateAdaptor(GeofencingDemoAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Journey.ListView()
        }
    }
}
