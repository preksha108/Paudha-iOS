

import SwiftUI

struct PlantDetailView: View {
    let plant: Plant
    
    var body: some View {
        VStack {
            if let uiImage = loadImageFromDocumentDirectory(imageName: plant.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
                    .cornerRadius(20)
                    .padding()
            } else {
                Text("Error loading image")
                    .foregroundColor(.red)
                    .padding()
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Nickname")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(plant.nickname)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("Type")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(plant.type)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("Description")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(plant.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
            .shadow(radius: 5)
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.9686, green: 0.8824, blue: 0.8431), Color(red: 240/255.0, green: 255/255.0, blue: 241/255.0)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing
            )
        )
        
        .navigationBarTitle("Plant Details", displayMode: .inline)
        .edgesIgnoringSafeArea(.all)
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = documentDirectory.appendingPathComponent(imageName)

        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from document directory: \(error)")
            return nil
        }
    }
}
