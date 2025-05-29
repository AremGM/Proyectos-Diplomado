//
//  MovieTableViewCell.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 14/04/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    // Identificador para la celda
    static let identifier = "MovieTableViewCell"

    // Imagen de la película
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Etiqueta para el título
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Etiqueta de rating
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Acomoda las estrellas
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    //Contiene las estrellas
    private var starImageViews: [UIImageView] = []

    // Inicializador para configurar la celda
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Agrega las vistas al contenido de la celda
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starStackView)
        contentView.addSubview(ratingLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configura las restricciones en la vista
    private func setupConstraints() {
        
        // Creaa las estrellas y agrega al starStackView
        for _ in 0..<5 {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star")
            imageView.tintColor = .systemYellow
            imageView.translatesAutoresizingMaskIntoConstraints = false
            starImageViews.append(imageView)
            starStackView.addArrangedSubview(imageView)
        }

        // Restricciones de diseño para la celda
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            movieImageView.widthAnchor.constraint(equalToConstant: 100), // Ancho fijo para la imagen.

            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            
            starStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            starStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            starStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -140),
            
            ratingLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            ratingLabel.topAnchor.constraint(equalTo: starStackView.bottomAnchor, constant: 5),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }

    // Configuracion la celda con los datos
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(String(format: "%.1f", movie.voteAverage))"
        updateRatingStars(with: movie.voteAverage)
        loadPosterImage(from: movie.posterPath)
    }

    // MARK: - Métodos auxiliares

    private func updateRatingStars(with voteAverage: Double) {
        let rating = voteAverage / 2 
        for (index, imageView) in starImageViews.enumerated() {
            let starValue = Double(index) + 1
            switch rating {
            case let r where r >= starValue:
                imageView.image = UIImage(systemName: "star.fill")
            case let r where r >= starValue - 0.5:
                imageView.image = UIImage(systemName: "star.leadinghalf.filled")
            default:
                imageView.image = UIImage(systemName: "star")
            }
        }
    }

    private func loadPosterImage(from posterPath: String?) {
        guard let path = posterPath,
              let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") else {
            movieImageView.image = UIImage(systemName: "film") // Imagen por defecto
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }

}
