//
//  ContentView.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 25.04.23.
//

import SwiftUI

struct ContentView: View {
    @State var inProgress = false
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(inProgress ? "Start": "Stop") {
                        inProgress.toggle()
                        print("In progress: \(inProgress)")
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
