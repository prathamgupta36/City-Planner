//
//  CityDetails.swift
//  Cities
//
//  Name: Pratham Gupta
//

// MARK: - Imports
import Foundation

// MARK: - City Details Model

// Codable struct representing details of a city
struct CityDetails: Codable {
    // Properties for city details
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let population: Int
    let isCapital: Bool

    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude, country, population, isCapital = "is_capital"
    }
}
