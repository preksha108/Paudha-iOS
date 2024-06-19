//
//  DiagnoseDetailView.swift
//  PaudhaUI
//
//  Created by user1 on 27/03/24.
//

import SwiftUI

import SwiftUI

struct DisDetailSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var potSize: Double = 0.0
    var diseaseName: String
    var detailCategory: String
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                }
                
                Text("\(detailCategory) Details for \(diseaseName)")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color.green)
                
                // Display different details based on the detail category and pot size
                if diseaseName == "Early Blight" {
                    if detailCategory == "Symptoms" {
                        Text("Dark brown to black spots with concentric rings on lower leaves. Leaf yellowing and wilting. Defoliation in advanced stages.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Causes" {
                        Text("Fungal pathogen Alternaria solani. Warm, humid conditions.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Preventive Measures" {
                        Text("Rotate crops to reduce pathogen buildup. Mulch to prevent soil splash onto lower leaves. Water at the base of plants.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Necessary Actions" {
                        Text("Apply fungicides if necessary. Remove and destroy infected plant debris.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                    
                } else if diseaseName == "bacterial spot" {
                    if detailCategory == "Symptoms" {
                        Text("Small, water-soaked lesions on leaves, which may turn brown or black. Lesions may coalesce and cause leaf distortion. Fruit may develop raised, scabby lesions. ")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Causes" {
                        Text("Bacterial pathogens like Xanthomonas spp. or Pseudomonas spp. Warm, humid conditions.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Preventive Measures" {
                        Text("Viral infection transmitted by insect vectors like whiteflies or aphids. Infected plant material or weeds.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Necessary Actions" {
                        Text("Use insecticides to control vector populations. Remove infected plants promptly. Practice crop rotation.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                    
                }else if diseaseName == "powedry_mildew" {
                    if detailCategory == "Symptoms" {
                        Text("White powdery patches on leaves, stems, and flowers. Leaf curling or distortion. Premature leaf drop.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Causes" {
                        Text("Fungal pathogens like Erysiphe spp. or Sphaerotheca spp.High humidity and moderate temperatures.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Preventive Measures" {
                        Text("Provide good air circulation. Avoid overhead irrigation. Remove and destroy infected plant material.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Necessary Actions" {
                        Text("Apply fungicides labeled for powdery mildew control. Prune to improve airflow. Apply preventive fungicides in high-risk areas.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                    
                }else if diseaseName == "yellowDisease" {
                    if detailCategory == "Symptoms" {
                        Text("Yellowing of leaves, starting at the tips or edges. Leaf drop. Stunted growth.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Causes" {
                        Text("Nutrient deficiencies, particularly nitrogen. Poor soil drainage.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Preventive Measures" {
                        Text("Soil testing to determine nutrient deficiencies. Amend soil with organic matter. Provide proper irrigation and drainage.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Necessary Actions" {
                        Text("Apply fertilizers according to soil test recommendations. Mulch to conserve soil moisture and regulate temperature. Address drainage issues if present.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                    
                }else if diseaseName == "Molds" {
                    if detailCategory == "Symptoms" {
                        Text("Yellowing of leaves with fuzzy white or gray patches on the undersides. Leaf curling or distortion. Premature leaf drop.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Causes" {
                        Text("Fungal pathogens like Fulvia fulva. High humidity and moderate temperatures.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Preventive Measures" {
                        Text("Improve air circulation. Avoid overhead irrigation. Remove and destroy infected plant material.")
                            .padding()
                            .foregroundColor(.primary)
                    }else if detailCategory == "Necessary Actions" {
                        Text("Apply fungicides labeled for leaf mold control. Prune to improve airflow. Apply preventive fungicides in high-risk areas.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
            }
        }
        .background(Color("BackgroundColor"))
        .cornerRadius(15)
        .padding()
    }
    
}
