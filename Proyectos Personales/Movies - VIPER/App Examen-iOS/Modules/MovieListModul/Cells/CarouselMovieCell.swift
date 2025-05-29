//
//  CarouselMovieCell.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import UIKit

class CarouselMovieCell: UICollectionViewCell {
    // Identificador para la celda
    static let identifier = "CarouselMovieCell"

    // Imagen del poster
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // Inicializador para configurar la celda
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    // Inicializador requerido pero no implementado, ya que no se usa en este caso.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView () {
        contentView.addSubview(imageView)
        // Configura las restricciones en la vista
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    // Configura la celda con los datos
    func configure(with movie: Movie) {
        // Verifica si la pelicula tiene un poster
        if let posterPath = movie.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            // Descarga la imagen
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    // Actualiza la interfaz de usuario en el hilo principal
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        } else {
            // Icono por defecto
            imageView.image = UIImage(systemName: "film")
        }
    }
}
