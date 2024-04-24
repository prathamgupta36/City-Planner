//
//  CityLocationViewModel.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: Finds the location of the city.
//

// MARK: - Imports
import SwiftUI
import CoreLocation
import Combine

// MARK: - City Location View Model

// Observable object responsible for managing city location information
class CityLocationViewModel: ObservableObject {
    // Published property to hold city coordinates
    @Published var cityCoordinates: CLLocationCoordinate2D?
    
    // Set of cancellables to manage Combine subscriptions
    private var cancellables: Set<AnyCancellable> = []

    // CLLocationManager instance for handling location-related tasks
    private var locationManager = CLLocationManager()

    // Initializer to set up the location manager
    init() {
        setupLocationManager()
    }

    // MARK: - Location Manager Setup
    
    // Function to set up the CLLocationManager
    private func setupLocationManager() {
        // Clear the delegate to avoid potential retain cycles
        locationManager.delegate = nil
        
        // Request authorization for using location when the app is in use
        locationManager.requestWhenInUseAuthorization()

        // Create a publisher for location updates from the location manager
        let locationPublisher = locationManager.publisher(for: \.location)
            .compactMap { $0?.coordinate }

        // Subscribe to the location publisher and update cityCoordinates when a new location is received
        locationPublisher
            .sink { coordinates in
                self.cityCoordinates = coordinates
            }
            .store(in: &cancellables)
    }

    // MARK: - Geocoding
    
    // Function to geocode a city name and retrieve its coordinates
    func geocodeCity(cityName: String) {
        // Create a CLGeocoder instance
        let geocoder = CLGeocoder()

        // Perform geocoding for the provided city name
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            // Handle errors if needed
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }

            // If geocoding is successful, update cityCoordinates with the first placemark's coordinates
            if let placemark = placemarks?.first {
                let location = placemark.location
                self.cityCoordinates = location?.coordinate
            }
        }
    }
}
