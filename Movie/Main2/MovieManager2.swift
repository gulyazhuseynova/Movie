//
//  MovieManager2.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 16.08.22.
//

import Foundation

import UIKit

protocol MovieManager2Delegate {
    func didUpdateMovie (movieManager: MovieManager2 , movies: Movies2)
}


struct MovieManager2{
    
    var delegate: MovieManager2Delegate?
    
    let yourAPIKey = "46bbdba5"
    
    
    func fetchMovie (movieID: String) {
        
        //Replace spaces in movie name with + sign (for example: Iron Man -> Iron+Man )
        let movieID = movieID.replacingOccurrences(of: " ", with: "+")
        
        //1.Create a URL
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(movieID)&apikey=\(yourAPIKey)") else{return}
        print(url)
        //2.Create a URLSession and Give the session a task
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                
                if let movies = self.parseJSON(safeData){
                    self.delegate?.didUpdateMovie(movieManager: self, movies: movies)
                }
                
            }else{
                print("error")
            }
        }
        //3.start the task
        task.resume()
        
    }
    func parseJSON (_ movieData: Data) -> Movies2? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(SearchData2.self, from: movieData)
            
            let movieTitle = decodedData.Title ?? "N/A"
            let released = decodedData.Released ?? "N/A"
            let genre = decodedData.Genre ?? "N/A"
            let actors = decodedData.Actors ?? "N/A"
            let imdbRating = decodedData.imdbRating ?? "N/A"
            let boxOffice = decodedData.BoxOffice ?? "N/A"
            let plot = decodedData.Plot ?? "N/A"
            let posterTitle = decodedData.Poster
            let runtime = decodedData.Runtime ?? "N/A"
            let imdbID = decodedData.imdbID ?? "N/A"
            
            let movies = Movies2(movieTitle: movieTitle, released: released, genre: genre, actors: actors, imdbRating: imdbRating, boxOffice: boxOffice, plot: plot, posterTitle: posterTitle, runtime: runtime, imdbID: imdbID)
            
            return movies
            
        }catch{
            print(error)
            return nil
        }
    }
}
