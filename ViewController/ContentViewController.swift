//
//  ContentViewController.swift
//  MVP+UIKit
//
//  Created by tomoyo_kageyama on 2022/04/05.
//

import UIKit

final class ContentViewController: UIViewController {
    private let tableView = UITableView()
    private var presenter: ContentViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        presenter = ContentViewPresenter(self)
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame.size = UIScreen.main.bounds.size
        super.viewWillLayoutSubviews()
    }
}

extension ContentViewController: ContentViewPresenterOutput {
    func didFetch(_ Landmark: [Landmark]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func didPushViewController(of landmark: Landmark) {
        // TODO: 詳細画面へ遷移
        print("詳細画面へ遷移")
    }
}

extension ContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else {
            return UITableViewCell()
        }
        
        if let additionalCell = presenter.additionalCell(forRow: indexPath.row) {
            let cell = FavoriteOnlyCell(showFavoritesOnly: presenter.showFavoritesOnly)
            cell.delegate = self
            cell.textLabel?.text = additionalCell.rawValue
            return cell
        }
        
        guard let landmark = presenter.landmark(forRow: indexPath.row) else { return UITableViewCell() }
        let cell = LandmarkCell(landmark: landmark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContentViewController: FavoriteOnlyCellDelegate {
    func favoriteOnlyCellSwitch(toggle: UISwitch) {
        presenter.showFavoritesOnly = toggle.isOn
        tableView.reloadData()
    }
}
