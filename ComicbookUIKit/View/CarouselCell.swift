//
//  CarouselCell.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 02.01.2023.
//

import Foundation
import UIKit
import TinyConstraints

class CarouselCell: UICollectionViewCell {
    static var identifier: String = "CarouselCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: UI Setup
    func setupViews(with comic: Comic) {
        
        setupImageView(with: comic.img)
        titleLabel.text = comic.title
        descriptionLabel.text = comic.alt
    }
    
    private func setupImageView(with imageURL: String) {
        imageView.downloaded(from: imageURL)
    }
}

