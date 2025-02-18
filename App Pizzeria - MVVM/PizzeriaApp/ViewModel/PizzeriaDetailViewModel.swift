//
//  PizzeriaDetailViewModel.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 27/01/25.
//

import UIKit


class PizzeriaDetailViewModel {
    
    
    let pizzeria: PizzaData.Pizzerias
    
    var pizzaName: String { pizzeria.name }
    
    init (pizzeria: PizzaData.Pizzerias) {
        self.pizzeria = pizzeria
    }
    
}
