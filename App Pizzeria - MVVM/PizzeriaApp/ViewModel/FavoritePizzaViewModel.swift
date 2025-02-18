//
//  FavoritePizzaViewModel.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit

class FavoritePizzaViewModel{
    private let favoritePizzaDataName = "favorite_pizza_list"
    private let dataExtension = "json"
    private let favoritePizzeriaDataName = "favorite_pizzeria_list"
    
    
    
    private(set) var favoritePizzaList: [PizzaData.Pizzas] = []
    
    private(set) var favoritePizzeriaList: [PizzaData.Pizzerias] = []
    
    let cellIdentifier = "pizza_cell"
    var numberOfSections: Int { 2 }
    var numberOfRows: Int { favoritePizzaList.count }
    var numberOfRowsPizzeria: Int { favoritePizzeriaList.count }
    
    init() {
        favoritePizzaList = loadFavoritePizza()
        favoritePizzeriaList = loadFavoritePizzeria()
    }
    
    func pizza(at indexPath: IndexPath) -> PizzaData.Pizzas {
        favoritePizzaList[indexPath.row]
    }
    
    func pizzeria(at indexPath: IndexPath) -> PizzaData.Pizzerias {
        favoritePizzeriaList[indexPath.row]
    }
    
    private func loadFavoritePizza() -> [PizzaData.Pizzas] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let favoritePizzaURL = documentsURL.appending(component: "\(favoritePizzaDataName).\(dataExtension)")
        
        do {
            let favoritePizzaData = try Data(contentsOf: favoritePizzaURL)
            let favoritePizzaList = try JSONDecoder().decode([PizzaData.Pizzas].self,
                                                               from: favoritePizzaData)
            return favoritePizzaList
        } catch {
            assertionFailure("Cannot load favorite pizza file")
            return []
        }
    }
    
    
    private func loadFavoritePizzeria() -> [PizzaData.Pizzerias] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let favoritePizzaURL = documentsURL.appending(component: "\(favoritePizzeriaDataName).\(dataExtension)")
        
        do {
            let favoritePizzaData = try Data(contentsOf: favoritePizzaURL)
            let favoritePizzaList = try JSONDecoder().decode([PizzaData.Pizzerias].self,
                                                               from: favoritePizzaData)
            return favoritePizzaList
        } catch {
            assertionFailure("Cannot load favorite pizza file")
            return []
        }
    }
    
    
    func updateFavoritePizzaTable() {
        favoritePizzaList = loadFavoritePizza()
        favoritePizzeriaList = loadFavoritePizzeria()
    }
}
