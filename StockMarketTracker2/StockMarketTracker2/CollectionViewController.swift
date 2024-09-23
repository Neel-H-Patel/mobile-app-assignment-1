//
//  CollectionViewController.swift
//  StockMarketTracker2
//
//  Created by Lyle Dev, Loaner on 9/22/24.
//

import UIKit

private let reuseIdentifier = "CustomCell"

class CollectionViewController: UICollectionViewController {
    
    lazy var aboutModel = {
        return AboutModel.sharedInstance()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ImageViewerViewController,
           let cell = sender as? CollectionViewCell {
            vc.currImageIndex = cell.cellIndex
        }
    }


    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print (aboutModel.getImageCount())
        return Int(aboutModel.getImageCount());
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell {
            // Configure the cell
            cell.imageView.image = aboutModel.getImageWith(Int32(indexPath.row))
            cell.cellIndex = Int32(indexPath.row)
            return cell
        }
        else{
            fatalError ("incorrect cell type. could not dequeue")
        }
    
    
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
