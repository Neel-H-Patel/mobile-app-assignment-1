//
//  MarketViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

import UIKit

class MarketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var newsHeadlineTextView: UITextView!
    @IBOutlet weak var newsSummaryTextView: UITextView!
    
    
    let pickerData = ["general", "forex", "crypto", "merger"]
    var marketNewsName = "general"
    let marketNewsModel = MarketNewsModel.sharedInstance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate and data source
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        // Select the default row
        categoryPicker.selectRow(0, inComponent: 0, animated: false)
        
        // Load the initial article (will be from 'general' category because that is the default)
        loadArticle()
    }
    
    // for the segmented control, adjusts the size of the text in the article summary
    @IBAction func ChangeTextSizeSegmentedControl(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0: // Small
            newsSummaryTextView.font = UIFont.systemFont(ofSize: 12)
        case 1: // Medium
            newsSummaryTextView.font = UIFont.systemFont(ofSize: 16)
        case 2: // Large
            newsSummaryTextView.font = UIFont.systemFont(ofSize: 20)
        default:
            break
        }
    }
    
    // helper method to load the first article returned 
    func loadArticle() {
        marketNewsModel.getNewsArticle(withCategoryName: marketNewsName) { article in
                if let article = article,
                   let headline = article["headline"] as? String,
                   let summary = article["summary"] as? String {
                    self.newsHeadlineTextView.text = headline
                    self.newsSummaryTextView.text = summary
                }
        }
    }
    
    // MARK: - UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // MARK: - UIPickerViewDelegate Methods
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    // loads the article for whatever category that the user is currently on
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = pickerData[row]
        self.marketNewsName = selectedOption
        self.loadArticle()
    }
}
