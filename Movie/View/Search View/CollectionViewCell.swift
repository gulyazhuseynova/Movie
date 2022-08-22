//
//  CollectionViewCell.swift
//  Movie
//
//  Created by Gulyaz Huseynova on 14.08.22.
//

import UIKit

protocol MyCellDelegate {
    func cellWasPressed(id: String)
}



class CollectionViewCell: UICollectionViewCell {

    var delegate: MyCellDelegate?
    
    @IBOutlet weak var posterButton: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var id: UILabel!
    
    
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
    




