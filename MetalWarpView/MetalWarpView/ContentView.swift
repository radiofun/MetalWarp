//
//  ContentView.swift
//  MetalWarpView
//
//  Created by Minsang Choi on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CircleView()
                .tabItem {
                    Label("Circle", systemImage: "circle")
                }
            
            ImageWarpView()
                .tabItem {
                    Label("Picture", systemImage: "photo")
                }
        }
        .tint(.white)
    }
}

#Preview {
    ContentView()
}
