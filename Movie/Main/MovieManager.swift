//
//  InstagramManager.swift
//  Instagram
//
//  Created by Gulyaz Huseynova on 06.08.22.
//


import UIKit

protocol MovieManagerDelegate {
    func didUpdateMovie ( movieManager: MovieManager , movies: [Movies])
    
}


struct MovieManager{
    
    var delegate: MovieManagerDelegate?
    
    let yourAPIKey = "46bbdba5"
    
    func fetchMovie (movieName: String) {
        let movieName = movieName.replacingOccurrences(of: " ", with: "+")
        
        //1.Create a URL
        guard let url = URL(string: "https://www.omdbapi.com/?\(movieName)&apikey=\(yourAPIKey)") else{return}
        //2.Create a URLSession
        let session = URLSession(configuration: .default)
        //3.Give the session a task
        let task = session.dataTask(with: url) { data, response, error in
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
        //4.start the task
        task.resume()
    
    
}
func parseJSON (_ movieData: Data) -> [Movies]? {
    let decoder = JSONDecoder()
    
    do {
        var movies : [Movies] = []
        let decodedData = try decoder.decode(SearchData.self, from: movieData)
        let movieCount = decodedData.Search.count - 1
        
        for i in 0...movieCount{
            //Search (s)
            let movieSearch = decodedData.Search[i].Title
            let posterURL = decodedData.Search[i].Poster
            let imdbID = decodedData.Search[i].imdbID
            
            let movie = Movies(movieSearch: movieSearch, posterSearch: posterURL, imdbID: imdbID)
            movies.append(movie)
        }
        return movies
        
    }catch{
        print(error)
        return nil
    }
}


}


