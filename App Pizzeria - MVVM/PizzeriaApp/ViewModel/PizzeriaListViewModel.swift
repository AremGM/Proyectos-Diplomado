//
//  PizzeriaListViewModel.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit
import Lottie

protocol PizzeriaListViewModelDelegate {
    func shouldReloadTableData()
}

class PizzeriaListViewModel{
    
    var animationView: LottieAnimationView!
    
    private let pizzeriaDataFileName = "pizza-info"
    private let favoritePizzeriaFileName = "favorite_pizzeria_list"
    private let pizzeriaDataFileExtension = "json"
    
    
    private var pizzeriaList: [PizzaData.Pizzerias] = []
    
    var favoritePizzeria: Set<PizzaData.Pizzerias> = []
    
    let pizzeriaCellIdentifier = "pizza-cell"
    
    var pizzeriaCount: Int { pizzeriaList.count }
    
    var delegate: PizzeriaListViewModelDelegate?
    
    init() {
        self.pizzeriaList = loadPizzeriaData()
        self.favoritePizzeria = Set(loadFavoritePizzeriaData())
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveFavoritePizzeria),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    func loadPizzeriaData() -> [PizzaData.Pizzerias] {
        guard let fileURL = Bundle.main.url(forResource: pizzeriaDataFileName,
                                            withExtension: pizzeriaDataFileExtension),
              let pizzaData = try? Data(contentsOf: fileURL),
              let pizzaInfo = try? JSONDecoder().decode(PizzaData.self,
                                                          from: pizzaData)
        else {
            //print("URL", pizzaList)
            assertionFailure("Cannot find \(pizzeriaDataFileName).\(pizzeriaDataFileExtension)")
            return []
        }
        
        return pizzaInfo.pizzerias
    }
    
    private func loadFavoritePizzeriaData() -> [PizzaData.Pizzerias] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let favoritePizzaURL = documentsURL.appending(component: "\(favoritePizzeriaFileName).\(pizzeriaDataFileExtension)")
        
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
    
    func pizzeria(at position: IndexPath) -> PizzaData.Pizzerias {
        pizzeriaList[position.row]
    }
    
    func isFavorite(pizzeria: PizzaData.Pizzerias) -> Bool {
        favoritePizzeria.contains(pizzeria)
    }
    
    func addPizzeriaToFavorites(at indexPath: IndexPath) {
        let pizzeria = pizzeria(at: indexPath)
        
        favoritePizzeria.insert(pizzeria)
        saveFavoritePizzeria()
        delegate?.shouldReloadTableData()
    }
    
    //Eliminar pokemon de favoritos
    func deletePizzaFromFavorites(at indexPath: IndexPath) {
        let pizzeria = pizzeria(at: indexPath)
        guard favoritePizzeria.contains(pizzeria) else {
            return
        }
        favoritePizzeria.remove(pizzeria)
        saveFavoritePizzeria()
        delegate?.shouldReloadTableData()
        
    }
    
    @objc
    func saveFavoritePizzeria() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return
        }
        
        let filename = "\(favoritePizzeriaFileName).\(pizzeriaDataFileExtension)"
        let fileURL = documentsDirectory.appending(component: filename)
        
        let favoritePizza = Array(favoritePizzeria).sorted(by: { $0.name > $1.name })
        
        do {
            let favoritePizzaData = try JSONEncoder().encode(favoritePizza)
            
            let jsonFavoritePizza = String(data: favoritePizzaData, encoding: .utf8)
            
            try jsonFavoritePizza?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Cannot encode favorite pizza: \(error.localizedDescription)")
        }
    }
    
}
