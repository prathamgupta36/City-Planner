//
//  CitiesApp.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This app lets the user find cities and view them on a map with a lot of information about them. If the user wants to visit the city one day. They can add it to their bucket list where the user has an option to check weather and see the city on a map.
//

//***********
// Imports
//***********
import SwiftUI

//**********************************
// Basic Main Takes to Main View
//**********************************
@main
struct CitiesApp: App {
    // Create an instance of the PersistenceController for managing CoreData
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        // Define the main scene of the app
        WindowGroup {
            // Display the CityListView as the main view
            WelcomeView()
        }
    }
}

