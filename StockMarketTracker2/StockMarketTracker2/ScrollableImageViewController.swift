//
//  ImageViewController.swift
//  StockMarketTracker2
//
//  Created by Lyle Dev, Loaner on 9/22/24.
//

import UIKit

class ScrollableImageViewController: UIViewController {

    lazy var aboutModel = {
        return AboutModel.sharedInstance()
    }()
    
    lazy private var imageView:UIImageView? = {
        return UIImageView.init(image: self.aboutModel.getImageWith(currImageIndex))
    }()
    
    var currImageIndex:Int32 = 99
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.scrollView.backgroundColor = UIColor.blue
        // self.scrollView.addSubview(self.imageView!)
    }
    

}
