//
//  FavoritesViewController.swift
//  proyectoFinalGitHub
//
//  Created by Emiliano Gil  on 13/01/25.
//

import UIKit




class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTable: UITableView!
    
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        
        favoritesTable.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        udateTable()
    }
    
    
    
    func udateTable() {
        if favorites.isEmpty {
            print("Empty")
        } else {
            favoritesTable.reloadData()
        }
        
    }

   

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(favorites.count)
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "favoriteCell")
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.login
        if let imageURL = URL(string: favorite.avatar_url) {
            URLSession.shared.dataTask(with: imageURL) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                        cell.setNeedsLayout()
                    }
                }
            }.resume()
        }
        return cell
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func didAddToFavorites(_ favorite: Follower) {
        if !favorites.contains(where: { $0.login == favorite.login }) {
            favorites.append(favorite)
            print(favorites)
        }
        
        
        //favoritesTable.reloadData()
    }
}
