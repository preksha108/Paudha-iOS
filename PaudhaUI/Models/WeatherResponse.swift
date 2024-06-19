//
//  WeatherResponse.swift
//  PaudhaUI
//
//  Created by Anant Narain on 21/02/24.
//

import Foundation
struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let main: String
}

struct Main: Codable {
    let temp: Double
}

