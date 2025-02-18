//
//  NavigationTabViewController.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit

class NavigationTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        // Do any additional setup after loading the view.
    }
    

    private func setupViewControllers() {
        
        let pizzaListTVC = PizzaListTableViewController(style: .plain)
        pizzaListTVC.tabBarItem.title = "Pizza"
        pizzaListTVC.tabBarItem.image = UIImage(systemName: "fork.knife.circle.fill")
        
        let pizzaListTVCNavigation = UINavigationController(rootViewController: pizzaListTVC)
        
        let pizzeriaListTVC = PizzeriaListTableViewController(style: .plain)
        pizzeriaListTVC.tabBarItem.title = "Pizzeria"
        pizzeriaListTVC.tabBarItem.image = UIImage(systemName: "location.circle.fill")
        
        let pizzeriaListTVCNavigation = UINavigationController(rootViewController: pizzeriaListTVC)
        
        let favoriteListTVC = FavoritePizzasTableViewController(style: .plain)
        favoriteListTVC.tabBarItem.title = "Favorite"
        favoriteListTVC.tabBarItem.image = UIImage(systemName: "star.fill")
        
        let favoriteListTVCNavigation = UINavigationController(rootViewController: favoriteListTVC)
        
        let ingredientesListTVC = IngredientesViewController()
        ingredientesListTVC.tabBarItem.title = "Ingredientes"
        ingredientesListTVC.tabBarItem.image = UIImage(systemName: "carrot.fill")
        
        let ingredientesTVCNavigation = UINavigationController(rootViewController: ingredientesListTVC)
        
        
        
        viewControllers = [pizzaListTVCNavigation, pizzeriaListTVCNavigation, favoriteListTVCNavigation, ingredientesTVCNavigation]
    }
    
    

}
