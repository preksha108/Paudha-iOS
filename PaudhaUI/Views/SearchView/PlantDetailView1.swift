//
//  PlantDetailView1.swift
//  PaudhaUI
//
//  Created by SHHH!! private on 06/03/24.
//

import SwiftUI

struct PlantDetailView1: View {

    let plant: Plant1

    @Binding var isPresented: Bool

    

    var body: some View {

        NavigationView {

            VStack {

                Image(plant.imageName)

                    .resizable()

                    .aspectRatio(contentMode: .fit)

                    .frame(maxHeight: 250)

                    .cornerRadius(20)

                    .padding()

                

                Text(plant.title)

                    .font(.title)

                    .fontWeight(.bold)

                    .padding(.horizontal)

                

                Card {

                    Text(plant.info)

                        .font(.body)

                        .multilineTextAlignment(.center)

                        .padding()

                }

                .padding(.horizontal)

                .padding(.bottom)

                

                Spacer()

            }

            .padding(.vertical)

            .navigationBarTitle("Plant Details", displayMode: .inline)

            .navigationBarItems(trailing:

                Button("Cancel") {

                    isPresented = false

                }

            )

        }

    }

}
struct Card<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
    }
}

