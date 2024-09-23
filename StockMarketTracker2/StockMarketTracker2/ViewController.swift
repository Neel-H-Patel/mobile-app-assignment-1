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
    
    // stock details UI elements
    @IBOutlet weak var StockNameLabel: UILabel!
    @IBOutlet weak var StockSymbolLabel: UILabel!
    @IBOutlet weak var StockProfileImageView: UIImageView!
    @IBOutlet weak var StockPriceLabel: UILabel!
    @IBOutlet weak var StockPriceChangeLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    // share multiplier UI elements
    @IBOutlet weak var ShareCountLabel: UILabel!
    @IBOutlet weak var ShareMultiplierLabel: UILabel!
    @IBOutlet weak var ShareCountSlider: UISlider!
    @IBOutlet weak var ShareCountStepper: UIStepper!
    
    // variables for time since last update timer
    var timer:Timer = Timer()
    var timerCount:Int = 0
    
    // current stock
    var stockName = "error loading stock info"
    
    // variable for share mutliplier
    var shareCount:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        self.shareCount = 1; // for share multiplier
        
        // set stock symbol label
        self.StockSymbolLabel.text = self.stockName
        
        // asynchronous closure to update UI related to stock price
        self.stockModel.getStockPrice(withName: self.stockName) { stockPrice in
            self.StockPriceLabel.text = stockPrice
            self.updateShareMultiplier() // also update the share multiplier text at the bottom of the screen
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
        
        self.stockModel.getStockFullName(withName: self.stockName) { stockFullName in
            self.StockNameLabel.text = stockFullName
            }
        
        self.StockProfileImageView.image = self.stockModel.getStockImage(withName: self.stockName)
    }
    
    @objc func timerCounter() -> Void
    {
        timerCount+=1
        TimerLabel.text = String(timerCount)+"s"
    }
    
    @IBAction func handleRefreshButtonClick(_ sender: Any) {
        self.stockModel.getStockPrice(withName: self.stockName) { stockPrice in
            self.StockPriceLabel.text = stockPrice
            self.updateShareMultiplier() // also update the share multiplier text at the bottom of the screen
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
        
        // reset timer
        self.timerCount = 0
    }
    

    @IBAction func handleShareCountSliderChange(_ sender: Any) {
        if let slider = sender as? UISlider {
            shareCount = Int(slider.value)
            ShareCountStepper.value = Double(shareCount)
            updateShareMultiplier()
        }
    }
    
    @IBAction func handleShareCountStepperChange(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            shareCount = Int(stepper.value)
            ShareCountSlider.value = Float(shareCount)
            updateShareMultiplier()
        }
    }
    
    func updateShareMultiplier(){
        ShareCountLabel.text = String(shareCount) + " shares"
        if let currStockPriceText = StockPriceLabel.text?.dropFirst().description,
           let currStockPrice = Double(currStockPriceText) {
            
            let multipliedShareValue = String(format:"%.2f", Double(shareCount) * currStockPrice)
            let formattedStockPrice = String(format:"%.2f", currStockPrice)
            
            ShareMultiplierLabel.text = "\(shareCount) shares @ $\(formattedStockPrice) = $\(multipliedShareValue)"
        }
        else {
            print("Failed to update share multiplier")
        }
    }
    
    
}

