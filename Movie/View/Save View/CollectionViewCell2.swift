//
//  CollectionViewCell2.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 20.08.22.
//

import UIKit


protocol MyCellDelegate2 {
    func cellWasPressed(id: String)
}
    
    
class CollectionViewCell2: UICollectionViewCell {
    
    var delegate: MyCellDelegate2?

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var savedPoster: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let id = id.text {
                self.delegate?.cellWasPressed(id: id)
    
            }
        }
}
