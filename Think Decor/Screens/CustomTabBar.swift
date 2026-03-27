//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI


// MARK: - Custom Bottom Bar

struct CustomTabBar: View {

    @Binding var selected: Tab

    var body: some View {
        
        ZStack(alignment: .bottom) {

            HStack {
                
                tabButton(.home)
                tabButton(.explore)
                
                Spacer(minLength: 60)
//                tabButton(.scan)

                tabButton(.inbox)
                tabButton(.profile)
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            .padding(.bottom, 0)
//            .background(
//                Color.white
//                    .clipShape(RoundedRectangle(cornerRadius: 24))
//                    .shadow(color: .black.opacity(0.08), radius: 6, y: -2)
//            )
            
            // Center button
            Button {
                selected = .scan
            } label: {
                ZStack {
                    Circle()
                        .fill(Color(hex: "#00594E"))
                        .frame(width: 64, height: 64)
                        .shadow(color: Color(hex: "#00594E").opacity(0.4),
                                radius: 12)
                    
                    Image(systemName: "face.smiling")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            
        }
        .padding(.horizontal, 0)
        .padding(.bottom, -20)
    }

    private func tabButton(_ tab: Tab) -> some View {

        Button {
            selected = tab
        } label: {

            VStack(spacing: 0) {

                Image(systemName: tab.icon)
                    .font(.system(size: 22))
                    .foregroundColor(
                        selected == tab
                        ? Color(hex: "#00594E")
                        : .gray
                    )

                Text(tab.title)
                    .font(.caption)
                    .foregroundColor(
                        selected == tab
                        ? Color(hex: "#00594E")
                        : .gray
                    )
            }
            .frame(maxWidth: .infinity)
        }
    }
}


// MARK: - Tabs

enum Tab {
    case home
    case explore
    case scan
    case inbox
    case profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Explore"
        case .scan: return "AR"
        case .inbox: return "Inbox"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house"
        case .explore: return "safari"
        case .scan: return "arkit"
        case .inbox: return "tray"
        case .profile: return "person"
        }
    }
}

