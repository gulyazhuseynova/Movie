//
//  ViewController.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 11.08.22.
//

import UIKit
import SDWebImage

class SearchVC: UIViewController {
    var idOfMovie = ""
    var movieManager = MovieManager()

    var movie1: [Movies] = []
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        movieManager.delegate = self
        collectionView.dataSource = self
        //collectionView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
      
    }
}


extension SearchVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTextField.text = ""
        searchTextField.endEditing(true)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTextField.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchTextField.text != "" {
            let movieTyped = searchTextField.text
            movieManager.fetchMovie(movieName: "s=\(movieTyped!)")
        }
        
    }
    
}

extension SearchVC: MovieManagerDelegate {

    func didUpdateMovie(movieManager: MovieManager, movies: [Movies]) {
        DispatchQueue.main.sync {
            self.movie1 = movies
            self.collectionView.reloadData()
        }
    }
}
    

extension SearchVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movie1[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.delegate = self
    
        cell.posterButton.sd_setImage(with: movie.posterSearch, for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
        cell.movieName.text = movie.movieSearch
        cell.id.text = movie.imdbID
        return cell
    }
    
    
}

extension SearchVC: MyCellDelegate {
   
    func cellWasPressed(id: String) {
        self.idOfMovie = id
        self.performSegue(withIdentifier: "searchToMovie", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToMovie" {
            if let destination = segue.destination as? MovieVC {
                destination.idDidRecieved = idOfMovie
            }
        }
    }
    
}
    

