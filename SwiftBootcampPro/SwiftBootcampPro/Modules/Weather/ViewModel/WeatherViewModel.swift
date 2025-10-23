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

    func fetchWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
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
