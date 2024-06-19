//
//  PlantCardView.swift
//  PaudhaUI
//
//  Created by SHHH!! private on 06/03/24.
//

import SwiftUI

struct PlantCardView: View {
    let plant: Plant1
    
    var body: some View {
        HStack(spacing: 15) {
            Image(plant.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(plant.title)
                    .font(.headline)
                Text(plant.info)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "arrow.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
