//
//  CarouselCell.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 02.01.2023.
//

import Foundation
import UIKit
import MBProgressHUD

class CarouselCell: UICollectionViewCell {
    static var identifier: String = "CarouselCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: UI Setup
    func setupViews(with comic: Comic) {
        print(comic)
        MBProgressHUD.hide(for: self, animated: true)
        setHidden(false)
        setupImageView(with: comic.img)
        titleLabel.text = comic.title
        descriptionLabel.text = comic.alt
    }
    
    private func setHidden(_ hidden: Bool) {
        self.imageView.isHidden = hidden
        self.titleLabel.isHidden = hidden
        self.descriptionLabel.isHidden = hidden
    }
    
    private func setupImageView(with imageURL: String) {
        imageView.downloaded(from: imageURL)
    }
    
    func setupLoadingState() {
        setHidden(true)
        MBProgressHUD.showAdded(to: self, animated: true)
    }
}

