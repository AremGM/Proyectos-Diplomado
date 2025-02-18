//
//  PizzeriaLocationViewController.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 30/01/25.
//

import UIKit
import MapKit
import CoreLocation

class PizzeriaLocationViewController: UIViewController {

    private let viewModel: PizzeriaLocationViewModel // ViewModel que maneja la lógica de la ubicación del Pokémon
    
    // Creación y configuración del mapa
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    // Botón para cerrar la vista
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Close"
        
        button.configuration = configuration
        
        button.addTarget(self,
                         action: #selector(closeButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    // Botón para mostrar la ubicación del Pokémon en el mapa
    private lazy var showPizzeriaLocation: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Pizzeria Location"
        
        button.configuration = configuration
        
        button.addTarget(self,
                         action: #selector(didTapShowPizzeriaButton),
                         for: .touchUpInside)
        return button
    }()
    
    // Botón para mostrar la ubicación del Pokémon en el mapa
    private lazy var showUserLocation: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "User Location"
        
        button.configuration = configuration
        
        button.addTarget(self,
                         action: #selector(didTapShowUserButton),
                         for: .touchUpInside)
        return button
    }()
    
    // Botón para mostrar la ruta hacia el Pokémon en el mapa
    private lazy var showDirectionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Directions to Pizzeria"
        
        button.configuration = configuration
        
        button.addTarget(self,
                         action: #selector(didTapShowDirectionsButton),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        viewModel.delegate = self
        mapView.delegate = self
        
        viewModel.didTapPizzeriaLocationButton()
        
    }
    
    // Inicializador del controlador con la información del Pokémon
    init(pizzeria: PizzaData.Pizzerias, pizzeriaImage: String) {
        self.viewModel = PizzeriaLocationViewModel(pizzeria: pizzeria,
                                               pizzeriaImage: pizzeriaImage)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuración de la vista y sus restricciones
    func setupView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor,
                                             constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant:  -20)
        ])
        
//        view.addSubview(showUserLocation)
//        NSLayoutConstraint.activate([
//            showUserLocation.topAnchor.constraint(equalTo: view.topAnchor,
//                                             constant: 20),
//            showUserLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor,
//                                                  constant:  20)
//        ])
        
        
        view.addSubview(showPizzeriaLocation)
        view.addSubview(showDirectionsButton)
        NSLayoutConstraint.activate([
            showPizzeriaLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            showPizzeriaLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            showPizzeriaLocation.leadingAnchor.constraint(equalTo: showDirectionsButton.trailingAnchor, constant: 40),
            //showPizzeriaLocation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            showDirectionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showDirectionsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
            //showDirectionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
        
    // Acción del botón para cerrar la vista
    @objc
    func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // Acción del botón para mostrar la ubicación de la pizzeria
    @objc
    func didTapShowPizzeriaButton() {
        viewModel.didTapPizzeriaLocationButton()
    }

    
    // Acción del botón para mostrar la ubicación de usuario
    @objc
    func didTapShowUserButton() {
        viewModel.didTapUserLocationButton()
    }
    
    // Acción del botón para mostrar la ruta hacia la pizzeria
    @objc
    func didTapShowDirectionsButton() {
        viewModel.didTapShowDirectionButton()
    }
    

}

extension PizzeriaLocationViewController: PizzeriaLocationViewModelDelegate {
    func showDirectionsOverlay(overlay: MKPolyline) {
        mapView.addOverlay(overlay)
    }
    
    func updateUserLocation(userLocation: CLLocationCoordinate2D) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation
        
        mapView.addAnnotation(userAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: userLocation,
                                           span: MKCoordinateSpan(latitudeDelta: 0.001,
                                                                  longitudeDelta: 0.001))
        
        mapView.region = mapRegion
    }
    
    func showPizzeriaLocation(location: CLLocationCoordinate2D) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = location
        
        mapView.addAnnotation(userAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: location,
                                           span: MKCoordinateSpan(latitudeDelta: 0.001,
                                                                  longitudeDelta: 0.01))
        
        mapView.region = mapRegion
    }
    
    func adjustMapRegion(rect: MKMapRect) {
        let edgePadding = UIEdgeInsets(top: 70, left: 70, bottom: 70, right: 70)
        mapView.setVisibleMapRect(rect, edgePadding: edgePadding, animated: true)
    }
}

extension PizzeriaLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        // Evitar cambiar la visualización de la ubicación del usuario
//        guard !(annotation is MKUserLocation) else { return nil }
//        
//        let annotationView = MKMarkerAnnotationView()
//
//        annotationView.canShowCallout = true  // Permite mostrar un cuadro de información al tocar el pin
//        annotationView.markerTintColor = .red
//        annotationView.glyphTintColor = .black   // Cambia el color del pin (puedes probar otros colores
//        
//        let image = UIImage(systemName: viewModel.pizzeriaImage)
//        annotationView.glyphImage = image
        
        
         guard !(annotation is MKUserLocation) else { return nil }
         
         let annotationView = MKAnnotationView(annotation: annotation,
                                               reuseIdentifier: nil)
         let image = UIImage(systemName: viewModel.pizzeriaImage)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .cyan
        annotationView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        return annotationView
        
        
    }
        
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 8.0
        return renderer
    }
}



