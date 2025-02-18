//
//  HomeScreenView.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 10/11/24.
//
import UIKit

protocol ArtistDetailViewProtocol: AnyObject {
    func showArtistDescription(_ artists: [Artist])
    //func showInformation(_ information: String)
    //func showError(_ error: String)
}

class HomeScreenView: UIViewController, ArtistDetailViewProtocol {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Artistas"
        label.font = .systemFont(ofSize: 23, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // Para las imagenes-botones
    lazy var secundaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    var presenter: ArtistDetailPresenterProtocol? // Referencia al presenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        presenter?.viewDidLoad() // Notificar al Presenter cuando la vista se carga
    }
    
    
    private func setMainStackView(with artists: [Artist]) {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(headerLabel)
        
        // Crear un stack para cada artista
        for artist in artists {
            let artistStackView = createArtistStackView(artist)
            secundaryStackView.addArrangedSubview(artistStackView)
        }
        // Stack que contiene los stack de las imagenes-botones
        mainStackView.addArrangedSubview(secundaryStackView)
        
        // Establecer restricciones del stack principal
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createArtistStackView(_ artist: Artist) -> UIStackView {
        
        // Crea el stack
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
            
        
        // Crear y configurar la imagen del artista
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: artist.imageArtist) // Usar el nombre de la imagen del artista en assets
        
            
        // Crear y configurar el botón del artista
        let button = UIButton()
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.background.backgroundColor = .black
        buttonConfig.baseForegroundColor = .white
        buttonConfig.buttonSize = .mini
        button.configuration = buttonConfig
        button.tag = artist.idArtist
        button.setTitle(artist.nameArtist, for: .normal) // Nombre del artista
        button.addAction(UIAction(handler: touchButtonArtist(_:)), for: .touchUpInside)
            
        // Agregar imagen y botón al stack del artista
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(button)
        return stackView
    }
    
    func showArtistDescription(_ artists: [Artist]) {
        //print("Si llego aqui")
        setMainStackView(with: artists)
    }
    
    private func touchButtonArtist(_ action: UIAction) {
        //print("Se apreto un boton")
        if let button = action.sender as? UIButton {
            let tag = button.tag
            //print(tag)
            presenter?.getAlbums(tagArtist: tag)
        }
    }
    
//    func showInformation(_ information: String) {
//        print("Se apreto el boton: \(information)")
//    }
    
}
