//
//  SaveVC.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 12.08.22.
//

import UIKit

class SaveVC: UIViewController{
    
    
    var movieManager2 = MovieManager2()
    var nameOfMovie = ""
    var savedList : [Movies2] = []
    @IBOutlet weak var saveCollection: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let arr = UserDefaults.standard.array(forKey: "MV") as? [String] {
            for i in arr { //call each movie's data
                movieManager2.fetchMovie(movieID: i)
            }
            print ("IDs in arr: ", arr)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager2.delegate = self
        saveCollection.dataSource = self
        
        saveCollection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.savedList = []
        self.saveCollection.reloadData()
    }
}

extension SaveVC: MovieManager2Delegate {
    
    func didUpdateMovie(movieManager: MovieManager2, movies: Movies2) {
        
        DispatchQueue.main.sync {
            
            savedList += [movies]
            self.saveCollection.reloadData()
        }
        
    }
}


extension SaveVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = savedList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.delegate = self
        
        cell.posterButton.sd_setImage(with: movie.posterTitle, for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
        cell.movieName.text = movie.movieTitle
        cell.id.text = movie.imdbID
        
        return cell
    }
}

extension SaveVC: MyCellDelegate {
    
    func cellWasPressed(id: String) {
        self.nameOfMovie = id
        print(id)
        self.performSegue(withIdentifier: "SaveToMovie", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveToMovie" {
            if let destination = segue.destination as? MovieVC {
                destination.idDidRecieved = nameOfMovie
            }
        }
    }
}
