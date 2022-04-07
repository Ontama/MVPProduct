//
//  ContentViewController.swift
//  MVP+UIKit
//
//  Created by tomoyo_kageyama on 2022/04/05.
//

import UIKit

final class ContentViewController: UIViewController {
    private let tableView = UITableView()
    private let modelData = ModelData()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        tableView.fillSuperview()
        super.viewWillLayoutSubviews()
    }
}

extension ContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else {
            return UITableViewCell()
        }
        
        guard indexPath.row < modelData.landmarks.count else {
            return UITableViewCell()
        }
        
        let landmark = modelData.landmarks[indexPath.row]
        let cell = LandmarkCell(image: landmark.image, name: landmark.name)
        return cell
    }
}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.landmarks.count
    }
}
