//
//  PizzaDetailViewModel.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 26/01/25.
//

import UIKit


class PizzaDetailViewModel {
    
    let pizzaCellDetail = "pizzaDetal-cell"
    let pizza: PizzaData.Pizzas
    
    var pizzaName: String { pizza.name }
    
    var pizzaIngredients: [String] { pizza.ingredients }
    
    
    init(pizza: PizzaData.Pizzas) {
        self.pizza = pizza
    }
    
    

}
