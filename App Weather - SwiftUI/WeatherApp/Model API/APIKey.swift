//
//  APIKey.swift
//  WeatherApp
//
//  Created by Emiliano Gil  on 08/02/25.
//

import Foundation


//Singleton
class APIKey {
    static let instance = APIKey()
    private var apiKey: String
    
    private init() {
        
        // Obtener la API Key de Info.plist
        if let key = Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String {
            self.apiKey = key
        } else {
            fatalError("APIKEY no encontrada en Info.plist")
        }
        
    }
    
    //Llamadas a servicio
    func getWeatherData(country: String, completion: @escaping (CountryWeatherData?, Error?) -> Void){
        guard let url = URL (string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(country)&aqi=no") else {
            return
        }
        
        //Tarea para la solicitud
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(CountryWeatherData.self, from: data!)
                completion(weatherData, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }

            
    
}
