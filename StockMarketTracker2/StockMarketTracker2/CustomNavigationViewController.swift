//
//  CustomNavigationViewController.swift
//  StockMarketTracker2
//
//  Created by Neel Patel on 9/22/24.
//

import UIKit

// got help on how to create light/dark mode switch from this very helpful youtube video, had to adapt it to work with current IOS versions though
// https://www.youtube.com/watch?v=8hhG77-rS_A
// and gained understanding on how to apply global stylings and how to correctly configure scenes and windows through these links
// https://developer.apple.com/documentation/uikit/app_and_environment/scenes/
// https://developer.apple.com/documentation/uikit/uinavigationcontroller

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the switch
        let themeSwitch = UISwitch()
        themeSwitch.addTarget(self, action: #selector(themeSwitchToggled(_:)), for: .valueChanged)

        // Create a bar button item with the switch
        let switchItem = UIBarButtonItem(customView: themeSwitch)

        // Add the switch to the navigation bar of our table view controller (which is our top controller on the stack)
        topViewController?.navigationItem.rightBarButtonItem = switchItem
        
    }

    @objc func themeSwitchToggled(_ sender: UISwitch) {
        // sets the background mode to dark if switch is on, otherwise light mode
        let style: UIUserInterfaceStyle = sender.isOn ? .dark : .light

        // since we only have one scene, we can access the window through that scene and set it to our current style
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = style
        }
    }
}
