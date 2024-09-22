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
    @IBOutlet weak var StockSymbolLabel: UILabel!
    @IBOutlet weak var StockProfileImageView: UIImageView!
    @IBOutlet weak var StockPriceLabel: UILabel!
    @IBOutlet weak var StockPriceChangeLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    var timer:Timer = Timer()
    var timerCount:Int = 0
    
    var stockName = "error loading stock info"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
        self.stockModel.getStockPrice(withName: self.stockName) { stockPrice in
            self.StockPriceLabel.text = stockPrice
            self.StockSymbolLabel.text = self.stockName
            }
        
        self.stockModel.getStockPriceChange(withName: self.stockName) { stockPriceChange in
            self.StockPriceChangeLabel.text = stockPriceChange
            
            let firstChar = stockPriceChange.first!
                    
                    // Set color based on the first character
                    if firstChar == "+" {
                        self.StockPriceChangeLabel.textColor = .systemGreen
                    } else if firstChar == "-" {
                        self.StockPriceChangeLabel.textColor = .systemRed
                    } else {
                        // Optional: Handle cases where there's no sign (e.g., "0.00 (0.00%)")
                        self.StockPriceChangeLabel.textColor = .black
                    }
            }
    }
    
    @objc func timerCounter() -> Void
    {
        timerCount+=1
        TimerLabel.text = String(timerCount)+"s"
    }
    
    @IBAction func RefreshButton(_ sender: Any) {
        // refresh data and reload code here
    }
    


}

