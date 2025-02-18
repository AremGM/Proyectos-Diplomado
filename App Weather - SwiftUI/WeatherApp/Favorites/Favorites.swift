//
//  Favorites.swift
//  WeatherApp
//
//  Created by Emiliano Gil  on 09/02/25.
//

import Foundation
import UIKit

//Observable para notar los cambios en todas las vistas
class Favorites: ObservableObject {
    
    let favoriteCountriesFileName = "favoriteCountries.json"
    
    //Se actualice en todas las vistas 
    @Published var favoriteCountriesCollection: Set<String> = [] {
        didSet {
            saveFavoriteCountries()
        }
    }
    
    init() {
        self.favoriteCountriesCollection = Set(loadFavoriteCountriesData())
    }
    
    
    //Carga los datos
    private func loadFavoriteCountriesData() -> [String] {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let favoriteCountriesURL = documentsURL.appending(component: "\(favoriteCountriesFileName)")
        
        
        // Validar si el archivo ya existe
        if !FileManager.default.fileExists(atPath: favoriteCountriesURL.path) {
            print("Favorites file does not exist. Creating an empty one...")

            let emptyFavorites: [String] = []
            do {
                let emptyData = try JSONEncoder().encode(emptyFavorites)
                try emptyData.write(to: favoriteCountriesURL, options: .atomic)
                //print("Archivo creado en: \(favoriteCountriesURL.path)")
            } catch {
                assertionFailure("Error empty file: \(error.localizedDescription)")
                return []
            }
        }
        
        
        do {
            let favoriteCountriesData = try Data(contentsOf: favoriteCountriesURL)
            let favoriteCountriesList = try JSONDecoder().decode([String].self,
                                                               from: favoriteCountriesData)
            return favoriteCountriesList
        } catch {
            assertionFailure("Cannot load favorite countries file")
            return []
        }
    }
    
    
    //Actualiza los datos guardados
    func saveFavoriteCountries() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return
        }
        
        let filename = "\(favoriteCountriesFileName)"
        let fileURL = documentsDirectory.appending(component: filename)
        
        let favoriteCountries = Array(favoriteCountriesCollection).sorted(by: { $0 > $1 })
        
        do {
            let favoriteCountriesData = try JSONEncoder().encode(favoriteCountries)
            
            let jsonCountries = String(data: favoriteCountriesData, encoding: .utf8)
            
            try jsonCountries?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Cannot encode favorite countries: \(error.localizedDescription)")
        }
    }
    
    
    //Agrega
    func addCountryFavorites(country: String) {
        favoriteCountriesCollection.insert(country)
        saveFavoriteCountries()
        //print(favoriteCountriesCollection)
    }
    
    //Elimina
    func deleteCountryFavorites(country: String) {
        favoriteCountriesCollection.remove(country)
        saveFavoriteCountries()
        //print(favoriteCountriesCollection)
    }
    
    
    
}
