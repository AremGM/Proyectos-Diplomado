//
//  ModelData.swift
//  WeatherApp
//
//  Created by Diplomado on 07/02/25.
//

import Foundation

let countries: [WeatherData] = load("LocationList.json")
    

struct WeatherData: Decodable, Identifiable {
    let id: Int
    let nombre: String
    
}


func load<T: Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("cannot find \(fileName) in bundle")
    }
    
    do {
        data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("cannot parse \(fileName) as \(T.self)")
    }
}
