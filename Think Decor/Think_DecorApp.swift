//
//  Think_DecorApp.swift
//  Think Decor
//
//  Created by Aziz Saifee on 02/02/26.
//

import SwiftUI
import Firebase

@main
struct Think_DecorApp: App {
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
