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

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet weak var imageCarouselView: AACarousel!
    @IBOutlet weak var constraintImageCarouselViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Top View height
        self.constraintImageCarouselViewHeight.constant = self.view.bounds.size.height - 64.0
        
        //Set Up Carousel
        let pathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "https://ak.picdn.net/assets/cms/97e1dd3f8a3ecb81356fe754a1a113f31b6dbfd4-stock-photo-photo-of-a-common-kingfisher-alcedo-atthis-adult-male-perched-on-a-lichen-covered-branch-107647640.jpg",
                         "https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                         "http://www.conversion-uplift.co.uk/wp-content/uploads/2016/09/Lamborghini-Huracan-Image-672x372.jpg"]
        self.setUpCarouselViewWithImagesArray(imageStrArray: pathArray)
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonStartExploringTapped(_ sender: Any) {
        let bottomOffset = CGPoint(x: 0, y: scrollViewMain.contentSize.height - scrollViewMain.bounds.size.height)
        scrollViewMain.setContentOffset(bottomOffset, animated: true)
    }
    
    @IBAction func categoryCollectionsTapped(_ sender: Any) {
    }
    
    @IBAction func categoryCurtainsTapped(_ sender: Any) {
    }
    
    @IBAction func categoryBedLinenTapped(_ sender: Any) {
    }
    
    @IBAction func categoryWallpaperTapped(_ sender: Any) {
    }
    
    @IBAction func categoryRMCTapped(_ sender: Any) {
    }
    
    @IBAction func categoryCushionsTapped(_ sender: Any) {
    }
    
    @IBAction func categoryRugsTapped(_ sender: Any) {
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
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
    }
}
