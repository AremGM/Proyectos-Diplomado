//
//  PizzeriaListTableViewController.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit

class PizzeriaListTableViewController: UITableViewController {

    private let viewModel = PizzeriaListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        self.title = "Pizzeria"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: viewModel.pizzeriaCellIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pizzeriaCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.pizzeriaCellIdentifier,
                                                 for: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        let pizzeria = viewModel.pizzeria(at: indexPath)
       
        let pizzeriaName: String
        if viewModel.isFavorite(pizzeria: pizzeria) {
            pizzeriaName = pizzeria.name + " ♥️"
        } else {
            pizzeriaName = pizzeria.name
        }
        
        cellConfiguration.text = pizzeriaName
        //cellConfiguration.secondaryText = pizzeria.address
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pizzeria = viewModel.pizzeria(at: indexPath)
        let pizzeriaDetailVC = PizzeriaDetailViewController(pizzeria: pizzeria)

        navigationController?.pushViewController(pizzeriaDetailVC,
                                                 animated: true)
    }
    
    // Función para la acción al deslizar a la derecha
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pizza = viewModel.pizzeria(at: indexPath)
        
        // Verificar si el Pokémon ya está en favoritos
        if viewModel.isFavorite(pizzeria: pizza) {
            // Si ya es favorito, solo mostrar la acción de eliminar
            let deleteFavoriteAction = UIContextualAction(style: .destructive, title: "Remove from favorites") { [weak self] _, _, completion in
                self?.viewModel.deletePizzaFromFavorites(at: indexPath)
                completion(true)
            }
            
            deleteFavoriteAction.backgroundColor = .gray
            deleteFavoriteAction.image = UIImage(systemName: "bolt.heart.fill")
            
            return UISwipeActionsConfiguration(actions: [deleteFavoriteAction])
        } else {
            // Si no es favorito, mostrar la acción de agregar a favoritos
            let favoriteAction = UIContextualAction(style: .normal, title: "Add to favorites") { [weak self] _, _, completion in
                self?.viewModel.addPizzeriaToFavorites(at: indexPath)
                completion(true)
            }
            
            favoriteAction.backgroundColor = .red
            favoriteAction.image = UIImage(systemName: "heart")
            
            return UISwipeActionsConfiguration(actions: [favoriteAction])
        }
    }

    

}

extension PizzeriaListTableViewController: PizzeriaListViewModelDelegate {
    func shouldReloadTableData() {
        tableView.reloadData()
    }
}
