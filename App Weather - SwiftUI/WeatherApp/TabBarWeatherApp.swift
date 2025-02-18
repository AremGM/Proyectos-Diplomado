//
//  TabBarWeatherApp.swift
//  WeatherApp
//
//  Created by Emiliano Gil  on 08/02/25.
//

import SwiftUI

struct TabBarWeatherApp: View {
    
    //Instancia global
    @StateObject var favorites = Favorites()
    
    var body: some View {
        
        TabView{
            CountryList()
            //Para usar la instancia observableObject
                .environmentObject(favorites)
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Ubicación")
                }
            
            FavoriteCountries()
            //Para usar la instancia observableObject
                .environmentObject(favorites)
                .tabItem {
                    Image(systemName: "star")
                    Text("Favoritos")
                }
        }
    }
}


#Preview {
    TabBarWeatherApp()
        .environmentObject(Favorites())
}
