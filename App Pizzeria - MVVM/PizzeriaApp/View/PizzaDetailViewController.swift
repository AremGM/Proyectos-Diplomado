//
//  PizzaDetailViewController.swift
//  PizzeriaApp
//
//  Created by Diplomado on 25/01/25.
//

import UIKit
import Lottie

class PizzaDetailViewController: UIViewController, UITableViewDataSource {
    
    private let viewModel: PizzaDetailViewModel
    
    var animationView: LottieAnimationView!
    var ingredientsTableView: UITableView!
    
    lazy var labelNamePizza: UILabel = {
        var labelPizza = UILabel()
        labelPizza.text = viewModel.pizzaName
        labelPizza.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelPizza.textAlignment = .center
        labelPizza.translatesAutoresizingMaskIntoConstraints = false
        return labelPizza
    }()
    
    init(pizza: PizzaData.Pizzas) {
        self.viewModel = PizzaDetailViewModel(pizza: pizza)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAnimation()
        setupIngredientsTableView()
        addLabelNamePizza()
    }
    

    func setupAnimation() {
        animationView = LottieAnimationView(name: "pizzaAnim")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        animationView.play()
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func addLabelNamePizza() {
        view.addSubview(labelNamePizza)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 10),
            labelNamePizza.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelNamePizza.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelNamePizza.topAnchor.constraint(equalTo: view.topAnchor, constant: 140)
            
        ])
    }

    func setupIngredientsTableView() {
        ingredientsTableView = UITableView()
        ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.pizzaCellDetail)
        
        view.addSubview(ingredientsTableView)
        
        NSLayoutConstraint.activate([
            ingredientsTableView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            ingredientsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ingredientsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pizzaIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.pizzaCellDetail, for: indexPath)
        
        let ingredient = viewModel.pizzaIngredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
