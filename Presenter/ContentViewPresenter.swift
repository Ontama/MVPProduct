//
//  ContentViewPresenter.swift
//  MVPProduct
//
//  Created by tomoyo_kageyama on 2022/04/07.
//

import Foundation

protocol ContentViewPresenterInput {
    var showFavoritesOnly: Bool { get }
    var numberOfRowsInSection: Int { get }
    var filteredLandmarks: [Landmark] { get }
    func landmark(forRow row: Int) -> Landmark?
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol ContentViewPresenterOutput: AnyObject {
    func didFetch(_ landmarks: [Landmark])
    func didPushViewController(of landmark: Landmark)
}

class ContentViewPresenter: ContentViewPresenterInput {
    private let modelData = ModelData()
    private weak var vc: ContentViewPresenterOutput?
    
    var showFavoritesOnly = false
    
    let numberOfSections = 1
    
    enum Addition: String, CaseIterable, Codable {
        case favorite = "Favorites only"
    }
    
    init(_ view: ContentViewPresenterOutput) {
        self.vc = view
    }
    
    var numberOfRowsInSection: Int {
        return Addition.allCases.count + filteredLandmarks.count
    }
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter({ landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        })
    }
    
    func additionalCell(forRow row: Int) -> Addition? {
        guard row < Addition.allCases.count else { return nil }
        return Addition.allCases[row]
    }
    
    func landmark(forRow row: Int) -> Landmark? {
        // 一番上はAdditionalCellが付与されているのでその分は引く
        let index = row - Addition.allCases.count
        guard index < filteredLandmarks.count else { return nil }
        return filteredLandmarks[index]
    }
    
    func viewDidLoad() {
        vc?.didFetch(filteredLandmarks)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let landmark = landmark(forRow: indexPath.row) else { return }
        vc?.didPushViewController(of: landmark)
    }
}
