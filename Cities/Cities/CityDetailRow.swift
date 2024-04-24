//
//  CityDetailRow.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This is how we display the details for the city.
//

// MARK: - Imports
import SwiftUI

// MARK: - City Detail Row

// View for displaying a row of city details
struct CityDetailRow: View {
    // Properties for the title and value of the row
    var title: String
    var value: String

    // Body of the view
    var body: some View {
        HStack {
            // Display the title with a headline font and blue color
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            // Add spacer to push the value to the right
            Spacer()
            
            // Display the value with a body font and blue color
            Text(value)
                .font(.body)
                .foregroundColor(.blue)
        }
        .preferredColorScheme(.dark) // Set the preferred color scheme to dark
    }
}
