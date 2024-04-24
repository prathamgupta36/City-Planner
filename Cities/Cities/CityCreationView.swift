//
//  CityCreationView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This file defines the CityCreationView, which is used to create a new city. Users can provide a name and country.
//

//***********
// Imports
//***********
import SwiftUI
import UIKit
import MobileCoreServices

struct CityCreationView: View {
    // Access the presentation mode for dismissing the view
    @Environment(\.presentationMode) var presentationMode
    
    // Access the managed object context provided by the environment
    @Environment(\.managedObjectContext) private var viewContext

    // State variables to store user inputs and control the image picker
    @State private var cityName = ""
    @State private var cityDescription = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Text fields for entering city name and description
                    TextField("City Name", text: $cityName)
                    TextField("Country", text: $cityDescription)
                }
            }
            .navigationBarTitle("Add City")
            .navigationBarItems(leading:
                // Button to cancel and dismiss the view
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing:
                // Button to save the new city
                Button("Save") {
                    addCity()
                }
            )
        }
    }

    // Function to add a new city to CoreData
    private func addCity() {
        guard !cityName.isEmpty else { return }

        // Create a new City entity in the CoreData context
        let newCity = City(context: viewContext)
        newCity.name = cityName
        newCity.cityDescription = cityDescription

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
