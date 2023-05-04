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
        @Environment(\.scenePhase) var scenePhase
        
        public var body: some View {
            NavigationStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Tap Start button to begin your journey")
                        .padding(.top)
                    Text("Distance: \(viewModel.distance)")
                        .padding()
                    ScrollView {
                        Text(viewModel.logs)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(viewModel.isLocationTrackingEnabled ? "Stop" : "Start" ) {
                            viewModel.startStopLocationTracking()
                        }
                    }
                }
                .padding()
            }
            .alert(item: $viewModel.alert) { alertData in
                Alert(title: Text(alertData.title), message: Text(alertData.message), dismissButton: .default(Text("OK")))
            }
            .onChange(of: scenePhase) { newPhase in
                guard newPhase == .active else { return }
                viewModel.loadLogs()
                viewModel.loadImages()
            }
        }
    }
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        Journey.ListView()
    }
}
