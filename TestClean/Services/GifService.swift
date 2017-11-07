//
//  GifService.swift
//  TestClean
//
//  Created by Jura Moshkov on 07/11/2017.
//  Copyright © 2017 Jura Moshkov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift

class GifService {
    static let sharedService = GifService()
    
    let realm = try! Realm()
    
    func fetchGifs(query: String, count: Int = 20, offset: Int = 0, callback: @escaping (([GifData])->Void)) {
        let paramsString: String = "q=" + query + "&api_key=AffmExyubbG46vvj6iw5FoNUSa6O8d83&limit=" + String(count) + "&offset=" + String(offset)
        Alamofire.request("http://api.giphy.com/v1/gifs/search?" + paramsString).responseArray(queue: nil, keyPath: "data", context: nil) { (response: DataResponse<[GifData]>) in
            callback(response.result.value!)
        }
    }
    
    func cachedGifTrends() -> [GifData] {
        return Array(realm.objects(GifData.self))
    }
    
    func fetchGifTrends(count: Int = 20, offset: Int = 0, callback: @escaping (([GifData])->Void)) {
        let paramsString: String = "&api_key=AffmExyubbG46vvj6iw5FoNUSa6O8d83&limit=" + String(count) + "&offset=" + String(offset)
        Alamofire.request("http://api.giphy.com/v1/gifs/trending?" + paramsString).responseArray(queue: nil, keyPath: "data", context: nil) { (response: DataResponse<[GifData]>) in
            callback(response.result.value!)
            try! self.realm.write {
                self.realm.deleteAll()
                self.realm.add(response.result.value!)
            }
        }
    }
}
