//
//  CityListView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This is the list of the cities which user wants to visit.
//

//***********
// Imports
//***********
import SwiftUI
import CoreData

struct CityListView: View {
    // Access the managed object context provided by the environment
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch cities from CoreData with sorting
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: true)]) var cities: FetchedResults<City>

    // Create an instance of the CityListViewModel
    @StateObject var viewModel = CityListViewModel()

    // State variable to control the city creation sheet
    @State private var isAddingCity = false
    @State private var  isShowingCitySearch = false

    var body: some View {
        NavigationView {
            List {
                // Display a list of cities and provide a link to the detail view
                ForEach(cities, id: \.self) { city in
                    NavigationLink(destination: CityDetailView(city: city)) {
                        CityRowView(city: city)
                    }
                }
                // Enable city deletion
                .onDelete(perform: deleteCity)
            }
            .listStyle(PlainListStyle())
            
            // Set the navigation bar title and add buttons for editing and adding cities
            .navigationBarTitle("Cities Bucket List")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                isAddingCity = true
            }) {
                Image(systemName: "plus")
            })
            .navigationBarItems(trailing: Button(action: {
                // Navigate to CitySearchView when the button is clicked
                isAddingCity = false // close the city creation sheet if open
                isShowingCitySearch = true
            }) {
                Text("Search City")
                    .foregroundColor(.green)
            }
                .sheet(isPresented: $isShowingCitySearch) {
                    CitySearchView()
                }
            )
            .preferredColorScheme(.dark)
        }

        // Display the city creation sheet when isAddingCity is true
        .sheet(isPresented: $isAddingCity) {
            CityCreationView()
                .environment(\.managedObjectContext, viewContext)
        }
    }

    
    // Delete a city at specified offsets
    private func deleteCity(at offsets: IndexSet) {
        for index in offsets {
            let city = cities[index]
            viewContext.delete(city)
        }
        do {
            // Save changes after city deletion
            try viewContext.save()
        } catch {
            // Handle any save errors
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    // Provide a preview of the CityListView
    static var previews: some View {
        CityListView()
    }
}
