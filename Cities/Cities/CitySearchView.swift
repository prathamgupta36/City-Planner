//
//  CitySearchView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This helps in searching a city.
//

// MARK: - Imports
import SwiftUI

// MARK: - City Search View

// View for searching and displaying details of a city
struct CitySearchView: View {
    // State variable to store the entered city name
    @State private var cityName: String = ""
    
    // State variable to store the details of the searched city
    @State private var cityDetails: CityDetails?

    // Body of the view
    var body: some View {
        VStack {
            // Text field for entering the city name
            TextField("Enter city name", text: $cityName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Button to initiate the city search
            Button("Search City") {
                searchCity()
            }
            .padding()

            // Display city details if available
            if let cityDetails = cityDetails {
                CityDetailsView(cityDetails: cityDetails)
            }
        }
        .padding()
    }

    // MARK: - City Search Function

    // Function to search for city details based on the entered city name
    private func searchCity() {
        // Encode the city name for including it in the URL
        guard let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        // Create the URL for the city search API
        let url = URL(string: "https://api.api-ninjas.com/v1/city?name=\(encodedCityName)")!
        
        // Create a URL request with the API key in the header
        var request = URLRequest(url: url)
        request.setValue("vku3TcurKChIAZSB2yVMOw==emc2Nlm2D2RVuevX", forHTTPHeaderField: "X-Api-Key")

        // Perform a data task to fetch city details from the API
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Ensure that data is available
            guard let data = data else {
                return
            }

            do {
                // Decode the JSON data into an array of CityDetails
                let decoder = JSONDecoder()
                let cityDetails = try decoder.decode([CityDetails].self, from: data)
                
                // Update the cityDetails state variable on the main thread
                DispatchQueue.main.async {
                    self.cityDetails = cityDetails.first
                }
            } catch {
                // Handle errors during JSON decoding
                print("Error decoding JSON: \(error)")
            }
        }
        .resume() // Start the data task
    }
}
