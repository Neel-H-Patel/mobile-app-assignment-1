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
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            return 3
        case 1:
            // need to set this eqaul to number of sectors in sectors array
            return 3
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
            
            
            let names = ["AAPL", "NVDA", "META"]

            if let name = names[indexPath.row] as? String {
                cell.textLabel!.text = name
            }
            // Configure the cell...

            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarketInfoCell", for: indexPath)
            
            
            let names = ["finance", "technology", "services"]

            // need to pass in the market sector names, we might need to create a new model for market info, not sure right now but may be a good idea to keep code clean
            if let name = names[indexPath.row] as? String {
                cell.textLabel!.text = name
            }
            // Configure the cell...

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutPageCell", for: indexPath)
            
            cell.textLabel!.text = "About"
            
            return cell
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
                // set up stock details on View Controller.swift
                // make calls and set properties
                // to ViewController class as needed
            vc.stockName = name
        }
        
    }

}
