//
//  CityListViewModel.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: The CityListViewModel class is responsible for handling data related to cities. It includes a function to add a new city to CoreData.
//

// MARK: - Imports
import CoreData
import UIKit

class CityListViewModel: ObservableObject {
    // Published property to store an array of City objects
    @Published var cities: [City] = []

    // Function to add a new city to the CoreData context
    func addCity(context: NSManagedObjectContext) {
        // Create a new City entity in the provided context
        let newCity = City(context: context)
        
        // Set default values for the new city
        newCity.name = "New City"
        newCity.cityDescription = "A great place to explore."
        newCity.image = UIImage(systemName: "photo")?.pngData()
        
        // Attempt to save the changes to the CoreData context
        do {
            try context.save()
        } catch {
            // Handle any save errors and provide an error message
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
