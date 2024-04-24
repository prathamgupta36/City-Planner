//
//  WecomeView.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This is the welcome view which welcomes the user to the App.
//

// MARK: - Imports
import SwiftUI

struct WelcomeView: View {
    // MARK: - Properties

    // Shared persistence controller for Core Data
    let persistenceController = PersistenceController.shared

    // State variables for the quote and author
    @State private var quote: String = "Live life the way you want."
    @State private var author: String = "Unknown"

    // MARK: - Body

    var body: some View {
        // MARK: Navigation View

        NavigationView {
            VStack {
                // MARK: - App Title

                Text("Welcome to \(Text("**City Explorer**").foregroundColor(.orange))")
                    .font(.title)
                    .padding()

                // MARK: - Description

                Text("Search for \(Text("cities").foregroundColor(.green)) you want to visit and add them to your \(Text("bucket list").foregroundColor(.green)).")
                    .multilineTextAlignment(.center)
                    .padding()

                // MARK: - Navigation Link

                NavigationLink(destination: CityListView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .toolbarRole(.editor)
                    .navigationBarBackButtonHidden(true)) {
                    Text("**Start Exploring**")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding()
                .padding()
                
                // MARK: - Spacer

                Spacer()

                // MARK: - Quote Section

                Text("Quote on \(Text("**Happiness**").bold().foregroundColor(.teal))")
                    .font(.system(size: 18, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Display the fetched quote
                Text(quote)
                    .font(.system(size: 18, weight: .bold))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                // Display the author of the quote
                Text("- \(author)")
                    .foregroundColor(.gray)
                    .padding()

                // MARK: - Spacer

                Spacer()
                Spacer()
                Spacer()
            }
        }
        // Fetch a quote when the view appears
        .onAppear {
            fetchQuote()
        }
        // Set the preferred color scheme to dark
        .preferredColorScheme(.dark)
        // Hide the navigation bar
        .navigationBarHidden(true)
    }

    // MARK: - Functions

    // Function to fetch a quote from the API
    func fetchQuote() {
        let category = "happiness".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=" + category!)!

        var request = URLRequest(url: url)
        request.setValue("vku3TcurKChIAZSB2yVMOw==emc2Nlm2D2RVuevX", forHTTPHeaderField: "X-Api-Key")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                // Decode the quote data
                if let quoteArray = try? JSONDecoder().decode([Quote].self, from: data), let firstQuote = quoteArray.first {
                    DispatchQueue.main.async {
                        self.quote = firstQuote.quote
                        self.author = firstQuote.author
                    }
                } else if let quoteDict = try? JSONDecoder().decode(Quote.self, from: data) {
                    DispatchQueue.main.async {
                        self.quote = quoteDict.quote
                        self.author = quoteDict.author
                    }
                } else {
                    print("Unable to decode quote data.")
                }
            } catch {
                print("Error decoding quote data: \(error)")
            }
        }

        task.resume()
    }
}

// MARK: - Quote Model

// Struct to represent a quote with Codable conformance
struct Quote: Codable {
    let quote: String
    let author: String
    let category: String
}

// MARK: - Preview

// Preview provider for the WelcomeView
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
