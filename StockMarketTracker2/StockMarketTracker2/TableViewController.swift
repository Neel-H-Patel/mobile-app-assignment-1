//
//  TableViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/18/24.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var stockModel:StockModel = {
        return StockModel.sharedInstance()
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // need to set this equal to the number of stocks in stockNames array
            return self.stockModel.numberOfStocks();
        case 1:
            // just the connection to Market News page cell. Always 1
            return 1
        case 2:
            // just the About page cell. Always 1
            return 1
        default:
            print("out of range table section provided")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StockNameCell", for: indexPath)
            
            
            let name = self.stockModel.getStockName(for: indexPath.row)
            
            cell.textLabel!.text = name

            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketInfoCell", for: indexPath)
            
            cell.textLabel!.text = "Market News"

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutPageCell", for: indexPath)
            
            cell.textLabel!.text = "About"
            
            return cell
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
            vc.stockName = name
        }
    }

}
