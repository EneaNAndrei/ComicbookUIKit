//
//  SearchController.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 03.01.2023.
//

import Foundation
import UIKit
import MBProgressHUD

class SearchController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var comicNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // this isnt safe by any means.
        // i can make it safe.
        // not sure if this is the purpose of the exercise
        view.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.8823529412, blue: 0.8274509804, alpha: 1)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let comicNumber = comicNumber {
            Coordinator.getSearchComic(for: comicNumber) { comic, error in
                guard error == nil,
                      let comic = comic else {
                    return
                }
                OperationQueue.main.addOperation {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.setupViews(with: comic)
                    
                }
            }
        }
        
    }
    
    
    private func setupViews(with comic: Comic) {
        self.setupImageView(with: comic.img)
        self.titleLabel.text = comic.title
        self.descriptionLabel.text = comic.alt
    }
    private func setupImageView(with imageURL: String) {
        imageView.downloaded(from: imageURL)
    }
}
