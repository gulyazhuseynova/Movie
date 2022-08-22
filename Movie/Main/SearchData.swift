//
//  SearchData.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 14.08.22.
//


import UIKit

struct SearchData: Decodable {
    let Search : [Search]
}


struct Search: Decodable {
    let Title: String
    let Poster: URL
    let imdbID: String
}

