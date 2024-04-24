//
//  CityMapView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: Displays the map of the city.

// MARK: - Imports

import SwiftUI
import MapKit

// MARK: - City Map View

// View displaying a map for a given city
struct CityMapView: View {
    // ObservedObject to manage location information
    @ObservedObject var locationViewModel: CityLocationViewModel
    
    // City object for which the map is displayed
    var city: City

    // Initializer to set up the view with a city
    init(city: City) {
        self.city = city
        self.locationViewModel = CityLocationViewModel()
    }

    // Body of the view
    var body: some View {
        VStack {
            // Display map if coordinates are available, otherwise show loading message
            if let coordinates = locationViewModel.cityCoordinates {
                Map(
                    // Set the coordinate region for the map
                    coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: coordinates,
                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        )
                    ),
                    showsUserLocation: true,
                    userTrackingMode: Binding(
                        // Set user tracking mode to follow
                        get: {
                            .follow
                        },
                        set: { _ in }
                    )
                )
            } else {
                // Show loading message if coordinates are not available
                Text("Loading Map...")
            }
        }
        // Perform geocoding when the view appears
        .onAppear {
            locationViewModel.geocodeCity(cityName: city.name ?? "")
        }
    }
}

// MARK: - Preview

// Preview provider for the CityMapView
struct CityMapView_Previews: PreviewProvider {
    static var previews: some View {
        CityMapView(city: City())
    }
}
