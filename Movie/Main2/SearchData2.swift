//
//  SearchData2.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 16.08.22.
//

import Foundation


struct SearchData2 : Decodable {
    let Title: String?
    let Released: String?
    let Genre: String?
    let Actors: String?
    let BoxOffice: String?
    let Plot: String?
    let Poster: URL
    let Runtime: String?
    let imdbID: String?
    let imdbRating: String?
}

