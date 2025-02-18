//
//  Pizzas.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import Foundation

// PIZZAS
struct PizzaData: Codable {
    
    let pizzas: [Pizzas]
    let pizzerias: [Pizzerias]
    let ingredients: [String]
    
    struct Pizzas: Codable, Equatable, Hashable { // Aquí conformas Pizzas a Equatable y Hashable
        
        let name: String
        let ingredients: [String]
        
        static func == (lhs: Pizzas, rhs: Pizzas) -> Bool {
            return lhs.name == rhs.name
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
    }
    
    // PIZZERIAS
    struct Pizzerias: Codable, Equatable, Hashable {
        let name: String
        let address: String
        let coordinates: Coordinate?
        
        static func == (lhs: Pizzerias, rhs: Pizzerias) -> Bool {
            return lhs.name == rhs.name
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
        
    }

    struct Coordinate: Codable {
        let latitude: Double
        let longitude: Double
    }
}
