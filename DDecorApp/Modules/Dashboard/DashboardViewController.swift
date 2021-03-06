//
//  DashboardViewController.swift
//  DDecorApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 DDecor. All rights reserved.
//

import UIKit
import AACarousel
import Kingfisher

public enum ProductCategory: String {
    case collections
    case curtains
    case bedLinen
    case wallpaper
    case rmc
    case cushions
    case rugs
}

public enum ViewType {
    case grid
    case list
    case block
}

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet weak var imageCarouselView: AACarousel!
    @IBOutlet weak var constraintImageCarouselViewHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintCatelogViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewProductList: UICollectionView!
    
    var selectedProductCategory: ProductCategory?
    
    //product List
    var viewType: ViewType = .grid
    var productList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Top View height
        self.constraintImageCarouselViewHeight.constant = self.view.bounds.size.height - 64.0
        self.constraintCatelogViewHeight.constant = self.view.bounds.size.height - 64.0
        
        //Set Up Carousel
        let pathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "https://ak.picdn.net/assets/cms/97e1dd3f8a3ecb81356fe754a1a113f31b6dbfd4-stock-photo-photo-of-a-common-kingfisher-alcedo-atthis-adult-male-perched-on-a-lichen-covered-branch-107647640.jpg",
                         "https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                         "http://www.conversion-uplift.co.uk/wp-content/uploads/2016/09/Lamborghini-Huracan-Image-672x372.jpg"]
        self.setUpCarouselViewWithImagesArray(imageStrArray: pathArray)
        
        for i in 0..<20 {
            self.productList.append(String(i))
        }
        
        //Register Collection Cells
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_Grid", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_Grid")
        self.collectionViewProductList.register(UINib.init(nibName: "ProdListCollectionViewCell_List", bundle: nil), forCellWithReuseIdentifier: "ProdListCollectionViewCell_List")
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonStartExploringTapped(_ sender: Any) {
        let bottomOffset = CGPoint(x: 0, y: scrollViewMain.contentSize.height - scrollViewMain.bounds.size.height)
        scrollViewMain.setContentOffset(bottomOffset, animated: true)
    }
    
    @IBAction func categoryCollectionsTapped(_ sender: Any) {
        
        self.selectedProductCategory = .collections
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func categoryCurtainsTapped(_ sender: Any) {
        
        self.selectedProductCategory = .curtains
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func categoryBedLinenTapped(_ sender: Any) {
        
        self.selectedProductCategory = .bedLinen
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func categoryWallpaperTapped(_ sender: Any) {
        
        self.selectedProductCategory = .wallpaper
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func categoryRMCTapped(_ sender: Any) {
        
        self.selectedProductCategory = .rmc
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func categoryCushionsTapped(_ sender: Any) {
        
        self.selectedProductCategory = .cushions
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func categoryRugsTapped(_ sender: Any) {
        
        self.selectedProductCategory = .rugs
        self.performSegue(withIdentifier: "ProductListViewController", sender: nil)
    }
    
    @IBAction func buttonBlockTapped(_ sender: Any) {
        self.viewType = .block
        self.collectionViewProductList.reloadData()
    }
    
    @IBAction func buttonFilterByTapped(_ sender: Any) {
        
        let sortByCtrl: SortOrderViewController = StoryBoard.main.instantiateViewController(withIdentifier: "SortOrderViewController") as! SortOrderViewController
        self.present(sortByCtrl, animated: true, completion: nil)
        
        /*
        let filterByCtrl: FilterListViewController = StoryBoard.main.instantiateViewController(withIdentifier: "FilterListViewController") as! FilterListViewController
        self.present(filterByCtrl, animated: true, completion: nil) */
    }
    
    @IBAction func buttonGridTapped(_ sender: Any) {
        
                self.viewType = .grid
                self.collectionViewProductList.reloadData()
    }
    
    @IBAction func buttonListTapped(_ sender: Any) {
        self.viewType = .list
        self.collectionViewProductList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductListViewController" {
            
            let prodListCtrl: ProductListViewController = segue.destination as! ProductListViewController
            prodListCtrl.productCategory = self.selectedProductCategory
        }
    }
}

// MARK: - AACarousel
// MARK: -
extension DashboardViewController: AACarouselDelegate {
    
    func setUpCarouselViewWithImagesArray(imageStrArray: [String]) {
        
        self.imageCarouselView.delegate = self
        self.imageCarouselView.setCarouselData(paths: imageStrArray,  describedTitle: [], isAutoScroll: true, timer: 5.0, defaultImage: "image_Placeholder")
        self.imageCarouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: UIColor.clear, layerColor: UIColor.clear)
        
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "image_Placeholder"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "image_Placeholder"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            
            if let imageDownloaded = downloadImage {
                self.imageCarouselView.images[index] = imageDownloaded
            }
        })
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
    }
}

// MARK: - Product List Collection View
// MARK: -
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Navigate To Product Details page
        self.performSegue(withIdentifier: "ProductDetailsViewController", sender: nil)
    }
}
