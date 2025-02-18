//
//  CountryRow.swift
//  WeatherApp
//
//  Created by Diplomado on 07/02/25.
//

import SwiftUI

struct CountryRow: View {
    let country: WeatherData
    
    var body: some View {
        HStack{
            Text("\(country.nombre)")
                .frame(width: 80)
                
            Image("\(imageWrongName(name: country.nombre))")
                .resizable()
                .scaledToFit()
                .frame(width: 165)
                .padding([.leading], 50)
        }
        .frame(width: 400)
    }
}


func imageWrongName(name: String) -> String{
    if name == "Canada" {
        return "CanadáCA"
    } else {
        return name
    }
}


#Preview {
    CountryRow(country: countries.first!)
}
