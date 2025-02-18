//
//  CountryWeatherData.swift
//  WeatherApp
//
//  Created by Emiliano Gil  on 08/02/25.
//

import Foundation

struct CountryWeatherData: Codable, Equatable, Hashable {
    let location: Location
    let current: CurrentWeather
    
    static func == (lhs: CountryWeatherData, rhs: CountryWeatherData) -> Bool {
        return lhs.location.name == rhs.location.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.name)
    }
}

struct Location: Codable {
    let name: String
    let region: String
    let localtime: String
    let latitude: Double
    let longitude: Double
    
    
    enum CodingKeys: String, CodingKey {
        case name, region
        case latitude = "lat"
        case longitude = "lon"
        case localtime
    }
    
}

struct CurrentWeather: Codable {
    let lastUpdated: String
    let temperatureCelsius: Double
    let temperatureFarenheit: Double
    let isDay: Int
    let condition: Condition
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case temperatureCelsius = "temp_c"
        case temperatureFarenheit = "temp_f"
        case isDay = "is_day"
        case condition, uv
    }
    
}

struct Condition: Codable {
    let text: String
    let icon: String
}
