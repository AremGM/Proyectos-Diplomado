//
//  MovieListViewController.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 14/04/25.
//

import UIKit

protocol MovieListViewProtocol: AnyObject {
    // Método para mostrar las peliculas en la vista
    func showMovies(_ movies: [Movie])
    // Método para mostrar un error
    func showError(_ error: Error)
}

class MovieListViewController: UIViewController, MovieListViewProtocol, TabsTableViewCellDelegate {
    
    // Referencia al presenter
    var presenter: MovieListPresenterProtocol?
    
    // Tabla para mostrar la lista de peliculas
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Registro las celdas personalizadas para las pelculas
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.register(TabsTableViewCell.self, forCellReuseIdentifier: TabsTableViewCell.identifier)
        tableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: CarouselTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    // Arreglo que contiene las peliculas a mostrar en la tabla
    private var movies: [Movie] = []
    
    // MARK: - Métodos principales

    override func viewDidLoad() {
        super.viewDidLoad()
        // Notifica al presenter que la vista se cargo
        presenter?.viewDidLoad(category: "popular")
        // Configura la interfaz de usuario
        setupUI()
        

        navigationController?.navigationBar.tintColor = .systemBlue
        let backImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
    }
    
    private func setupUI() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Restricciones de diseño para la tabla
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Métodos de MovieListViewProtocol

    func showMovies(_ movies: [Movie]) {
        // Actualiza la lista de peliculas y recarga la tabla
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(_ error: Error) {
        // Muestra un mensaje de error
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - TabsTableViewCellDelegate
    func didSelectTab(category: String) {
        // Notifica al presenter que se selecciono una nueva categoria
        presenter?.viewDidLoad(category: category)
    }
}

// MARK: - UITableViewDataSource y UITableViewDelegate

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 2 ? movies.count : 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        [50, 220, 160][indexPath.section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TabsTableViewCell.identifier, for: indexPath) as! TabsTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTableViewCell.identifier, for: indexPath) as! CarouselTableViewCell
            cell.configure(with: Array(movies.shuffled().prefix(3)))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
            cell.configure(with: movies[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2 else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.router?.navigateToMovieDetail(from: self, with: movies[indexPath.row].id)
    }
}





