//
//  ListGifsViewController.swift
//  TestClean
//
//  Created by Jura Moshkov on 05/11/2017.
//  Copyright © 2017 Jura Moshkov. All rights reserved.
//

import UIKit
import SwiftGifOrigin

protocol ListGifsDisplayLogic: class {
    func displayFetchedGifs(viewModel: ListGifs.FetchDatas.ViewModel)
}

class ListGifsViewController: UIViewController, ListGifsDisplayLogic, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var interactor: ListGifsBusinessLogic?
    //var router: (NSObjectProtocol & ListOrdersRoutingLogic & ListOrdersDataPassing)?
    var gifs: [GifData] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        let viewController = self
        let interactor = ListGifsInteractor()
        let presenter = ListGifsPresenter()
        //let router = ListOrdersRouter()
        viewController.interactor = interactor
        //viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        //router.viewController = viewController
        //router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchTrends(request: ListGifs.FetchDatas.Request(query: nil, count: 20, offset: 0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayFetchedGifs(viewModel: ListGifs.FetchDatas.ViewModel) {
        gifs = viewModel.displayedDatas
        collectionView.reloadData()
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    // Collection Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GifCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as! GifCollectionViewCell
        interactor?.fetchGif(url: gifs[indexPath.row].url, callback: { (data) in
            cell.imageView.image = UIImage.gif(data: data!)
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 3, height: view.frame.size.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
