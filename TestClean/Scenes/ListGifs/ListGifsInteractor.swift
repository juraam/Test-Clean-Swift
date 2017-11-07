//
//  ListGifsInteractor.swift
//  TestClean
//
//  Created by Jura Moshkov on 05/11/2017.
//  Copyright © 2017 Jura Moshkov. All rights reserved.
//

import UIKit
import Alamofire

protocol ListGifsBusinessLogic {
    func fetchDatas(request: ListGifs.FetchDatas.Request)
    func fetchGif(url: String, callback: @escaping ((Data?)->Void))
    func fetchTrends(request: ListGifs.FetchDatas.Request)
}

protocol ListGifsDataStore {
    var gifs: [GifData]? { get }
}

class ListGifsInteractor: ListGifsBusinessLogic, ListGifsDataStore {
    var gifs: [GifData]?
    var presenter: ListGifsPresentationLogic?
    
    
    func fetchTrends(request: ListGifs.FetchDatas.Request) {
        self.presenter?.presentFetchedGifs(response: ListGifs.FetchDatas.Response(datas: GifService.sharedService.cachedGifTrends()))
        GifService.sharedService.fetchGifTrends(count: request.count, offset: request.offset) {
            gifs in
            self.presenter?.presentFetchedGifs(response: ListGifs.FetchDatas.Response(datas: gifs))
        }
    }
    
    func fetchDatas(request: ListGifs.FetchDatas.Request) {
        GifService.sharedService.fetchGifs(query: request.query!, count: request.count, offset: request.offset) {
            gifs in
            self.presenter?.presentFetchedGifs(response: ListGifs.FetchDatas.Response(datas: gifs))
        }
    }
    
    func fetchGif(url: String, callback: @escaping ((Data?)->Void)) {
        Alamofire.request(url).responseData { (response) in
            callback(response.data)
        }
    }
}
