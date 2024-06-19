import SwiftUI
import UIKit
import Firebase

struct Home: View {

    @StateObject private var plantCollection = PlantCollection()
    @State private var isAddingBuddy = false
    @State private var isSideMenuPresented = false
    @State private var currentQuote: String = QuoteKit.getDailyPlantQuote()
    @State private var selectedPlant: Plant?
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var isAlertPresented = false
    @State private var isIdentifySelected = false
    @State private var isDiagnoseSelected = false


    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(imageName)

        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from document directory: \(error)")
            return nil
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack {

                    //profile image section
                    ZStack {
                                            // Display selected image or default icon
                                            if let selectedImage = selectedImage {
                                                Image(uiImage: selectedImage)
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(Circle())
                                            } else {
                                                Image("exampleIcon")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(Circle())
                                            }
                                            
                                            // Camera button
                                            Button(action: {
                                                isShowingImagePicker = true // Show image picker
                                            }) {
                                                Image(systemName: "camera")
                                                    .resizable()
                                                    .foregroundColor(.blue)
                                                    .frame(width: 20, height: 15)
                                                    .padding(5)
                                                    .background(Color.white.opacity(0.5))
                                                    .clipShape(Circle())
                                                    .offset(x: 25, y: 40)
                                            }
                                        }
                                        .sheet(isPresented: $isShowingImagePicker) {
                                            ImagePicker1(selectedImage: $selectedImage, isImagePickerPresented: $isShowingImagePicker)
                                        }
                    Text("Hello Preksha \nGood Evening!!")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(0.6)
                }
                
                VStack {
                    HStack(spacing: 50) {
                        VStack {
                           
                                Button(action: {
                                    isAlertPresented = true
                                }) {
                                    Image("GreenGuardian")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                }
                            

                            NavigationLink(destination: IdentifyView(), isActive: $isIdentifySelected) {
                                EmptyView()
                            }
                            NavigationLink(destination: DiagnoseView(), isActive: $isDiagnoseSelected) {
                                EmptyView()
                            }
                            Text("Green Guardian")
                        }
                        .padding()

                        //Add plant section
                        VStack {
                           

                                Image("Addimage2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 95)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        isAddingBuddy = true
                                    
                                   
                            }
                            Text("Add new plant")
                        }.sheet(isPresented: $isAddingBuddy) {
                            AddBuddyView()
                        }.environmentObject(plantCollection)
                    }
                }
                
                
                //Quote sections
                
                    VStack {
                        ZStack {


                            VStack {
                                Text("Daily Dose of Paudha🌱")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                
                                Text(currentQuote)
                                    .font(.system(size: 17, weight: .light, design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                                    .fixedSize(horizontal: false, vertical: true) // Allow text wrapping
                                
                                Spacer()
                            }
                            .padding()
                        }
                             .onAppear {
                                 // Set up a timer to change the quote every 5 minutes
                                 let timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                                     currentQuote = QuoteKit.getDailyPlantQuote()
                                 }
                                 // Make sure to invalidate the timer when the view is deinitialized
                                 RunLoop.current.add(timer, forMode: .common)
                             }
                         }
                

                //My collections view
                VStack {
                                                    Text("My Collection")
                                                        .frame(width: 350, alignment: .leading)
                                                        .font(.title)
                                                        .fontWeight(.bold)
                                                    
                                                    ScrollView(.horizontal) {
                                                        HStack(spacing: 20) {
                                                            
                                                            if plantCollection.plants.isEmpty {
                                                                                    // Display a message when no plants are added
                                                                                    Text("No plants added")
                                                                                        .foregroundColor(.primary)
                                                                                        .padding()
                                                                                } else {
                                                                                    ForEach(plantCollection.plants) { plant in
                                                                                        Button(action: {
                                                                                            selectedPlant = plant
                                                                                        }) {
                                                                                            VStack {
                                                                                                if let uiImage = loadImageFromDocumentDirectory(imageName: plant.imageName) {
                                                                                                    Image(uiImage: uiImage)
                                                                                                        .resizable()
                                                                                                        .aspectRatio(contentMode: .fill)
                                                                                                        .frame(width: 120, height: 150)
                                                                                                        .cornerRadius(10)
                                                                                                        .overlay(
                                                                                                            RoundedRectangle(cornerRadius: 10)
                                                                                                                .stroke(Color.primary, lineWidth: 1)
                                                                                                        )
                                                                                                    Text(plant.nickname)
                                                                                                        .font(.caption)
                                                                                                        .foregroundColor(.primary)
                                                                                                        .multilineTextAlignment(.center)
                                                                                                        .lineLimit(2)
                                                                                                        .padding(.vertical, 4)
                                                                                                } else {
                                                                                                    Text("Error loading image")
                                                                                                }
                                                                                            }
                                                                                            .padding(8)
                                                                                            .background(Color.white.opacity(0.5))
                                                                                            .cornerRadius(15)
                                                                                        }
                                                                                        .sheet(item: $selectedPlant) { plant in
                                                                                            PlantDetailView(plant: plant)
                                                                                        }
                                                                                    }
                                                            }
                                                        }.padding()
                                                    }
                                                }.environmentObject(plantCollection)

                
                SproutCast()
            }.alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("Choose an action"),
                    message: nil,
                    primaryButton: .default(Text("Identify")) {
                        // Handle Identify action
                        isIdentifySelected = true
                        
                    },
                    secondaryButton: .default(Text("Diagnose")) {
                        // Handle Diagnose action
                        isDiagnoseSelected = true
                       
                    }
                )
            }
            
            .navigationBarBackButtonHidden(true)

            .navigationBarItems(
                leading: Button(action: {
                    isSideMenuPresented.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        .padding()
                        .foregroundColor(.black)
                },
                trailing: NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.black
                            )
                    }
            )

            .navigationBarTitle("", displayMode: .inline)
            .background(
                NavigationLink(destination: SideMenuView(isSideMenuPresented: $isSideMenuPresented), isActive: $isSideMenuPresented) {
                    EmptyView()
                }
                .hidden()
                .onAppear {
                    isSideMenuPresented = false
                }
                
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(red: 255/255, green: 200/255, blue: 255/255), location: 0.23),
                    Gradient.Stop(color: Color.white.opacity(0.2), location: 0.4),
                    Gradient.Stop(color: Color.clear, location: 1)
                ]), startPoint: .top, endPoint: .bottom)
                .frame(width: 1000, height: 1500)
            )
            
        }
    }
}




