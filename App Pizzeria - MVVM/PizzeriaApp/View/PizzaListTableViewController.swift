//
//  PizzaListTableViewController.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit

class PizzaListTableViewController: UITableViewController {

    private let viewModel = PizzaListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        self.title = "Pizzas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: viewModel.pizzaCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updatePizzaListTable()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int { viewModel.numerofSection }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModel.pizzaCount
        } else {
            return viewModel.numberOfRowsNewPizza
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.pizzaCellIdentifier,
                                                 for: indexPath)
        if indexPath.section == 0 {
            var cellConfiguration = cell.defaultContentConfiguration()
            let pizza = viewModel.pizza(at: indexPath)
           
            let pizzaName: String
            if viewModel.isFavorite(pizza: pizza) {
                pizzaName = pizza.name + " ♥️"
            } else {
                pizzaName = pizza.name
            }
            cellConfiguration.text = pizzaName
            cell.contentConfiguration = cellConfiguration
            
            return cell
        } else {
            var cellConfiguration = cell.defaultContentConfiguration()
            let newPizza = viewModel.newPizza(at: indexPath)
            
            let newPizzaName: String
            if viewModel.isFavorite(pizza: newPizza) {
                newPizzaName = newPizza.name + " ♥️"
            } else {
                newPizzaName = newPizza.name
            }
            cellConfiguration.text = newPizzaName
            cell.contentConfiguration = cellConfiguration
            
            return cell
        }
        
    }
    //Funcion que se ejecuta al seleecionar una celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Funcion que deselecciona la celda
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            //Se obtiene el pokemon seleccionado
            let pizza = viewModel.pizza(at: indexPath)
            //Se pasa a la siguiente pantalla, con la variable del inicializador de esa clase (clase Vista de Detalles)
            let pizzaDetailViewController = PizzaDetailViewController(pizza: pizza)
            navigationController?.pushViewController(pizzaDetailViewController, animated: true)
        } else {
            //Se obtiene el pokemon seleccionado
            let pizza = viewModel.newPizza(at: indexPath)
            //Se pasa a la siguiente pantalla, con la variable del inicializador de esa clase (clase Vista de Detalles)
            let pizzaDetailViewController = PizzaDetailViewController(pizza: pizza)
            navigationController?.pushViewController(pizzaDetailViewController, animated: true)
        }
        
        
        
        //present(pizzaDetailViewController, animated: true)
        
        
    }
    
    // Función para la acción al deslizar a la derecha
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section == 0 {
            let pizza = viewModel.pizza(at: indexPath)
            // Verificar si el Pokémon ya está en favoritos
            if viewModel.isFavorite(pizza: pizza) {
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
                    self?.viewModel.addPizzaToFavorites(at: indexPath)
                    completion(true)
                }
                
                favoriteAction.backgroundColor = .red
                favoriteAction.image = UIImage(systemName: "heart")
                
                return UISwipeActionsConfiguration(actions: [favoriteAction])
            }
            
        } else {
            let pizza = viewModel.newPizza(at: indexPath)
            // Verificar si el pizza ya está en favoritos
            if viewModel.isFavorite(pizza: pizza) {
                // Si ya es favorito, solo mostrar la acción de eliminar
                let deleteFavoriteAction = UIContextualAction(style: .destructive, title: "Remove from favorites") { [weak self] _, _, completion in
                    self?.viewModel.deleteNewPizzaFromFavorites(at: indexPath)
                    completion(true)
                }
                
                deleteFavoriteAction.backgroundColor = .gray
                deleteFavoriteAction.image = UIImage(systemName: "bolt.heart.fill")
                
                return UISwipeActionsConfiguration(actions: [deleteFavoriteAction])
            } else {
                // Si no es favorito, mostrar la acción de agregar a favoritos
                let favoriteAction = UIContextualAction(style: .normal, title: "Add to favorites") { [weak self] _, _, completion in
                    self?.viewModel.addNewPizzaToFavorites(at: indexPath)
                    completion(true)
                }
                
                favoriteAction.backgroundColor = .red
                favoriteAction.image = UIImage(systemName: "heart")
                
                return UISwipeActionsConfiguration(actions: [favoriteAction])
            }
        }
        
        
        
    }
   
}

extension PizzaListTableViewController: PizzaListViewModelDelegate {
    func shouldReloadTableData() {
        tableView.reloadData()
    }
}
