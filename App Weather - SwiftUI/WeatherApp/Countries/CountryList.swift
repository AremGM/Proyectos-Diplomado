//
//  ContentView.swift
//  WeatherApp
//
//  Created by Diplomado on 07/02/25.
//

import SwiftUI

struct CountryList: View {

    //Para acceder a los datos actualizados
    @EnvironmentObject var countriesFavorite: Favorites
    
    var body: some View {
        NavigationSplitView {
            List (countries){ country in
                
                NavigationLink {
                    DetailWeatherView(country: country.nombre)
                        .environmentObject(countriesFavorite)
                    
                } label: {
                    CountryRow(country: country)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries")
        } detail: {
            Text("Select a country")
        }
    }
}


#Preview {
    CountryList()
        .environmentObject(Favorites())
}
