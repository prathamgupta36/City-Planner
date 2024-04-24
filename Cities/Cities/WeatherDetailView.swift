//
//  WeatherDetailView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This is where we show our weather details for the user.
//

// MARK: - Imports
import SwiftUI
import CoreData
import Foundation

// MARK: - Weather Detail View

// View for displaying detailed weather information
struct WeatherDetailView: View {
    // Weather data received as input
    var weatherData: WeatherData?

    // DateFormatter property for formatting timestamps
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    // Body of the view
    var body: some View {
        if let weatherData = weatherData {
            VStack {
                // Header for weather information
                Text("Weather Information")
                    .font(.headline)
                    .padding()

                // Display various weather details
                Text("Temperature: \(weatherData.temp)°C")
                Text("Humidity: \(weatherData.humidity)%")
                Text("Wind Speed: \(weatherData.wind_speed) m/s")
                Text("Wind Direction: \(weatherData.wind_degrees)°")
                Text("Feels Like: \(weatherData.feels_like)°C")
                Text("Min Temperature: \(weatherData.min_temp)°C")
                Text("Max Temperature: \(weatherData.max_temp)°C")
                Text("Cloud Coverage: \(weatherData.cloud_pct)%")
                
                // Convert timestamps to readable date and time
                let sunriseTime = Date(timeIntervalSince1970: TimeInterval(weatherData.sunrise))
                let sunsetTime = Date(timeIntervalSince1970: TimeInterval(weatherData.sunset))

                Text("Sunrise: \(dateFormatter.string(from: sunriseTime))")
                Text("Sunset: \(dateFormatter.string(from: sunsetTime))")
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .navigationBarTitle("Weather Details") // Set the navigation bar title
        } else {
            // Display a message if weather information is not available
            Text("Weather information not available")
                .padding()
                .navigationBarTitle("Weather Details") // Set the navigation bar title
        }
    }
}
