//
//  PizzeriaLocationViewModel.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 30/01/25.
//
import UIKit
import MapKit
import CoreLocation


protocol PizzeriaLocationViewModelDelegate: AnyObject {
    func updateUserLocation(userLocation: CLLocationCoordinate2D)
    func showPizzeriaLocation(location: CLLocationCoordinate2D)
    func showDirectionsOverlay(overlay: MKPolyline)
    func adjustMapRegion(rect: MKMapRect)

}

class PizzeriaLocationViewModel: NSObject {
    private let pizzeria: PizzaData.Pizzerias // Instancia del Pokémon a ubicar
    let pizzeriaImage: String // Imagen del Pokémon
    
    private let locationManager = CLLocationManager() // Administrador de ubicación del usuario
    
    private(set) var userLocation: CLLocationCoordinate2D? // Ubicación actual del usuario
    
    weak var delegate: PizzeriaLocationViewModelDelegate? // Delegado para comunicarse con la vista
    
    // Inicializador de la clase con el Pokémon y su imagen
    init(pizzeria: PizzaData.Pizzerias, pizzeriaImage: String) {
        self.pizzeria = pizzeria
        self.pizzeriaImage = pizzeriaImage
        super.init()
        initializerForLocationManager()
        locationManager.delegate = self
    }
    
    // Configura el CLLocationManager para obtener la ubicación del usuario
    func initializerForLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Mejor precisión posible
        locationManager.requestWhenInUseAuthorization() // Solicita permiso para usar la ubicación cuando la app está en uso
        locationManager.startUpdatingLocation() // Comienza a actualizar la ubicación del usuario
    }
    
    
    // Método que se ejecuta cuando se presiona el botón para mostrar la ubicación de la pizzeria
    func didTapPizzeriaLocationButton() {
        guard let location = pizzeria.coordinates else { return }
        
        let pizzeriaLocation = CLLocationCoordinate2D(latitude: location.latitude,
                                                     longitude: location.longitude)
        print("Ubicación de la pizzería al tocar su boton: \(pizzeriaLocation.latitude), \(pizzeriaLocation.longitude)")
        delegate?.showPizzeriaLocation(location: pizzeriaLocation) // Llama al delegado para mostrar la ubicación
    }
    
    
    // Método que se ejecuta cuando se presiona el botón para mostrar la ubicación del usuario
    func didTapUserLocationButton() {
        guard let location = userLocation else { return }
        
        let userLocation = CLLocationCoordinate2D(latitude: location.latitude,
                                                     longitude: location.longitude)
        print("Ubicación del usuario al apretar su boton: \(userLocation.latitude), \(userLocation.longitude)")
        delegate?.updateUserLocation(userLocation: userLocation) // Llama al delegado para mostrar la ubicación
    }
    
    // Método que se ejecuta cuando se presiona el botón para mostrar la ruta hacia la pizzeria
    func didTapShowDirectionButton() {
        
        guard let userLocation, let pizzeriaLocation = pizzeria.coordinates else {
            print("Ubicación del usuario o pizzería es nil")
            return
        }
        print("Ubicación del usuario: \(userLocation.latitude), \(userLocation.longitude)")
        print("Ubicación de la pizzería: \(pizzeriaLocation.latitude), \(pizzeriaLocation.longitude)")
        
        let pizzeriaCoordinte = CLLocationCoordinate2D(latitude: pizzeriaLocation.latitude,
                                                       longitude: pizzeriaLocation.longitude)
        
        let directionsRequest = MKDirections.Request()
        
        // Configura la ruta desde la ubicación del usuario hasta la pizzeria
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: pizzeriaCoordinte))
        
        directionsRequest.transportType = .automobile // Define el tipo de transporte (transporte público en este caso)
        
        let directions = MKDirections(request: directionsRequest)
        
        // Calcula la ruta y muestra la superposición en el mapa
        directions.calculate { response, error in
            guard error == nil,
                  let response,
                  let route = response.routes.first
            else { return }
            
            self.delegate?.showDirectionsOverlay(overlay: route.polyline)
            
            // Calcular el rectángulo que engloba la ruta
            let routeRect = route.polyline.boundingMapRect
            
            DispatchQueue.main.async {
                self.delegate?.adjustMapRegion(rect: routeRect)
            }
        }
    }
    
    
    
}


// Extensión para manejar la actualización de ubicación del usuario
extension PizzeriaLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        //print("Ubicación actualizada: \(coordinate.latitude), \(coordinate.longitude)")
            
        
        userLocation = coordinate // Actualiza la ubicación del usuario
    }
}
