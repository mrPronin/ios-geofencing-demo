//
//  JourneyListView.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 25.04.23.
//

import SwiftUI

public extension Journey {
    struct ListView<VM: JourneyViewModel>: View {
        @StateObject var viewModel: VM
        @Environment(\.scenePhase) var scenePhase
        
        public init(viewModel: VM) {
            self._viewModel = StateObject(wrappedValue: viewModel)
        }
        
        public var body: some View {
            NavigationView {
                NavigationStack {
                    if !viewModel.journeyExist {
                        VStack {
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            Text("Tap Start button to begin your journey")
                                .padding(.top)
                        }
                        .padding()
                    } else {
                        Text("Your journey")
                            .font(.headline)
                        ZStack {
                            List(viewModel.images) { image in
                                if let url = image.url {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }

                                } else {
                                    Image(systemName: "photo.artframe")
                                        .imageScale(.large)
                                        .foregroundColor(.accentColor)
                                }
                            }
                            if viewModel.isLoading {
                                ProgressView()
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(viewModel.isLocationTrackingEnabled ? "Stop" : "Start" ) {
                            viewModel.startStopLocationTracking()
                        }
                    }
                }
                .alert(item: $viewModel.alert) { alertData in
                    Alert(title: Text(alertData.title), message: Text(alertData.message), dismissButton: .default(Text("OK")))
                }
                .onAppear {
                    viewModel.loadImages()
                }
                .onChange(of: scenePhase) { newPhase in
                    guard newPhase == .active else { return }
                    viewModel.loadImages()
                }
            }
        }
    }
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        Journey.ListView(viewModel: Journey.ViewModel())
    }
}
