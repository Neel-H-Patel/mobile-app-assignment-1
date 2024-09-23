//
//  CustomNavigationViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/22/24.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the switch
        let themeSwitch = UISwitch()
        themeSwitch.addTarget(self, action: #selector(themeSwitchToggled(_:)), for: .valueChanged)

        // Create a bar button item with the switch
        let switchItem = UIBarButtonItem(customView: themeSwitch)

        // Add the switch to the navigation bar of our table view controller
        topViewController?.navigationItem.rightBarButtonItem = switchItem
        
    }

    @objc func themeSwitchToggled(_ sender: UISwitch) {
        let style: UIUserInterfaceStyle = sender.isOn ? .dark : .light

        // Iterate through all connected scenes
        for scene in UIApplication.shared.connectedScenes {
            // Ensure the scene is a UIWindowScene
            if let windowScene = scene as? UIWindowScene {
                // Iterate through all windows in the scene
                for window in windowScene.windows {
                    window.overrideUserInterfaceStyle = style
                }
            }
        }
    }
}
