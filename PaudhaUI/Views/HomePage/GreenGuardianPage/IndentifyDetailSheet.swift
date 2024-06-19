//
//  IndentifyDetailSheet.swift
//  PaudhaUI
//
//  Created by user1 on 27/03/24.
//

import SwiftUI

struct IdentifyDetailSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var potSize: Double = 0.0
    var plantName: String
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
                
                Text("\(detailCategory) Details for \(plantName)")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color.green)
                
                if detailCategory == "Watering" {
                    VStack {
                        Text("Adjust the slider to select pot size (in inches):")
                            .padding(.bottom, 10)
                            .foregroundColor(.primary)
                        
                        Slider(value: $potSize, in: 0...12, step: 0.5)
                            .padding(.horizontal)
                            .accentColor(Color.blue) // Custom slider color
                            .foregroundColor(.green) // Custom thumb color
                        
                        Text("Pot size: \(String(format: "%.1f", potSize)) inches")
                            .padding(.top, 10)
                            .foregroundColor(.primary)
                        
                        Text(wateringRequirement(for: potSize))
                            .padding(.top, 10)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white) // Background color
                    .cornerRadius(10) // Rounded corners
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow
                }
                
                // Display different details based on the detail category and pot size
                if plantName == "BostonFern" {
                    if detailCategory == "Sunlight" {
                        Text("Boston Fern can tolerate being far from a window and light source. Place it less than 6 feet from a south-facing window to ensure it receives enough light to survive 💪. Select your region to see how the current weather in your area affects the placement of Boston Fern in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Boston Fern after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                } else if plantName == "Suksom" {
                    if detailCategory == "Sunlight" {
                        Text("Suksom Jaipong Aglaonema can tolerate being far from a window and light source. Place it less than 6 feet from a south-facing window to ensure it receives enough light to survive 💪. Select your region to see how the current weather in your area affects the placement of Suksom Jaipong Aglaonema in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Suksom Jaipong Aglaonema after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }else if plantName == "SnakePlant" {
                    if detailCategory == "Sunlight" {
                        Text("Snake Plant can tolerate being far from a window and light source. Place it less than 6 feet from a south-facing window to ensure it receives enough light to survive 💪. Select your region to see how the current weather in your area affects the placement of Snake Plant in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Snake Plant after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }else if plantName == "SpiderPlant" {
                    if detailCategory == "Sunlight" {
                        Text("Spider Plant can tolerate being far from a window and light source. Place it less than 6 feet from a south-facing window to ensure it receives enough light to survive 💪. Select your region to see how the current weather in your area affects the placement of Spider Plant in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Spider Plant after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }else if plantName == "Weeping Fig" {
                    if detailCategory == "Sunlight" {
                        Text("Weeping Fig love being close to bright, sunny windows 😎. Place it less than 1ft from a south-facing window to maximize the potential for growth. Weeping Fig does not tolerate low-light 🚫. Select your region to see how the current weather in your area affects the placement of Weeping Fig in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Weeping Fig after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }else if plantName == "Pothos" {
                    if detailCategory == "Sunlight" {
                        Text("Pothos can tolerate being far from a window and light source. Place it less than 6 feet from a south-facing window to ensure it receives enough light to survive 💪. Select your region to see how the current weather in your area affects the placement of Golden Pothos in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Golden Pothos after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }else if plantName == "Jade Plant" {
                    if detailCategory == "Sunlight" {
                        Text("Jade love being close to bright, sunny windows 😎. Place it less than 1ft from a south-facing window to maximize the potential for growth. Jade does not tolerate low-light 🚫. Select your region to see how the current weather in your area affects the placement of Jade in your home 🏡")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text( "Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your Jade after it doubles in size or once a year—whichever comes first.")
                            .padding()
                            .foregroundColor(.primary)
                    }
                }else if plantName == "ZZ Plant" {
                    if detailCategory == "Sunlight" {
                        Text("ZZ Plant can tolerate being far from a window and light source. Place it less than 6 feet from a south-facing window to ensure it receives enough light to survive 💪. Select your region to see how the current weather in your area affects the placement of ZZ Plant in your home 🏡.")
                            .padding()
                            .foregroundColor(.primary)
                    } else if detailCategory == "Nutrients" {
                        Text("Most potting soils come with ample nutrients which plants use to produce new growth. By the time your plant has depleted the nutrients in its soil it’s likely grown enough to need a larger pot anyway. To replenish this plant's nutrients, repot your ZZ Plant after it doubles in size or once a year—whichever comes first.")
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
    
    func wateringRequirement(for potSize: Double) -> String {
        // Logic to determine watering requirement based on pot size
        if potSize < 6 {
            return "Water 1 cup when soil is dry to the touch."
        } else if potSize >= 6 && potSize < 10 {
            return "Water 2 cups when soil is dry to the touch."
        } else {
            return "Water 3 cups when soil is dry to the touch."
        }
    }
}
