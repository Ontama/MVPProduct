//
//  LandmarkCell.swift
//  MVP+UIKit
//
//  Created by tomoyo_kageyama on 2022/04/06.
//

import UIKit

final class LandmarkCell: UITableViewCell {
    private let landmarkImage: UIImage
    private let landmarkName: String
    private let starImageView: UIImageView
    private let starImageWidth = CGFloat(50)
    
    init(image: UIImage, name: String){
        landmarkImage = image
        landmarkName = name
        let starImage = UIImage(systemName: "star.fill")
        starImageView = UIImageView(image: starImage)
    
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView?.image = landmarkImage
        accessoryType = .none
        textLabel?.text = landmarkName
        starImageView.frame = CGRect(x: 0, y: 0, width: frame.width - starImageWidth, height: 50)
        super.layoutSubviews()
    }
}
