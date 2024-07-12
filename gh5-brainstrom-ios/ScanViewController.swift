//
//  ScanViewController.swift
//  gh5-brainstrom-ios
//
//  Created by danny santoso on 7/12/24.
//

import Artector
import UIKit

class ScanViewController: UIViewController {
    
    var image: UIImage?
    
    var similarity: SimilarityResponse?
    
    private var diagonalLabelView: DiagonalLabelView?

    @IBOutlet weak var noteLabel: UILabel! {
        didSet {
            noteLabel.text = "This Image is plagiarism"
            noteLabel.textColor = UIColor.red
            noteLabel.isHidden = true
        }
    }
    @IBOutlet weak var frameImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.image = UIImage(named: "placeholder")
        }
    }
    
    @IBOutlet weak var similarityButton: UIButton! {
        didSet {
            similarityButton.backgroundColor = UIColor(rgb: 0x1B75BB)
            similarityButton.setTitle("Show Simillar Arts", for: .normal)
            similarityButton.setTitleColor(.white, for: .normal)
            similarityButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = image
        let maxPercentage: Float = similarity?.similarImage.map { $0.similarityScore }.max() ?? 0
        let similarityPercentage = (1 - maxPercentage) * 100
        
        // Add diagonal label view to frameImageView
        let diagonalLabelView = DiagonalLabelView(frame: photoImageView.bounds)
        diagonalLabelView.configure(text: "THIS IMAGE \(similarityPercentage)% PLAGIARISM")
        diagonalLabelView.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.isHidden = similarityPercentage > 50
        diagonalLabelView.isHidden = similarityPercentage > 50
        photoImageView.addSubview(diagonalLabelView)
        self.diagonalLabelView = diagonalLabelView
        
        // Constraints for diagonalLabelView
        NSLayoutConstraint.activate([
            diagonalLabelView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            diagonalLabelView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),
            diagonalLabelView.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            diagonalLabelView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor)
        ])
    }

    @IBAction func didTapShowSimillarity(_ sender: Any) {
        let imageGridVC = ImageGridViewController()
        imageGridVC.images = similarity?.similarImage ?? []
        self.present(imageGridVC, animated: true, completion: nil)
    }
}

import UIKit

class DiagonalLabelView: UIView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Set up the label
        label.backgroundColor = UIColor.red
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.transform = CGAffineTransform(rotationAngle: -45 * (.pi / 180)) // Rotate the label by -45 degrees
        addSubview(label)
        
        // Add constraints
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor, constant: sqrt(bounds.width * bounds.width + bounds.height * bounds.height)),
            label.heightAnchor.constraint(equalToConstant: 20) // Set the label's height to 20
        ])
    }
    
    func configure(text: String) {
        label.text = text
    }
}
