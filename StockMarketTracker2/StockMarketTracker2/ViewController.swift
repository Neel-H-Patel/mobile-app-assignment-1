//
//  ViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    var stockName = "Google"
    
    lazy var stockModel:StockModel = {
        return StockModel.sharedInstance()
    }()
    
    
    @IBOutlet weak var StockNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        StockNameLabel.text = stockName
    }
    
    


}

