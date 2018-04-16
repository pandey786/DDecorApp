//
//  ProductListViewController.swift
//  DDecorApp
//
//  Created by Durgesh Pandey on 13/04/18.
//  Copyright © 2018 DDecor. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var collectionViewProductList: UICollectionView!
    
    //Set Prod Category
    var productCategory: ProductCategory?
    var viewType: ViewType = .grid
    var productList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<20 {
            self.productList.append(String(i))
        }
        
        //Register Collection Cells
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_Grid", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_Grid")
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_List", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_List")
        
    }
    
    @IBAction func buttonBlockTapped(_ sender: Any) {
        self.viewType = .block
        self.collectionViewProductList.reloadData()
    }
    
    @IBAction func buttonGridTapped(_ sender: Any) {
        
        let sortByCtrl: SortOrderViewController = StoryBoard.main.instantiateViewController(withIdentifier: "SortOrderViewController") as! SortOrderViewController
        self.present(sortByCtrl, animated: true, completion: nil)
   
//        self.viewType = .grid
//        self.collectionViewProductList.reloadData()
    }
    
    @IBAction func buttonListTapped(_ sender: Any) {
        self.viewType = .list
        self.collectionViewProductList.reloadData()
    }
}

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.viewType {
        case .grid, .block:
            
            let collectionCell: ProdListCollectionViewCell_Grid = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_Grid", for: indexPath) as! ProdListCollectionViewCell_Grid
            return collectionCell
            
        case .list:
            
            let collectionCell: ProdListCollectionViewCell_List = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdListCollectionViewCell_List", for: indexPath) as! ProdListCollectionViewCell_List
            return collectionCell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch self.viewType {
        case .grid:
            let itemSize = CGSize.init(width: collectionView.frame.size.width/2 - 15, height: 200)
            return itemSize
            
        case .list:
            let itemSize = CGSize.init(width: collectionView.frame.size.width - 20, height: 120)
            return itemSize
            
        case .block:
            let itemSize = CGSize.init(width: collectionView.frame.size.width - 20, height: 180)
            return itemSize
            
        }
    }
}
