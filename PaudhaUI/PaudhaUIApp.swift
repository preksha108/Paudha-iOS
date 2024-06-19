//
//  PaudhaUIApp.swift
//  PaudhaUI
//
//  Created by Anant Narain on 16/01/24.
//

import SwiftUI
import Firebase



@main
struct PaudhaUIApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
