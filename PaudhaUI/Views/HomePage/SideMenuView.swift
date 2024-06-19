//
//  SideMenuView.swift
//  PaudhaUI


import SwiftUI
import FirebaseAuth

struct SideMenuView: View {
    @Binding var isSideMenuPresented: Bool

    var body: some View {
        List {
            Section(header: Text("Menu")) {
                NavigationLink(destination: SettingsView()) {
                    Label("Settings", systemImage: "gear")
                }

                NavigationLink(destination: FeedbackView()) {
                    Label("Give Feedback", systemImage: "message")
                }

                NavigationLink(destination: ContactAndSocialView()) {
                    Label("Contact & Social", systemImage: "person")
                }

                // Add more sections as needed
                
                Button(action: logout) {
                    Label("Logout", systemImage: "power")
                }
            }
        }
        .listStyle(SidebarListStyle())
        .onAppear {
            isSideMenuPresented = true
        }
        
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            
            // Set the root view controller to the login view controller
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = UIHostingController(rootView: LoginView())
            }
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

