//
//  ViewController.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 26.12.2022.
//

import UIKit

// this view controller is the one which will show the list of all comic books

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var currentIndexPath: IndexPath = [0, 0]
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        flowlayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowlayout
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionData), name: firstLoadNotificationName, object: nil)
    }
    
    @objc func reloadCollectionData() {
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
  
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
    }

    // Since we get the last comicbook first the next and previous functions are inverted

    @IBAction func next() {
        currentIndexPath.item -= 1
        self.collectionView.scrollToItem(at: currentIndexPath, at: .left, animated: true)
    }
    
    @IBAction func prev() {
        currentIndexPath.item += 1
        self.collectionView.scrollToItem(at: currentIndexPath, at: .left, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return Int.max
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCell else {
            return UICollectionViewCell()
        }
        // don't really like it but i'm on the clock over here :)
        cell.contentView.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.8823529412, blue: 0.8274509804, alpha: 1)
        cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        if indexPath.item < Coordinator.repo.comics.count {
            cell.setupViews(with: Coordinator.repo.comics[indexPath.item])
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
        let pageInt = Int(round(pageFloat))
        
        switch pageInt {
        case 0:
            collectionView.scrollToItem(at: [0, 3], at: .left, animated: false)
        case list.count - 1:
            collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
        default:
            break
        }
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            Coordinator.getComic(for: indexPath.item)
        }
    }
}

// MARK: Data Loading
extension ViewController {
    func loadStartupData() {
        loadData()
        
    }
    func loadData() {
        let service = DefaultNetworkService()
        let request = ComicRequest()
        service.request(request) { result in
            switch result {
            case .success(let comic):
                print(comic)
            case .failure(let error):
                print(error)
            }
        }
    }
}
