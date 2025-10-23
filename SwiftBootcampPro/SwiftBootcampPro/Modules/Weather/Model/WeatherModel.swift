//
//  WeatherModel.swift
//  SwiftBootcampPro
//
//  Created by Khaled on 23/10/2025.
//

import Foundation

struct WeatherResponse: Codable {
    let current_weather: WeatherData
}

struct WeatherData: Codable {
    let temperature: Double
    let windspeed: Double
}
