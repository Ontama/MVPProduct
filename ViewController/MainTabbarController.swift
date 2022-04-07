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
        contentViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        let secondViewController = ContentViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)

        viewControllers = [contentViewController, secondViewController]
    }
}
