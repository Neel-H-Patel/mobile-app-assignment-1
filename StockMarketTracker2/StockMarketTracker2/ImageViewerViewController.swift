//
//  ImageViewerViewController.swift
//  StockMarketTracker2
//
//  Created by Lyle Dev, Loaner on 9/22/24.
//

import UIKit

class ImageViewerViewController: UIViewController, UIScrollViewDelegate {

    lazy var aboutModel = {
        return AboutModel.sharedInstance()
    }()
    
    lazy private var imageView:UIImageView? = {
        return UIImageView.init(image: self.aboutModel.getImageWith(currImageIndex))
    }()
    
    var currImageIndex:Int32 = 99
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print (currImageIndex)
        if let size = self.imageView?.image?.size {
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 0.1
            self.scrollView.delegate = self
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

}
