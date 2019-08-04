//
//  ViewController.swift
//  ImgSeach_XI_Li
//
//  Created by Lucas on 7/25/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchResultsUpdating{
    let searchController = UISearchController(searchResultsController: nil)
    var keyWord = ""
    var dataArray = NSMutableArray()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 3) / 3, height: (UIScreen.main.bounds.size.width - 3) / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0);
        layout.minimumInteritemSpacing = 0.5;
        layout.minimumLineSpacing = 1;

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupUI()
    }

    
    
    private func setupUI(){
        setupSearchNav()
        setupCollectionView()
    }
    
    
   private func setupSearchNav(){
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.title = "Search Demo"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupCollectionView(){
        self.view.addSubview(collectionView)
    }

    internal func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        if text.count > 0 {
            if keyWord == text{
                return
            }
            keyWord = text
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(delayExecution), with: nil, afterDelay: 1)
        }
    }
    

    @objc func delayExecution() {

        NetworkTools.shared.request(keyWord: keyWord) { (array, nil) in
            self.dataArray.removeAllObjects()
            self.dataArray.addObjects(from: array!)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! CollectionViewCell
        cell.cellModel = self.dataArray[indexPath.row] as? Model
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let view = ImgDetailController()
        view.imgURL = cell.cellModel?.imgURL
        self.navigationController?.pushViewController(view, animated: true)
    }


    
    
}

