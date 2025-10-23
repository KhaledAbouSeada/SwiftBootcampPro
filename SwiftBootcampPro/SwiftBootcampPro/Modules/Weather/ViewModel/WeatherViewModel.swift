//
//  WeatherViewModel.swift
//  SwiftBootcampPro
//
//  Created by Khaled on 23/10/2025.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var temperature: Double?
    @Published var windspeed: Double?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchWeather() async {
        isLoading = true
        errorMessage = nil
        
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=30.0444&longitude=31.2357&current_weather=true")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
            temperature = response.current_weather.temperature
            windspeed = response.current_weather.windspeed
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
