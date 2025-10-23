//
//  WeatherView.swift
//  SwiftBootcampPro
//
//  Created by Khaled on 23/10/2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🌤️ Cairo Weather")
                .font(.title2)
                .bold()
            
            if viewModel.isLoading {
                ProgressView()
            } else if let temp = viewModel.temperature {
                VStack(spacing: 8) {
                    Text("Temperature: \(temp, specifier: "%.1f")°C")
                    Text("Wind Speed: \(viewModel.windspeed ?? 0, specifier: "%.1f") km/h")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red)
            } else {
                Text("No data yet.")
            }
            
            Button("Refresh Weather") {
                Task { await viewModel.fetchWeather() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .task {
            await viewModel.fetchWeather()
        }
    }
}

#Preview {
    WeatherView()
}

