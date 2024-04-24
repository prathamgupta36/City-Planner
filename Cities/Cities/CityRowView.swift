//
//  CityRowView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This file defines the CityRowView, which is responsible for displaying individual city items in the list.
//

//***********
// Imports
//***********
import SwiftUI

struct CityRowView: View {
    // The City object to be displayed in the row
    var city: City

    var body: some View {
        HStack {
            // Display the city name, or "Unknown City" if the name is not available
            Text(city.name ?? "Unknown City")

            // Create a horizontal spacer to push the image to the right
            Spacer()
        }
    }
}
