//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

// MARK: - Root

struct ContentView: View {
    
    @State private var selected: Tab = .home
    
    var body: some View {
        
        ZStack {
            
            // ✅ Screen background
            Color(hex: "#eeebe4")
                .ignoresSafeArea()
            
            Group {
                switch selected {
                case .home:
                    HomeView()
                case .explore:
                    Text("Explore")
                case .scan:
                    Text("AR")
                case .inbox:
                    Text("Inbox")
                case .profile:
                    Text("Profile")
                }
            }
        }
        // ✅ Correct way to pin bottom bar
        //        .safeAreaInset(edge: .bottom) {
        CustomTabBar(selected: $selected)
        //        }
    }
}


// MARK: - Preview

#Preview {
    ContentView()
}
