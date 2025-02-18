//
//  ArtistScreenView.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 12/11/24.
//

import UIKit


protocol ArtistScreenViewProtocol: AnyObject {
    func showInformationArtist(_ artists: ArtistInfo)
    //func showInformation(_ information: String)
    //func showError(_ error: String)
}

class ArtistScreenView: UIViewController, ArtistScreenViewProtocol {
    
    lazy var nameArtistLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 19, weight: .black)
        label.textAlignment = .center
        return label
    } ()
    
    lazy var informationArtist: UITextView = {
        let textView = UITextView ()
        textView.font = .systemFont(ofSize: 15)
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.backgroundColor = .systemTeal
        return textView
    }()
    
    lazy var imageArtist: UIImageView = {
        let imageView = UIImageView ()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var informationStackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    lazy var informationTextFieldStackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    
    lazy var imageButtonStackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    
    var presenter: ArtistScreenDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
    }
    
    
    private func setMainStackView(wiht artist: ArtistInfo) {
        view.addSubview(mainStackView)
        
        // Stack para la imagen y el label
        imageArtist.image = UIImage(named: artist.imageArtistScreen)
        nameArtistLabel.text = artist.nameArtistScreen
        
        informationStackView.addArrangedSubview(imageArtist)
        informationStackView.addArrangedSubview(nameArtistLabel)
        
        
        NSLayoutConstraint.activate([
            imageArtist.bottomAnchor.constraint(equalTo: nameArtistLabel.topAnchor, constant: -10)
        ])
        
        // Stack para imagen-label y textfield
        informationTextFieldStackView.addArrangedSubview(informationStackView)
        
        informationArtist.text = artist.infoArtist
        informationTextFieldStackView.addArrangedSubview(informationArtist)
        
        // Se agrega el primer stack (informcion)
        mainStackView.addArrangedSubview(informationTextFieldStackView)
        
        let namesAlbums = artist.nameAlbum
        let namesImages = artist.imageAlbum
        let idAlbums = artist.idAlbum
        
        for id in idAlbums {
            let imageAlbums = namesAlbums[id]
            let idsButtonsAlbums = idAlbums[id]
            let titleButtonsAlbums = namesImages[id]
            let artistStackView = createArtistStackView(titleButtonsAlbums, idsButtonsAlbums, imageAlbums)
            imageButtonStackView.addArrangedSubview(artistStackView)
        }
        
        // Se agrega el segundo stack (albunes)
        mainStackView.addArrangedSubview(imageButtonStackView)
        
        
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    private func createArtistStackView(_ imageName: String, _ idButton: Int, _ titlebutton: String
    ) -> UIStackView {
        
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
        imageView.image = UIImage(named: imageName) // Usar el nombre de la imagen del artista en assets
            
        // Crear y configurar el botón del artista
        let button = UIButton()
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.background.backgroundColor = .black
        buttonConfig.baseForegroundColor = .white
        buttonConfig.buttonSize = .mini
        button.configuration = buttonConfig
        button.tag = idButton
        button.setTitle(titlebutton, for: .normal) // Nombre del artista
        button.titleLabel?.textAlignment = .center
        button.addAction(UIAction(handler: touchButtonAlbum(_:)), for: .touchUpInside)
            
        // Agregar imagen y botón al stack del artista
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(button)
        return stackView
    }
    
    
    func showInformationArtist(_ artist: ArtistInfo) {
        setMainStackView(wiht: artist)
        
    }
    
    private func touchButtonAlbum(_ action: UIAction) {
        if let button = action.sender as? UIButton {
            let tag = button.tag
            //print(tag)
            presenter?.getSongs(idButtonAlbum: tag)
        }
    }
    
    
}
