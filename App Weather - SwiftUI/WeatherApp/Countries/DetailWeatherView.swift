//
//  DetailWeatherView.swift
//  WeatherApp
//
//  Created by Emiliano Gil  on 08/02/25.
//

import SwiftUI
import MapKit

struct DetailWeatherView: View {
    let country: String
    @State private var weatherData: CountryWeatherData?
    @State private var errorMessage: String?
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss

    //Segmented
    let opciones = ["C", "F"]
    @State private var seleccion: Int = 0
    
    
    @EnvironmentObject var favoriteCountry: Favorites
    
    //Colores de pantalla
    private let nightColor = Color(red: 25/255, green: 25/255, blue: 112/255)
    private let dayColor = Color(red: 135/255, green: 206/255, blue: 235/255)
    
    private var backgroundColor: Color {
        guard let weather = weatherData else { return Color.white }
        
        let isDay = weather.current.isDay
        
        return isDay == 0 ? nightColor : dayColor
    }
    
    
    private var coordinateRegion: MKCoordinateRegion? {
        guard let coordinate = weatherData?.location else { return nil }
        
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                            longitude: coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 29.0,
                                    longitudeDelta: 29.0)
        
        return MKCoordinateRegion(center: center,
                                  span: span)
    }
    
    private var pinLocationCountry: CLLocationCoordinate2D? {
        guard let coordinate = weatherData?.location else { return nil }
        
        return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    
    var body: some View {
        ZStack {
            
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let weather = weatherData {
                    Text("\(weather.location.region)")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Picker("Opciones", selection: $seleccion) {
                        ForEach(0..<opciones.count, id: \.self) { index in
                            Text(opciones[index]).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 95)
                    Spacer()
                    HStack{
                        
                        AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        Spacer()
                        
                        //Grados
                        Text("\(degreesCF(selected: seleccion), specifier: "%.1f")°")
                            .font(.system(size: 60))
                            .bold()
                        Spacer()
                        Text("UV: \(weather.current.uv, specifier: "%.1f")")
                    }
                    .frame(width: 300)
                    
                    Spacer()
                    Text(changeDateFormat(dateApi: weather.location.localtime))
                    Spacer()
                    if let coordinateRegion {
                        Map(initialPosition: MapCameraPosition.region(coordinateRegion))
                            .frame(width: 330,height: 290)
                    }
                    Spacer()
                    Text("Last update: \(changeDateFormat(dateApi: weather.current.lastUpdated))")
                        .padding([.leading], 130)
                    Spacer()
                } else {
                    ProgressView("Cargando clima...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.title2)
                        .padding()
                        .onAppear {
                            fetchWeather()
                        }
                }
            }
            .navigationTitle(country)
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if favoriteCountry.favoriteCountriesCollection.contains(country) == false {
                            favoriteCountry.addCountryFavorites(country: country)
                        } else {
                            favoriteCountry.deleteCountryFavorites(country: country)
                        }
                        
                    }) {
                        Image(systemName: favoriteCountry.favoriteCountriesCollection.contains(country) ? "star.fill" : "star")
                        
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            
        }
        
        // Alerta en caso de error
        .alert("Error", isPresented: $showAlert) {
            Button("Aceptar") {
                dismiss()
            }
        } message: {
            Text(errorMessage ?? "Ocurrió un error inesperado.") // Mensaje de error
        }
        
    }
    
    
    
    //Obtener los datos de la API
    private func fetchWeather() {
        APIKey.instance.getWeatherData(country: country) { data, error in
            DispatchQueue.main.async {
                if let data = data {
                    self.weatherData = data
                } else if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true // Activa la alerta
                }
            }
        }
    }
    
    //Funcion del segmented
    private func degreesCF(selected: Int) -> Double {
        if selected == 0 {
            return weatherData!.current.temperatureCelsius
        } else {
            return weatherData!.current.temperatureFarenheit
        }
    }
    
    //Formato de fecha
    private func changeDateFormat (dateApi: String) -> String{
        let currentFormat = DateFormatter()
        currentFormat.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = currentFormat.date(from: dateApi) {
            let newFormat = DateFormatter()
            newFormat.dateFormat = "dd/MM/yyyy HH:mm"
            
            let newDate = newFormat.string(from: date)
            return newDate
        } else {
            return dateApi
        }
    }
    
    
}

#Preview {
    DetailWeatherView(country: "Mexico")
        .environmentObject(Favorites())
}
