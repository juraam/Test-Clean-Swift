//
//  ListGifsModels.swift
//  TestClean
//
//  Created by Jura Moshkov on 05/11/2017.
//  Copyright © 2017 Jura Moshkov. All rights reserved.
//

import UIKit

enum ListGifs {
    // MARK: Use cases
    
    enum FetchDatas {
        struct Request {
            var query: String?
            var count: Int = 25
            var offset: Int = 0
        }
        struct Response {
            var datas: [GifData]
        }
        struct ViewModel {
            var displayedDatas: [GifData]
        }
    }
}
