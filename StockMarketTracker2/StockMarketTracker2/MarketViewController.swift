//
//  MarketViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

import UIKit

class MarketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = pickerData[row]
        print("Selected: \(selectedOption)")
        // this is where we will proceed to the next page
    }
    
    
    lazy var marketNewsModel = {
        return MarketNewsModel.sharedInstance()
    }()
    
    var marketNewsName = "error loading news info"
    var newsSummaryInfo = "no summary found"

    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBOutlet weak var newsHeadlineTextView: UITextView!
    
    @IBOutlet weak var newsSummaryTextView: UITextView!
    
    @IBAction func ChangeText(_ sender: Any) {
    }
    let pickerData = ["Technology", "Business", "Top News"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.marketNewsModel.getNewsArticle(withCategoryName: self.marketNewsName) { article in
            DispatchQueue.main.async {
                if let article = article,
                   let headline = article["headline"] as? String,
                   let summary = article["summary"] as? String {
                    self.newsHeadlineTextView.text = headline
                    self.newsSummaryTextView.text = summary
                }
            }
        }
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
