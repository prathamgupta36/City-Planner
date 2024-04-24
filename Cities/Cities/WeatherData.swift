//
//  WeatherData.swift
//  Cities
//
//  Name: Pratham Gupta
//  Description: This is the place where we define weather.
//

// MARK: - Imports

import SwiftUI
import Foundation

// MARK: - Weather Data Model

// Weather data model conforming to Decodable protocol
struct WeatherData: Decodable {
    // Properties representing various weather attributes
    let wind_speed: Double
    let wind_degrees: Int
    let temp: Int
    let humidity: Int
    let sunset: Int
    let min_temp: Int
    let cloud_pct: Int
    let feels_like: Int
    let sunrise: Int
    let max_temp: Int
    
    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case wind_speed
        case wind_degrees
        case temp
        case humidity
        case sunset
        case min_temp
        case cloud_pct
        case feels_like
        case sunrise
        case max_temp
    }
}
