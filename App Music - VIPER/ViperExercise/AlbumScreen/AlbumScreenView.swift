//
//  AlbumScreenView.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 13/11/24.
//

import UIKit

protocol AlbumScreenViewProtocol: AnyObject {
    func showInformationSongs(_ information: AlbumInfo, _ tagAlbum: Int)
}

class AlbumScreenView: UIViewController, AlbumScreenViewProtocol{
    
    lazy var imageAlbumSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var labelNameAlbumSelected: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        // Configura el borde del label
        label.layer.borderColor = UIColor.black.cgColor // Color del borde
        label.layer.borderWidth = 2.0                   // Ancho del borde
        label.layer.cornerRadius = 10                    // Radio de las esquinas
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var informationAlbum: UITextView = {
        let textView = UITextView ()
        textView.font = .systemFont(ofSize: 15)
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.backgroundColor = .systemTeal
        return textView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var albumSelectedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var infoAlbumStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var songsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    var presenter: AlbumScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
    }
    
    
    
    private func setMainStackView(_ information: AlbumInfo, _ tagAlbum: Int) {
        view.addSubview(mainStackView)
        
        imageAlbumSelected.image = UIImage(named: information.imageSelecAlbum[tagAlbum])
        labelNameAlbumSelected.text = information.nameSelecAlbum[tagAlbum]
        informationAlbum.text = information.infoSelecAlbum[tagAlbum]
        
        albumSelectedStackView.addArrangedSubview(imageAlbumSelected)
        albumSelectedStackView.addArrangedSubview(labelNameAlbumSelected)
        
        infoAlbumStackView.addArrangedSubview(albumSelectedStackView)
        infoAlbumStackView.addArrangedSubview(informationAlbum)
        
        mainStackView.addArrangedSubview(infoAlbumStackView)
        
        
        let nameSongs = information.songsNames[tagAlbum]
        let idSong = information.idSongs
        let timeSong = information.songsTimes[tagAlbum]
        
        for id in idSong {
            let imagesAlbumSong = information.imageSelecAlbum[tagAlbum]
            let idsButtonsSongs = idSong[id]
            let titleButtonsSongs = nameSongs[id]
            let timelabel = timeSong[id]
            let songsStack = createSongsStackView(titleButtonsSongs, idsButtonsSongs, imagesAlbumSong, timelabel)
            songsStackView.addArrangedSubview(songsStack)
        }
        
        mainStackView.addArrangedSubview(songsStackView)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    private func createSongsStackView(_ titleButton: String, _ idSong: Int, _ imageAlbumSong: String, _ timeSong: String) -> UIStackView {
        
        // Crea el stack
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
            
        // Crear y configurar la imagen de la cancion
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageAlbumSong) // Usar el nombre de la imagen del artista en assets
            
        // Crear y configurar el botón de la cancion
        let button = UIButton()
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.background.backgroundColor = .black
        buttonConfig.baseForegroundColor = .white
        buttonConfig.buttonSize = .mini
        button.configuration = buttonConfig
        button.tag = idSong
        button.setTitle(titleButton, for: .normal) // Nombre del artista
        button.titleLabel?.textAlignment = .center // Centra el texto en ambas líneas
        button.addAction(UIAction(handler: touchSongAlbum(_:)), for: .touchUpInside)
        
        // Crea y configura el label de la concion
        let label = UILabel()
        label.text = timeSong
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
            
        // Agregar imagen y botón al stack del artista
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
    func showInformationSongs(_ information: AlbumInfo, _ tagAlbum: Int) {
        setMainStackView(information, tagAlbum)
    }
    
    
    private func touchSongAlbum (_ action: UIAction) {
        if let button = action.sender as? UIButton {
            let tag = button.tag
            //print("Hola")
            presenter?.getToScreenSong(tagSong: tag)
        }
    }
    
}
