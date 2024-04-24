//
//  CityDetailView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This file defines the CityDetailView, which displays detailed information about a city, including its name, weather and description.
//

// MARK: - Imports
import SwiftUI

struct CityDetailView: View {
    // MARK: - Properties
    
    var city: City
    
    // State variables to control weather display
    @State private var isShowingWeather = false
    @State private var weatherData: WeatherData?
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                // Display city name with large title font
                Text(city.name ?? "Unknown City")
                    .font(.largeTitle)
                    .padding(.top, 20)
                Spacer()
                
                // Display city description with body text font and padding
                Text(city.cityDescription ?? "")
                    .font(.body)
                    .padding()
                Spacer()
                Spacer()
                
                // Navigation link to WeatherDetailView, activated based on isShowingWeather
                NavigationLink(destination: WeatherDetailView(weatherData: weatherData), isActive: $isShowingWeather) {
                    EmptyView()
                }
                
                // Button to fetch and display weather information
                Button(action: {
                    fetchWeatherData(for: city)
                }) {
                    Text("Show Weather")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                // Placeholder for City Map information
                Text("City Map")
                    .font(.body)
                    .padding()
                
                // Display CityMapView
                CityMapView(city: city)
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline) // Hide the large title in the navigation bar
        }
    }
    
    // MARK: - Weather Data Fetching
    
    // Function to fetch weather data for the given city
    private func fetchWeatherData(for city: City) {
        let cityName = city.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://api.api-ninjas.com/v1/weather?city=" + cityName)!
        var request = URLRequest(url: url)
        request.setValue("vku3TcurKChIAZSB2yVMOw==emc2Nlm2D2RVuevX", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                // Decode weather data and update UI on the main thread
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weatherData = decodedData
                    self.isShowingWeather = true
                }
            } catch {
                // Handle decoding error
                print("Error decoding weather data: \(error)")
            }
        }
        
        task.resume()
    }
}
