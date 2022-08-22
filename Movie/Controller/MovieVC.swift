//
//  MovieVC.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 15.08.22.
//

import UIKit
import SDWebImage

class MovieVC: UIViewController {
    var idDidRecieved = ""
    var movieManager2 = MovieManager2()
    
    @IBOutlet weak var idNumber: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var boxOffice: UILabel!
    @IBOutlet weak var runningTime: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieManager2.delegate = self
        movieManager2.fetchMovie(movieID: idDidRecieved)
    }
    
    let defaults = UserDefaults.standard
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
 
        if let id = idNumber.text {
            if let arr = defaults.array(forKey: "MV"){
                var arrvalues = arr as! [String]
                
                if arrvalues.contains(id) {
                    arrvalues = arrvalues.filter{$0 != id} // when save button pressed, filter all list and delete the movie with the unique id
                    self.defaults.set(arrvalues, forKey:"MV")
                    self.defaults.synchronize()
                    self.saveButton.image = UIImage(systemName: "bookmark")
                }else{
                    arrvalues.append(id) // if list dont contain that element, append it
                    self.defaults.set(arrvalues, forKey:"MV")
                    self.defaults.synchronize()
                    self.saveButton.image = UIImage(systemName: "bookmark.fill")
                }
            }else{
                self.defaults.set([id], forKey:"MV")
            }
            
        }
        
        print(UserDefaults.standard.array(forKey: "MV") ?? [])
    }
    
}


extension MovieVC: MovieManager2Delegate {
    
    func didUpdateMovie(movieManager: MovieManager2, movies: Movies2) {
        
        DispatchQueue.main.sync {

            self.genre.text = movies.genre
            self.descriptionLabel.text = movies.plot
            self.actors.text = movies.actors
            self.rate.text = "\(movies.imdbRating)/10"
            self.boxOffice.text = movies.boxOffice
            self.runningTime.text = movies.runtime
            self.movieName.text = movies.movieTitle
            self.releaseDate.text = movies.released
            self.idNumber.text = movies.imdbID

            self.posterImage.sd_setImage(with: movies.posterTitle, placeholderImage: UIImage(named: "placeholder.png"))
            
            if (UserDefaults.standard.array(forKey: "MV") as? [String])?.contains(movies.imdbID) ?? false {
                self.saveButton.image = UIImage(systemName: "bookmark.fill")
            }else{
                self.saveButton.image = UIImage(systemName: "bookmark")
            }
            
            
        }
      
    }
}

