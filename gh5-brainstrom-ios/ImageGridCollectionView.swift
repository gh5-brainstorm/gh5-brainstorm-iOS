//
//  ImageGridCollectionView.swift
//  gh5-brainstrom-ios
//
//  Created by danny santoso on 7/12/24.
//

import Artector
import UIKit

class ImageGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    var images: [ImageResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        self.view.addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(with: images[indexPath.item].url, percentage: images[indexPath.item].similarityScore)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width
        let itemWidth = collectionViewWidth / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: self.contentView.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    func configure(with urlString: String, percentage: Float = 0) {
        guard let url = URL(string: urlString) else { return }
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
        let diagonalLabelView = DiagonalLabelView(frame: imageView.bounds)
        diagonalLabelView.configure(text: "THIS IMAGE \(percentage)% PLAGIARISM")
        diagonalLabelView.translatesAutoresizingMaskIntoConstraints = false
        diagonalLabelView.isHidden = percentage > 50
        imageView.addSubview(diagonalLabelView)
        
        // Constraints for diagonalLabelView
        NSLayoutConstraint.activate([
            diagonalLabelView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            diagonalLabelView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            diagonalLabelView.topAnchor.constraint(equalTo: imageView.topAnchor),
            diagonalLabelView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}

