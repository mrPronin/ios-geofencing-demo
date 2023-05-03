//
//  JourneyListView.swift
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
                    Text("Tap Start button to begin your journey")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(viewModel.isLocationTrackingEnabled ? "Stop" : "Start" ) {
                            viewModel.startStopLocationTracking()
//                            print("isLocationTrackingEnabled: \(viewModel.isLocationTrackingEnabled)")
                        }
                    }
                }
                .padding()
            }
            .alert(item: $viewModel.alert) { alertData in
                Alert(title: Text(alertData.title), message: Text(alertData.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        Journey.ListView()
    }
}
