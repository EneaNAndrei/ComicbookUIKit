//
//  AppCoordinator.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 02.01.2023.
//

import Foundation

let Coordinator = AppCoordinator.shared

class AppCoordinator {
    static let shared = AppCoordinator()
    // this is the one we default to when opening the application
    var maxComicId: Int = 0
    
    let networkService: NetworkService = DefaultNetworkService()
    let repo = ComicRepository()
    
    private init() {
        
    }
    
    func getComic(for indexPath: Int) {
        let comicNum = maxComicId - (1 + indexPath)
        let request = ComicRequest(comicbookId: "/\(comicNum)")
        networkService.request(request) { result in
            switch result {
            case .success(let comic):
                self.repo.comics.append(comic)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    func getFirstComic() {
        networkService.request(ComicRequest()) { result in
            switch result {
            case .success(let comic):
                self.repo.comics.append(comic)
                self.maxComicId = comic.num
                // i know it's ugly but i only have so much time for this and i didn't go the combine route
                NotificationCenter.default.post(Notification(name: firstLoadNotificationName))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
