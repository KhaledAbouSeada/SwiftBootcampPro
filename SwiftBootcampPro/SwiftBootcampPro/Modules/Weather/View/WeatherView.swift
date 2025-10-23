//
//  WeatherView.swift
//  SwiftBootcampPro
//
//  Created by Khaled on 23/10/2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedCity = "Cairo"
    
    let cities = [
        "Cairo": (30.0444, 31.2357),
        "London": (51.5072, -0.1276),
        "New York": (40.7128, -74.0060)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Select City", selection: $selectedCity) {
                ForEach(cities.keys.sorted(), id: \.self) { city in
                    Text(city)
                }
            }
            .pickerStyle(.segmented)
            
            Text("🌤️ \(selectedCity) Weather")
                .font(.title2)
                .bold()
            
            if viewModel.isLoading {
                ProgressView()
            } else if let temp = viewModel.temperature {
                VStack(spacing: 8) {
                    Text("Temperature: \(temp, specifier: "%.1f")°C")
                        .animation(.easeInOut(duration: 0.4), value: viewModel.temperature)
                    Text(viewModel.condition)
                        .font(.title2)
                        .animation(.easeInOut(duration: 0.4), value: viewModel.condition)
                    Text("Wind Speed: \(viewModel.windspeed ?? 0, specifier: "%.1f") km/h")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .animation(.easeInOut(duration: 0.4), value: viewModel.windspeed)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
            
            Button("Refresh") {
                let coords = cities[selectedCity]!
                Task {
                    await viewModel.fetchWeather(latitude: coords.0, longitude: coords.1)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .task {
            let coords = cities[selectedCity]!
            await viewModel.fetchWeather(latitude: coords.0, longitude: coords.1)
        }
        .onChange(of: selectedCity) { newCity in
            let coords = cities[newCity]!
            Task {
                await viewModel.fetchWeather(latitude: coords.0, longitude: coords.1)
            }
        }
    }
}

#Preview {
    WeatherView()
}

