//
//  AddIngredientViewModel.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 29/01/25.
//

import UIKit

protocol AddIngredientViewModelDelegate {
    
}

class AddIngredientViewModel {
    private let newIngredientesDataName = "new_Ingrediens"
    private let dataextension = "json"
    
    //Info para guardar
    var newIngredients: [String] = []
    
    init() {
        self.newIngredients = loadNewIngredientsData()
        //printIngredients()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveNewIngredients),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    
    @objc
    func saveNewIngredients() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return
        }
        
        let filename = "\(newIngredientesDataName).\(dataextension)"
        let fileURL = documentsDirectory.appending(component: filename)
        
        let newIngredients = newIngredients.sorted(by: { $0 > $1 })
        
        do {
            let newIngredientsData = try JSONEncoder().encode(newIngredients)
            
            let jsonNewIngredients = String(data: newIngredientsData, encoding: .utf8)
            
            try jsonNewIngredients?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Cannot encode favorite pizza: \(error.localizedDescription)")
        }
    }
    
    
    func loadNewIngredientsData() -> [String] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let newIngredientsURL = documentsURL.appending(component: "\(newIngredientesDataName).\(dataextension)")
        
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
    
    
}
