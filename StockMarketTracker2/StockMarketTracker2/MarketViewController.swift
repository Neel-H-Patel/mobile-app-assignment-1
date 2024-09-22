//
//  MarketViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

import UIKit

class MarketViewController: UIViewController {
    
    lazy var stockModel = {
        return StockModel.sharedInstance()
    }()
    
    var stockName = "error loading stock info"

    @IBOutlet weak var marketViewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stockModel.getStockPrice(withName: self.stockName) { stockPrice in
            self.marketViewButton.titleLabel?.text = stockPrice
            }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
