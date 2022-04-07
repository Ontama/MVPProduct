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
    private var showFavoritesOnly = false
    
    private var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter({ landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        })
    }

    enum AdditionalCell: String, CaseIterable, Codable {
        case favorite = "Favorites only"
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame.size = UIScreen.main.bounds.size
        super.viewWillLayoutSubviews()
    }
}

extension ContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AdditionalCell.allCases.count + filteredLandmarks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else {
            return UITableViewCell()
        }
        
        if indexPath.row < AdditionalCell.allCases.count {
            let cell = FavoriteOnlyCell(showFavoritesOnly: showFavoritesOnly)
            cell.delegate = self
            cell.textLabel?.text = AdditionalCell.allCases[indexPath.row].rawValue
            return cell
        }
        
        guard indexPath.row < filteredLandmarks.count + AdditionalCell.allCases.count else {
            return UITableViewCell()
        }
        
        let landmark = filteredLandmarks[indexPath.row - AdditionalCell.allCases.count]
        let cell = LandmarkCell(landmark: landmark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContentViewController: FavoriteOnlyCellDelegate {
    func favoriteOnlyCellSwitch(toggle: UISwitch) {
        showFavoritesOnly = toggle.isOn
        tableView.reloadData()
    }
}
