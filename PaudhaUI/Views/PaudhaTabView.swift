

import SwiftUI

struct PaudhaTabView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem { Image(systemName: "house")
                Text("Home")}
            RemindersView()
                .tabItem { Image(systemName: "list.clipboard")
                Text("Reminder")}

            PixxieView()
                .tabItem { Image(systemName: "camera.macro")
                Text("Pixxie")}
            
            
        }.navigationBarBackButtonHidden(true)
        }
        
    }


#Preview {
    PaudhaTabView()
}
