import SwiftUI





struct Plant1: Identifiable {

    let id = UUID()

    let title: String

    let info: String

    let imageName: String

}

struct SearchView: View {

    @State private var isPlantDetailSheetPresented = false

    @State private var selectedPlant: Plant1?

    @State private var searchText = ""

    

    // Example plant data

    let plants: [Plant1] = [

        Plant1(title: "Areca Palm",

               info: "Areca palms: Indoor plants with graceful, feather-like fronds, prized for their tropical aesthetic and air-purifying qualities.",

               imageName: "ArecaPalm"),

        

        Plant1(title: "Baby Rubber Plant",

               info: "Baby rubber plant (Peperomia obtusifolia): Compact indoor favorite with glossy, rounded leaves, thriving in low light and easy to care for.",

               imageName: "BabyRubberPlant"),

        

        Plant1(title: "Boston Fern",

               info: "Boston ferns: Lush, feathery indoor plants admired for their elegant fronds and ability to thrive in humid environments, adding a touch of greenery to any space.",

               imageName: "BostonFern"),

        

        Plant1(title: "Croton",

               info: "Croton: Vibrant indoor plant with colorful, glossy leaves, prized for its tropical aesthetic and low-maintenance nature, adding a pop of color to indoor spaces.",

               imageName: "Croton"),

        

        Plant1(title: "Grape Ivy",

               info: "Grape ivy: Charming indoor vine with lobed leaves, admired for its trailing growth and ease of care, adding a touch of greenery to any space.",

               imageName: "GrapeIvy"),

        

        Plant1(title: "Jade Plant",

               info: "Jade: Hardy indoor succulent with fleshy leaves, admired for its resilience and easy care, adding a touch of green to any space.",

               imageName: "jade"),

        

        Plant1(title: "Lady's slipper orchid",

               info: "Lady's slipper orchid: Exquisite flowering plant with unique, slipper-shaped blooms, cherished for its beauty and elegance, requiring specific care conditions to thrive indoors.",

               imageName: "Ladysslipperorchid"),

        

        Plant1(title: "Pothos",

               info: "Baby rubber plant (Peperomia obtusifolia): Compact indoor favorite with glossy, rounded leaves, thriving in low light and easy to care for.",

               imageName: "Pothos"),

        

        Plant1(title: "Snake Plant",

               info: "Snake plants: Low-maintenance indoor plants with tall, variegated leaves, renowned for air purification and easy care.",

               imageName: "SnakePlant"),

        

        Plant1(title: "Spider Plant",

               info: "Spider plants (Chlorophytum comosum) are resilient indoor plants known for their air-purifying qualities and cascading foliage.",

               imageName: "SpiderPlant"),

        

        Plant1(title: "String Of Pearl",

               info: "String of pearls: Trailing succulent with bead-like leaves, prized for its unique appearance and low maintenance.",

               imageName: "stringofpearl"),

        

        Plant1(title: "Weeping Fig",

               info: "Weeping figs (Ficus benjamina): Indoor plants with graceful, drooping foliage, popular for their elegant appearance and air-purifying properties.",

               imageName: "WeepingFig"),

        

        Plant1(title: "ZZ Plant",

               info: "ZZ plant: Hardy indoor plant with glossy, waxy leaves, appreciated for its low maintenance and air-purifying qualities, perfect for adding greenery to low-light environments.",

               imageName: "zz"),



    ]

    var filteredPlants: [Plant1] {

            if searchText.isEmpty {

                return plants

            } else {

                return plants.filter { $0.title.lowercased().contains(searchText.lowercased()) }

            }

        }

        

        var body: some View {

            NavigationView {

                ScrollView {

                    VStack(spacing: 20) {

                        ForEach(filteredPlants) { plant in

                            Button(action: {

                                selectedPlant = plant

                                isPlantDetailSheetPresented = true

                            }) {

                                PlantCardView(plant: plant)

                            }

                        }

                    }

                    .padding()

                    .sheet(isPresented: $isPlantDetailSheetPresented) {

                        if let plant = selectedPlant {

                            PlantDetailView1(plant: plant, isPresented: $isPlantDetailSheetPresented)

                        }

                    }

                }

                .searchable(text: $searchText)

                .navigationTitle("Search for Plants")

            }

        }

    }

#Preview {

    SearchView()

}

