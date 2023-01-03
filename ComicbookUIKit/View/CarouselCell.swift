//
//  CarouselCell.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 02.01.2023.
//

import Foundation
import UIKit
import MBProgressHUD

// named it like so in case someone would do a find out how the explanation is shown
protocol ExplanationDelegate: AnyObject {
    func showWebView(with num: Int)
}

class CarouselCell: UICollectionViewCell {
    static var identifier: String = "CarouselCell"
    
    weak var delegate: ExplanationDelegate?
    
    var comic: Comic?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: UI Setup
    func setupViews(with comic: Comic) {
        MBProgressHUD.hide(for: self, animated: true)
        self.comic = comic
        setHidden(false)
        contentView.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.8823529412, blue: 0.8274509804, alpha: 1)
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
    
    @IBAction func showExplanation() {
        guard let comic = comic else {
            return
        }
        delegate?.showWebView(with: comic.num)
    }
}

