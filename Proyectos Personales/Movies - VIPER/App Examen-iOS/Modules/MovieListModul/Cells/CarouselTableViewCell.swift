//
//  CarouselTableViewCell.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.

import UIKit

class CarouselTableViewCell: UITableViewCell {
    // Identificador de la celda
    static let identifier = "CarouselTableViewCell"

    // Arreglo que contiene las peliculas destacadas para mostrar en el carrusel
    private var featuredMovies: [Movie] = []

    // UICollectionView para mostrar las peliculas en un carrusel horizontal
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 370, height: 220)
        layout.minimumLineSpacing = 12

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()

    // Inicializador para configurar la celda
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Configuracion de la coleccion
    private func setupCollectionView() {
        collectionView.register(CarouselMovieCell.self, forCellWithReuseIdentifier: CarouselMovieCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // Configuracion de las restricciones en la vista
    private func setupConstraints() {
        // Agrega la coleccion
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    // Configura la celda con un arreglo de peliculas
    func configure(with movies: [Movie]) {
        self.featuredMovies = movies
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource y UITCollectionDelegate
extension CarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredMovies.count // Retorna el número de películas destacadas.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselMovieCell.identifier, for: indexPath) as? CarouselMovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: featuredMovies[indexPath.item]) // Configura la celda con la película correspondiente.
        return cell
    }
}
