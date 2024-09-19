//
//  ViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    // lazily instantiate our stock model so that it is only initailzed when
    // someone asks for it
    lazy var stockModel = {
        return StockModel.sharedInstance()
    }()
    
    
    @IBOutlet weak var StockNameLabel: UILabel!
    
    var stockName = "Google"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.StockNameLabel.text = self.stockModel.getStockInfo(withName: stockName)
    }
    
    


}

