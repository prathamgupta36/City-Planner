//
//  CityDetailsView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This is the place where all the details of the city are shown after the user searches for it.
//

// MARK: - Imports
import SwiftUI
import MapKit
import CoreData

// MARK: - City Details View

// View for displaying details of a city, allowing the user to add it to CoreData
struct CityDetailsView: View {
    // City details received as input
    var cityDetails: CityDetails
    
    // State variables for editable properties
    @State private var cityName: String = ""
    @State private var cityDescription: String = ""
    
    // Managed object context for CoreData operations
    @Environment(\.managedObjectContext) private var viewContext
    
    // Presentation mode for controlling the view presentation
    @Environment(\.presentationMode) var presentationMode
    
    // Body of the view
    var body: some View {
        VStack {
            // Display city details using CityDetailRow
            CityDetailRow(title: "City Name:", value: cityDetails.name)
            CityDetailRow(title: "Latitude:", value: "\(cityDetails.latitude)")
            CityDetailRow(title: "Longitude:", value: "\(cityDetails.longitude)")
            CityDetailRow(title: "Country:", value: cityDetails.country)
            CityDetailRow(title: "Population:", value: "\(cityDetails.population)")
            CityDetailRow(title: "Is Capital:", value: cityDetails.isCapital ? "Yes" : "No")
            
            // Display map centered on city's coordinates
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: cityDetails.latitude, longitude: cityDetails.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
            ),
                showsUserLocation: true,
                userTrackingMode: Binding(
                    get: {
                        .follow
                    },
                    set: { _ in }
                )
            )
            .frame(height: 200) // Adjust the height as needed
            .foregroundColor(.black)
            
            // Button to add the city to CoreData
            Button("Add City") {
                addCity()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
        .background(Color(UIColor.black))
    }
    
    // MARK: - Add City to CoreData
    
    // Function to add the city to CoreData
    private func addCity() {
        cityName = cityDetails.name
        guard !cityName.isEmpty else { return }
        
        // Create a new City entity in the CoreData context
        let newCity = City(context: viewContext)
        newCity.name = cityDetails.name
        newCity.cityDescription = cityDetails.country
        
        // Attempt to save the changes to the CoreData context
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss() // Dismiss the view
        } catch {
            // Handle any save errors and provide an error message
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

// MARK: - City Details View Preview

// Preview provider for the CityDetailsView
struct CityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample city details for preview
        let sampleCityDetails = CityDetails(
            name: "San Francisco",
            latitude: 37.7562,
            longitude: -122.443,
            country: "US",
            population: 3592294,
            isCapital: false
        )
        
        // Create a preview instance of CityDetailsView
        CityDetailsView(cityDetails: sampleCityDetails)
    }
}
