//
//  MovieDetailViewController.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    // Método para mostrar los detalles de la pelicula
    func showMovieDetails(_ movie: MovieDetail)
    // Método para mostrar un error
    func showError(_ error: Error)
}

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    // Para el webView
    var movieHome: String?
    // Referencia al presenter
    var presenter: MovieDetailPresenterProtocol?

    // Imagen de la pelicula
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Etiqueta para el titulo
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Etiqueta para el la informacion
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 7
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

    //Acomoda las estrellas
    private var starImageViews: [UIImageView] = []
    
    // Etiqueta para la descripcion
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // Etiqueta para el titulo Synopsis
    private let synopsisLabel: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Botón para el WebView
    private let moreDetailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See Online", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(didTapMoreDetails), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true // Default hidden for compatibility with iOS 11
        return button
    }()

    //Stack principal
    private let generalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func createVerticalStackView(title: String, value: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let titleinfo = UILabel()
        titleinfo.font = .systemFont(ofSize: 16, weight: .bold)
        titleinfo.textColor = .secondaryLabel
        titleinfo.numberOfLines = 3
        titleinfo.text = title
        titleinfo.translatesAutoresizingMaskIntoConstraints = false

        let info = UILabel()
        info.font = .systemFont(ofSize: 16, weight: .semibold)
        info.textColor = .secondaryLabel
        info.numberOfLines = 3
        info.text = value
        info.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(titleinfo)
        stackView.addArrangedSubview(info)

        return stackView
    }


    //Accion del boton
    @objc private func didTapMoreDetails() {
        guard let homePage = movieHome, let url = URL(string: homePage) else { return }
        presenter?.router?.navigateToWebView(from: self, with: url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        
        setupUI()
        presenter?.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }

    

    private func setupUI() {
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(starStackView)
        // Crear las estrellas y agregar al starStackView
        for _ in 0..<5 {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star")
            imageView.tintColor = .systemYellow
            imageView.translatesAutoresizingMaskIntoConstraints = false
            starImageViews.append(imageView)
            starStackView.addArrangedSubview(imageView)
        }
        
        infoStackView.addArrangedSubview(infoLabel)

        detailStackView.addArrangedSubview(movieImageView)
        detailStackView.addArrangedSubview(infoStackView)
        
        generalStackView.addArrangedSubview(detailStackView)
        generalStackView.addArrangedSubview(horizontalStackView)
        generalStackView.addArrangedSubview(synopsisLabel)
        generalStackView.addArrangedSubview(descriptionLabel)
        generalStackView.addArrangedSubview(moreDetailsButton)

        view.addSubview(generalStackView)

        // Configuracion de las restricciones para el generalStackView
        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            generalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            generalStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            movieImageView.widthAnchor.constraint(equalToConstant: 150),
            movieImageView.heightAnchor.constraint(equalToConstant: 225),

            moreDetailsButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }

    //Configuracion para mostrar la informacion en la vista
    func showMovieDetails(_ movie: MovieDetail) {
        DispatchQueue.main.async {
            self.updateTextualInfo(with: movie)
            self.updateRatingStars(with: movie.voteAverage)
            self.updateMoreDetailsSection(with: movie)
            self.loadPosterImage(from: movie.posterPath)
        }
    }

    // MARK: - Métodos auxiliares

    private func updateTextualInfo(with movie: MovieDetail) {
        titleLabel.text = movie.title
        infoLabel.text = """
        Rating: \(String(format: "%.1f", movie.voteAverage))
        \(movie.genreNames)
        \(movie.runtime.map { "\($0 / 60)h \($0 % 60)min" } ?? "N/A")
        \(movie.releaseDate.split(separator: "-").first ?? "N/A")
        """
        descriptionLabel.text = movie.overview
        movieHome = movie.homepage
        moreDetailsButton.isHidden = !(movieHome?.hasPrefix("https") ?? false)
    }

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

    private func updateMoreDetailsSection(with movie: MovieDetail) {
        let details = zip(
            ["Original Language", "Languages", "Votes"],
            [movie.originalLanguage, movie.languajes, String(movie.voteCount)]
        )

        details.forEach { title, value in
            let stack = createVerticalStackView(title: title, value: value)
            horizontalStackView.addArrangedSubview(stack)
        }
    }

    private func loadPosterImage(from posterPath: String?) {
        guard let path = posterPath,
              let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") else {
            movieImageView.image = UIImage(systemName: "photo")
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


    //Mostrar error
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
