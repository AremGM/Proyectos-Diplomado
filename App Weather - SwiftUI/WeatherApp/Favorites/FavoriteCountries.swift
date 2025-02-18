//
//  FavoriteCountries.swift
//  WeatherApp
//
//  Created by Emiliano Gil  on 08/02/25.
//

import SwiftUI

struct FavoriteCountries: View {
    
    @EnvironmentObject var countries: Favorites
    
    let columnas = [GridItem(.flexible()), GridItem(.flexible())] // 2 columnas
    
    var body: some View {
        NavigationSplitView{
            ScrollView {
                
                LazyVGrid(columns: columnas, spacing: 10) {
                    ForEach(Array(countries.favoriteCountriesCollection), id: \.self) { item in
                        
                        NavigationLink {
                            DetailWeatherView(country: item)
                        } label: {
                            
                            Image("\(imageWrongNameFavorite(name: item))")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 170, height: 135)
                        }
                        
                    }
                    //Spacer()
                }
                .padding()
                
            }
        }detail: {
            Text("hola")
        }
    }
}

func imageWrongNameFavorite(name: String) -> String{
    if name == "Canada" {
        return "CanadáCA"
    } else {
        return name
    }
}

#Preview {
    FavoriteCountries()
        .environmentObject(Favorites())
}
