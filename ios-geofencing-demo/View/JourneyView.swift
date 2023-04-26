//
//  JourneyView.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 25.04.23.
//

import SwiftUI

public extension Journey {
    struct ListView: View {
        @StateObject var viewModel = ViewModel()
        public var body: some View {
            NavigationStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(viewModel.isLocationTrackingEnabled ? "Stop" : "Start" ) {
                            viewModel.startStopLocationTracking()
                            print("isLocationTrackingEnabled: \(viewModel.isLocationTrackingEnabled)")
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        Journey.ListView()
    }
}
