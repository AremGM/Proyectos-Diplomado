//
//  FavoritePizzasTableViewController.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit

class FavoritePizzasTableViewController: UITableViewController {

    private let viewModel = FavoritePizzaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: viewModel.cellIdentifier)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let authenticationViewController = AuthenticationViewController()
        present(authenticationViewController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateFavoritePizzaTable()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModel.numberOfRows
        }else {
            return viewModel.numberOfRowsPizzeria
        }
        
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier,
                                                 for: indexPath)
        
        if indexPath.section == 0 {
            let pizza = viewModel.pizza(at: indexPath)
            
            var configuration = cell.defaultContentConfiguration()
            configuration.text = pizza.name
            cell.contentConfiguration = configuration
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let pizzeria = viewModel.pizzeria(at: indexPath)
            
            var configuration = cell.defaultContentConfiguration()
            configuration.text = pizzeria.name
            cell.contentConfiguration = configuration
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pizzas"
        } else {
            return "Pizzeria"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let pizza = viewModel.pizza(at: indexPath)
            let pizzaDetailViewController = PizzaDetailViewController(pizza: pizza)
            navigationController?.pushViewController(pizzaDetailViewController, animated: true)
        } else {
            let pizzeria = viewModel.pizzeria(at: indexPath)
            let pizzeriaDetailViewController = PizzeriaDetailViewController(pizzeria: pizzeria)
            navigationController?.pushViewController(pizzeriaDetailViewController, animated: true)
        }
    }
    
    

}
