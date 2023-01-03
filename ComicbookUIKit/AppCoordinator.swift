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
    
    //I know the naming here seems off but in Networking i prefer that the exposed methods start with the httpmethod type so that we can immediately know it's a get request for instance
    func getSearchComic(for comicNum: Int, completion: @escaping ((Comic?, Error?) -> Void) ) {
        let request = ComicRequest(comicbookId: "/\(comicNum)")
        networkService.request(request) { result  in
            switch result {
            case .success(let comic):
                completion(comic, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getComic(for indexPath: Int) {
        print("*********has entered getComic for \(indexPath)")
        // it's possible the same request can come in
        
        let comicNum = maxComicId - (1 + indexPath)
        guard needsComic(comicNum) else {
            return
        }
        let request = ComicRequest(comicbookId: "/\(comicNum)")
        networkService.request(request) { result in
            switch result {
            case .success(let comic):
                self.repo.comics.append(comic)
                self.repo.comics.sorted(by: {$0.num > $1.num})
                // ideally in a perfect world(where we use combine) this would then notify the view to reload itself and get out of the loading state but right now not sending the notification for reloaddata)
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
    
    private func needsComic(_ num: Int) -> Bool {
        return !repo.comics.contains(where: { $0.num == num })
    }
}
