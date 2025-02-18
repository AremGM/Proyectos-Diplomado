//
//  IngredientesViewModel.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit

protocol IngredientsListViewModelDelegate {
    func shouldReloadTableData()
}

class IngredientesViewModel{
    
    //Info del json principal
    private let ingredientsDataFileName = "pizza-info"
    //Info de las nuevas pizza
    private let newPizzasFileName = "new_pizza_list"
    //Info de los ingredientes nuevos
    private let newIngredientesDataName = "new_Ingrediens"
    
    private let dataFileExtension = "json"
    
    //Info del JSON
    private var ingredientsList: [String] = []
    var ingredientsCount: Int { ingredientsList.count }
    
    //Datos para guardar
    var selectedIngredients: Set<String> = []
    var newNamePizza: String!
    var newPizzas: Set<PizzaData.Pizzas> = []
    
    let ingredientCellIdentifier = "IngredientesCell"
    
    var delegate: IngredientsListViewModelDelegate?
    
    init() {
        self.ingredientsList = allLoadInngredients()
        self.newPizzas = Set(loadNewPizzasData())
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveNewPizzas),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    
    func allLoadInngredients () -> [String] {
        //print(loadNewIngredientsData())
        if loadNewIngredientsData().count > 0 {
            return loadIngredientsData() + loadNewIngredientsData()
        } else {
            return loadIngredientsData()
        }
        
        
    }
    
    func loadIngredientsData() -> [String] {
        guard let fileURL = Bundle.main.url(forResource: ingredientsDataFileName,
                                            withExtension: dataFileExtension),
              let ingredientsData = try? Data(contentsOf: fileURL),
              let ingredientsInfo = try? JSONDecoder().decode(PizzaData.self,
                                                              from: ingredientsData)
        else {
            //print("URL", pizzaList)
            assertionFailure("Cannot find \(ingredientsDataFileName).\(dataFileExtension)")
            return []
        }
        
        return ingredientsInfo.ingredients
    }
    
    func loadNewIngredientsData() -> [String] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let newIngredientsURL = documentsURL.appending(component: "\(newIngredientesDataName).\(dataFileExtension)")
        
        do {
            let newIngredientsData = try Data(contentsOf: newIngredientsURL)
            let newIngredientsList = try JSONDecoder().decode([String].self,
                                                             from: newIngredientsData)
            return newIngredientsList
        } catch {
            assertionFailure("Cannot load new ingredients file")
            return []
        }
    }
    
    private func loadNewPizzasData() -> [PizzaData.Pizzas] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let newPizzasURL = documentsURL.appending(component: "\(newPizzasFileName).\(dataFileExtension)")
        
        do {
            let newPizzasData = try Data(contentsOf: newPizzasURL)
            let newPizzasList = try JSONDecoder().decode([PizzaData.Pizzas].self,
                                                             from: newPizzasData)
            return newPizzasList
        } catch {
            assertionFailure("Cannot load favorite pizza file")
            return []
        }
    }
    
    func ingredient(at position: IndexPath) -> String {
        ingredientsList[position.row]
    }
    
    func isSelected(ingredient: Int) {
        selectedIngredients.insert(ingredientsList[ingredient])
    }
    
    func isNotSelected(ingredient: Int) {
        selectedIngredients.remove(ingredientsList[ingredient])
    }
    
    
    func hidenButton() -> Bool {
        if selectedIngredients.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    func updateSelectedIngredients() {
        newPizzas.insert(PizzaData.Pizzas(name: newNamePizza, ingredients: Array(selectedIngredients)))
        selectedIngredients.removeAll()
        //print(newPizzas)
        saveNewPizzas()
        delegate?.shouldReloadTableData()
    }
    
    @objc
    func saveNewPizzas() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return
        }
        
        let filename = "\(newPizzasFileName).\(dataFileExtension)"
        let fileURL = documentsDirectory.appending(component: filename)
        
        let favoritePizza = Array(newPizzas).sorted(by: { $0.name > $1.name })
        
        do {
            let favoritePizzaData = try JSONEncoder().encode(favoritePizza)
            
            let jsonFavoritePizza = String(data: favoritePizzaData, encoding: .utf8)
            
            try jsonFavoritePizza?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Cannot encode favorite pizza: \(error.localizedDescription)")
        }
    }
    
    func updateIngredientsListTable() {
        ingredientsList = allLoadInngredients()
    }
    
}
