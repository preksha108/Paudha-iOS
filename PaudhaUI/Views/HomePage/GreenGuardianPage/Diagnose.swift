//
//  Diagnose.swift
//  PaudhaUI
//
//  Created by Anant Narain on 16/01/24.
//

import SwiftUI
import CoreML
import Vision

struct Diagnose: View {
    @State private var classificationLabel: String = ""
    @State private var healthClassificationLabel: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isDetailsPresented = false
    @State private var selectedDetailCategory = ""
    @State private var selectedPlantName = "" // Default plant name
    let detailCategories = ["Symptoms", "Causes", "Preventive Measures","Necessary Actions"]
    let identifyConfiguration = MLModelConfiguration()
    let healthConfiguration = MLModelConfiguration()
    
    // Initialize Identify model
    var identifyModel: DiseaseAna? = {
        do {
            return try DiseaseAna(configuration: MLModelConfiguration())
        } catch {
            fatalError("Failed to initialize Identify model. Error: \(error)")
        }
    }()
    
    
    var body: some View {
        VStack {
            // Image card
            ZStack{
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 360, height: 280)
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 360, height: 280)
                        .clipped() // Ensure the image doesn't overflow
                } else {
                    Text("No image selected")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.top, -70)
            
            HStack(spacing: 20) {
                Button(action: {
                    self.isImagePickerPresented = true
                }) {
                    Text("Select Image")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker3(selectedImage: self.$selectedImage)
                }
                
                Button(action: {
                    self.DiagnoseImage()
 // Call health classification
                }) {
                    Text("Classify")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            if !classificationLabel.isEmpty || !healthClassificationLabel.isEmpty {
                VStack {
                    if !classificationLabel.isEmpty {
                        Text("\(classificationLabel)")
                            .padding()
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    
                }
                .frame(width: 360, height: 90)
                .padding()
                .background(Color.gray.opacity(0.2)) // Background color
                .cornerRadius(10) // Rounded corners
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow
            }
            
            // Details card
            VStack(alignment: .leading, spacing: 10) {
                Text("Details")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Divider()
                
                ForEach(detailCategories, id: \.self) { category in
                    DetailRow(title: category) {
                        self.selectedDetailCategory = category
                        self.isDetailsPresented = true
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            .padding()
        }
        .sheet(isPresented: $isDetailsPresented) {
            DisDetailSheet(diseaseName: self.selectedPlantName, detailCategory: self.selectedDetailCategory)
        }
    }
    
   
    
    
    private func DiagnoseImage() {
        guard let model = identifyModel, let selectedImage = selectedImage else {
            print("Model or selected image is nil.")
            return
        }
        
        print("Selected image size: \(selectedImage.size)")
        
        guard let resizedImage = selectedImage.resizeImageTo(size: CGSize(width: 299, height: 299)) else {
            print("Error resizing the image.")
            return
        }
        
        print("Resized image size: \(resizedImage.size)")
        
        guard let buffer = resizedImage.convertToBuffer() else {
            print("Error converting the image to buffer.")
            return
        }
        
        do {
            let output = try model.prediction(image: buffer)
            guard let topPrediction = output.targetProbability.max(by: { $0.value < $1.value }) else {
                self.classificationLabel = "Unable to determine"
                print("Unable to determine")
                return
            }
            
            let classification = "\(topPrediction.key) = \(String(format: "%.2f%%", topPrediction.value * 100))"
            self.classificationLabel = classification
            
            print("Top Prediction: \(topPrediction.key), Probability: \(String(format: "%.2f%%", topPrediction.value * 100))")
            print("Classification Label: \(classification)")
            self.selectedPlantName = topPrediction.key
        } catch {
            print("Error during prediction: \(error)")
            self.classificationLabel = "Error during prediction"
        }
    }
}

struct ImagePicker3: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker3
        
        init(_ parent: ImagePicker3) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

//struct DetailRow: View {
//    let title: String
//    let onTap: () -> Void
//    
//    var body: some View {
//        Button(action: onTap) {
//            HStack {
//                Text(title)
//                    .foregroundColor(.black)
//                Spacer()
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.gray)
//            }
//            .padding()
//        }
//    }
//}
