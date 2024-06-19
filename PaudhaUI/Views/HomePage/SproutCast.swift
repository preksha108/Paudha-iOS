//
//  SproutCast.swift
//  PaudhaUI
//
//  Created by Anant Narain on 21/02/24.
//

import SwiftUI
import CoreLocation

struct SproutCast: View {
    @State private var weatherData: WeatherResponse?
        @State private var isLoading = true
    @State private var city = "Chennai"
        
        func fetchWeather() {
            guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
             let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=6fa3672999a3ca2632e5e9da79223e4c&units=metric") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.weatherData = decodedResponse
                        self.isLoading = false
                    }
                } else {
                    print("Failed to decode response")
                }
            }.resume()
        }
        
        var body: some View {
            VStack(alignment: .center, spacing: 20) {
                Text("Sproutcast🌤️")
                    .frame(width: 350, alignment: .leading)
                    .font(.title)
                    .fontWeight(.bold)
                TextField("Enter city", text: $city, onCommit: {
                                // Fetch weather when user hits return
                                fetchWeather()
                            })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    if let weatherData = weatherData {
                        WeatherSymbolView(weatherCondition: weatherData.weather.first?.main ?? "")
                                               .frame(width: 100, height: 100)
                                               .foregroundColor(weatherData.weather.first?.main == "Clear" ? .yellow : .blue)
                                           
                                           Text(weatherData.weather.first?.main ?? "")
                                               .font(.headline)
                                           
                                           Text("Temperature: \(Int(weatherData.main.temp))°C")
                                               .font(.body)
                                           
                                           Text("Location: \(weatherData.name)")
                                               .font(.body)
                    } else {
                        Text("Weather data not available")
                    }
                }
                if let condition = weatherData?.weather.first?.main {
                                PlantCareTips(weatherCondition: condition)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .shadow(radius: 5)
                                    )
                            }
                
                Spacer()
            }.padding().foregroundColor(.black)
                .background(
                    .ultraThinMaterial
                ).cornerRadius(20).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .onAppear {
                fetchWeather()
            }
        }
}

struct WeatherSymbolView: View {
    let weatherCondition: String
    
    var body: some View {
        switch weatherCondition {
        case "Clear":
            return AnyView(Image(systemName: "sun.max").resizable().frame(width: 130,height: 100).foregroundColor(.black))
        case "Clouds":
            return AnyView(Image(systemName: "cloud").resizable().frame(width: 130,height: 100).foregroundColor(.black))
        case "Mist":
            return AnyView(Image(systemName: "aqi.medium").resizable().frame(width: 130,height: 110).foregroundColor(.black))
        case "Rain":
            return AnyView(Image(systemName: "cloud.rain").resizable().frame(width: 130,height: 100).foregroundColor(.black))
        case "Haze":
            return AnyView(Image(systemName: "sun.haze").resizable().frame(width: 130,height: 100).foregroundColor(.black))
        default:
            return AnyView(Image(systemName: "questionmark").resizable().frame(width: 130,height: 100).foregroundColor(.black))
        }
    }
}

struct PlantCareTips: View {
    let weatherCondition: String
    
    var body: some View {
        VStack {
            Text("Leafy Hack❗️")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 5)
            Divider()
            Text(tipsForCondition())
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        
    }
    
    private func tipsForCondition() -> String {
        switch weatherCondition {
        case "Clear":
            return "It's sunny today! Water your plants and keep them hydrated."
        case "Clouds":
            return "It's cloudy today. Check the soil moisture before watering your plants."
        case "Rain":
            return "It's raining today. No need to water your plants, but watch out for overwatering."
        case "Haze":
            return "It's hazy today. Keep your plants in a well-ventilated area."
        default:
            return "Check your plants based on current weather conditions."
        }
    }
}



#Preview {
    SproutCast()
}
