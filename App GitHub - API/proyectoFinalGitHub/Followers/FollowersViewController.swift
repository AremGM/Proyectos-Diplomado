//
//  FollowersViewController.swift
//  proyectoFinalGitHub
//
//  Created by Diplomado on 11/01/25.
//

//TheMannSan

import UIKit

protocol FavoritesDelegate: AnyObject {
    func didAddToFavorites(_ favorite: Follower)
}

class FollowersViewController: UIViewController {

    var followers: [User] = []
    weak var favoritesDelegate: FavoritesDelegate?
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var userFollow: String!
    var userAvatarURL: String! // URL del avatar del usuario buscado
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.reloadData()
        labelUserName.text = userFollow
        
        
        
        // Asignar el delegado desde el Tab Bar Controller
        if let tabBarController = self.tabBarController,
           let viewControllers = tabBarController.viewControllers {
            for vc in viewControllers {
                if let favoritesVC = vc as? FavoritesViewController {
                    self.favoritesDelegate = favoritesVC
                }
            }
        }
        
    }

    
    @IBAction func addFav(_ sender: Any) {
        
        
        fetchUserDetails(for: userFollow) { followers, error in
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                    
                } else if let followers = followers {
                    self.favoritesDelegate?.didAddToFavorites(followers)
                    
                }
            }
        }
        
        
        
            
            
            //        guard let userFollow = userFollow, let userAvatarURL = userAvatarURL else { return }
            //
            //        let favorite = User(login: userFollow, avatar_url: userAvatarURL)
            //        favoritesDelegate?.didAddToFavorites(favorite)
            //
            //        let alert = UIAlertController(title: "Added to Favorites", message: "\(userFollow) has been added to your favorites!", preferredStyle: .alert)
            //        alert.addAction(UIAlertAction(title: "OK", style: .default))
            //        present(alert, animated: true)
        
    }
    
    
    func fetchUserDetails(for username: String, completion: @escaping (Follower?, Error?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil, error)
                return
            }
            do {
                let user = try JSONDecoder().decode(Follower.self, from: data)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    

}

extension FollowersViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FollowersCollectionViewCell
        
        let user = followers[indexPath.row]
        //print(user)
        cell.label.text = user.login
        cell.label.font = UIFont.systemFont(ofSize: 12)
        
        if let imageURL = URL(string: user.avatar_url) {
            URLSession.shared.dataTask(with: imageURL) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.image.image = image
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 200
    }

    
}

extension FollowersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 110, height: 150)
    }
}
