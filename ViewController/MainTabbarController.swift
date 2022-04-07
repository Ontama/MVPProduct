//
//  MainTabbarController.swift
//  MVPProduct
//
//  Created by tomoyo_kageyama on 2022/04/06.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    func setupTab() {
        let contentViewController = ContentViewController()
        contentViewController.tabBarItem = UITabBarItem(title: "Featured", image: UIImage(systemName: "star.fill"), tag: 0)

        let secondViewController = ContentViewController()
        
        secondViewController.tabBarItem = UITabBarItem(title: "Landmarks", image: UIImage(systemName: "list.bullet"), tag: 1)

        viewControllers = [contentViewController, secondViewController]
    }
}
