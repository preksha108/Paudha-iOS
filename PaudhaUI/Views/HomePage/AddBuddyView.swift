
import UIKit
import SwiftUI
import Firebase
import FirebaseStorage




struct AddBuddyView: View {
    @EnvironmentObject var plantCollection: PlantCollection
    @State private var buddyNickname = UserDefaults.standard.string(forKey: "buddyNickname") ?? ""
    @State private var buddyType = UserDefaults.standard.string(forKey: "buddyType") ?? ""
    @State private var buddyDesc = UserDefaults.standard.string(forKey: "buddyDesc") ?? ""
    @State private var selectedImage: UIImage?
    @State private var tempSelectedImage: UIImage?
    @State private var showImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                TextField("Buddy Nickname", text: $buddyNickname)
                    .padding()

                TextField("Buddy Type", text: $buddyType)
                    .padding()
                
                TextField("Buddy's Story", text: $buddyDesc)
                    .padding()
                
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Select Image")
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker1(selectedImage: $tempSelectedImage, isImagePickerPresented: $showImagePicker)
                }

                if let selectedImage = tempSelectedImage ?? selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    // Save buddy action
                    if let selectedImage = tempSelectedImage {
                        let imageName = UUID().uuidString
                        saveImageToDocumentDirectory(image: selectedImage, imageName: imageName)
                        plantCollection.plants.append(Plant(imageName: imageName, nickname: buddyNickname, type: buddyType, description: buddyDesc))
                        
                        // Save data to UserDefaults
                        UserDefaults.standard.set(buddyNickname, forKey: "buddyNickname")
                        UserDefaults.standard.set(buddyType, forKey: "buddyType")
                        UserDefaults.standard.set(buddyDesc, forKey: "buddyDesc")
                        
                        buddyNickname = ""
                        buddyType = ""
                        buddyDesc = ""
                        tempSelectedImage = nil
                        showImagePicker = false
                        
                        presentationMode.wrappedValue.dismiss()

                        // Print statements
                        print("Image saved to document directory")
                        print("New Plant added to collection: \(plantCollection.plants.last)")
                    }
                }) {
                    Text("Save")
                }
            )
        }
        .onAppear {
            if let lastSavedImageName = UserDefaults.standard.string(forKey: "lastSavedImageName") {
                // Load last saved image
                let imageUrl = getDocumentsDirectory().appendingPathComponent(lastSavedImageName)
                if let imageData = try? Data(contentsOf: imageUrl) {
                    selectedImage = UIImage(data: imageData)
                }
            }
        }
    }

    // Function to save image to the document directory
    func saveImageToDocumentDirectory(image: UIImage, imageName: String) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: filename)
            
            // Save image name to UserDefaults
            UserDefaults.standard.set(imageName, forKey: "lastSavedImageName")
        }
    }
    
    // Function to get the documents directory path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}




//struct AddBuddyView: View {
//    @EnvironmentObject var plantCollection: PlantCollection
//    @State private var buddyNickname = ""
//    @State private var buddyType = ""
//    @State private var buddyDesc = ""
//    @State private var selectedImage: UIImage?
//    @State private var tempSelectedImage: UIImage?
//    @State private var showImagePicker = false
//    
//    @Environment(\.presentationMode) var presentationMode
//    
//    var storage = Storage.storage()
//    var db = Firestore.firestore()
//    
//    var body: some View {
//        NavigationView {
//            List {
//                TextField("Buddy Nickname", text: $buddyNickname)
//                    .padding()
//                
//                TextField("Buddy Type", text: $buddyType)
//                    .padding()
//                
//                TextField("Buddy's Story", text: $buddyDesc)
//                    .padding()
//                
//                Button(action: {
//                    showImagePicker = true
//                }) {
//                    Text("Select Image")
//                }
//                .sheet(isPresented: $showImagePicker) {
//                    ImagePicker1(selectedImage: $tempSelectedImage, isImagePickerPresented: $showImagePicker)
//                }
//                
//                if let selectedImage = tempSelectedImage ?? selectedImage {
//                    Image(uiImage: selectedImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 250, height: 250)
//                }
//            }
//            .navigationBarItems(
//                leading: Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Cancel")
//                },
//                trailing: Button(action: {
//                    // Save buddy action
//                    if let selectedImage = tempSelectedImage {
//                        uploadImageAndSaveData(image: selectedImage)
//                        
//                    }
//                }) {
//                    Text("Save")
//                }
//            )
//        }
//    }
//    
//
//
//    
//        func uploadImageAndSaveData(image: UIImage) {
//            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//    
//            let imageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
//            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
//                guard let _ = metadata else {
//                    print("Error uploading image: \(error?.localizedDescription ?? "")")
//                    return
//                }
//    
//                // Image uploaded successfully, now save other details to Firestore
//                let data: [String: Any] = [
//                    "nickname": self.buddyNickname,
//                    "type": self.buddyType,
//                    "description": self.buddyDesc,
//                    "imageUrl": metadata!.path ?? ""
//                ]
//    
//                self.db.collection("plants").addDocument(data: data) { error in
//                    if let error = error {
//                        print("Error adding document: \(error)")
//                    } else {
//                        print("Document added successfully")
//                        // Reset fields after successful save
//                        self.buddyNickname = ""
//                        self.buddyType = ""
//                        self.buddyDesc = ""
//                        self.tempSelectedImage = nil
//                        self.showImagePicker = false
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
//                }
//            }
//        }
//    
//    
//
//
//    
//}

 
