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
    @State private var hideTabBar = false   // ✅

    var body: some View {
        
        ZStack {
            
            // ✅ Screen background
            Color(hex: "#eeebe4")
                .ignoresSafeArea()
            
            Group {
                switch selected {
                case .home:
                    NavigationStack {
                        HomeView(hideTabBar: $hideTabBar)
                    }
                case .explore:
                    Text("Explore")
                case .scan:
                    Text("AR")
                case .inbox:
                    Text("Inbox")
                case .profile:
                    ProfileView()

//                    Text("Profile")
                }
            }
        }
        // ✅ Correct way to pin bottom bar
        //        .safeAreaInset(edge: .bottom) {
        if !hideTabBar {
                        CustomTabBar(selected: $selected)
                    }
        //        }
    }
}


// MARK: - Preview

#Preview {
    ContentView()
}
