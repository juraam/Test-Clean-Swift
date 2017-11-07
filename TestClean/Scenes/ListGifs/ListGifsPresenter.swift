//
//  ListGifsPresenter.swift
//  TestClean
//
//  Created by Jura Moshkov on 07/11/2017.
//  Copyright © 2017 Jura Moshkov. All rights reserved.
//

import UIKit

protocol ListGifsPresentationLogic {
    func presentFetchedGifs(response: ListGifs.FetchDatas.Response)
}

class ListGifsPresenter: ListGifsPresentationLogic {
    weak var viewController: ListGifsDisplayLogic?
    
    func presentFetchedGifs(response: ListGifs.FetchDatas.Response) {
        viewController?.displayFetchedGifs(viewModel: ListGifs.FetchDatas.ViewModel(displayedDatas: response.datas))
    }
}
