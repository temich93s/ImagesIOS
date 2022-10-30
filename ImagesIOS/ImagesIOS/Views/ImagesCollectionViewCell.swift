//
//  MainCollectionViewCell.swift
//  ImagesIOS
//
//  Created by 2lup on 30.10.2022.
//

import UIKit

// MARK: - ImagesCollectionViewCell

/// Ячейка с картинкой
class ImagesCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        static let fatalErrorText = "init(coder:) has not been implemented"
        static let placeholderImageName = "PlaceholderImage"
    }
    
    // MARK: - Private Visual Properties
    private let imageImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    // MARK: - Public Methods
    func configureImagesCollectionViewCell() {
        imageImageView.image = UIImage(named: Constants.placeholderImageName)
        guard let url = URL(string: "https://picsum.photos/800") else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let safeData = data else { return }
                self.imageImageView.image = UIImage(data: safeData)
            }
        }
    }
    
    // MARK: - Private Methods
    private func initView() {
        contentView.addSubview(imageImageView)
        createImageImageViewConstraint()
    }
    
    private func createImageImageViewConstraint() {
        imageImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
