//
//  ViewController.swift
//  gh5-brainstrom-ios
//
//  Created by danny santoso on 7/11/24.
//

import Artector
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "How you like\nto scan"
        }
    }
    
    @IBOutlet weak var imageBackground: UIImageView! {
        didSet {
            imageBackground.image = UIImage(named: "wave-blue")
            imageBackground.contentMode = .scaleToFill
        }
    }
    
    @IBOutlet weak var subtitleLabel: UIButton! {
        didSet {
            subtitleLabel.setTitle("Options to Select", for: .normal)
            subtitleLabel.setTitleColor(.white, for: .normal)
            subtitleLabel.layer.cornerRadius = subtitleLabel.frame.height / 2
            subtitleLabel.backgroundColor = UIColor(rgb: 0x7ACFFF)
            subtitleLabel.isUserInteractionEnabled = false

            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
            subtitleLabel.configuration = configuration
        }
    }
    
    @IBOutlet weak var galleryButton: UIButton! {
        didSet {
            galleryButton.tintColor = UIColor(rgb: 0x7ACFFF)
            galleryButton.layer.borderWidth = 2
            galleryButton.layer.cornerRadius = 18
            galleryButton.layer.borderColor = UIColor(rgb: 0xAFD8EC).cgColor
        }
    }

    @IBOutlet weak var galleryLabel: UIButton! {
        didSet {
            galleryLabel.setTitle("Gallery", for: .normal)
            galleryLabel.setTitleColor(.white, for: .normal)
            galleryLabel.backgroundColor = UIColor(rgb: 0x1B75BB)
            galleryLabel.layer.cornerRadius = 10
            galleryLabel.isUserInteractionEnabled = false
            
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
            galleryLabel.configuration = configuration
        }
    }
    
    @IBOutlet weak var cameraButton: UIButton! {
        didSet {
            cameraButton.tintColor = UIColor(rgb: 0x7ACFFF)
            cameraButton.layer.borderWidth = 2
            cameraButton.layer.cornerRadius = 18
            cameraButton.layer.borderColor = UIColor(rgb: 0xAFD8EC).cgColor
        }
    }

    @IBOutlet weak var cameraLabel: UIButton! {
        didSet {
            cameraLabel.setTitle("Camera", for: .normal)
            cameraLabel.setTitleColor(.white, for: .normal)
            cameraLabel.backgroundColor = UIColor(rgb: 0x1B75BB)
            cameraLabel.layer.cornerRadius = 10
            cameraLabel.isUserInteractionEnabled = false
            
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            cameraLabel.configuration = configuration
        }
    }
    
    @IBOutlet weak var audioButton: UIButton! {
        didSet {
            audioButton.tintColor = UIColor(rgb: 0x7ACFFF)
            audioButton.layer.borderWidth = 2
            audioButton.layer.cornerRadius = 18
            audioButton.layer.borderColor = UIColor(rgb: 0xAFD8EC).cgColor
        }
    }

    @IBOutlet weak var audioLabel: UIButton! {
        didSet {
            audioLabel.setTitle("Audio", for: .normal)
            audioLabel.setTitleColor(.white, for: .normal)
            audioLabel.backgroundColor = UIColor(rgb: 0x1B75BB)
            audioLabel.layer.cornerRadius = 10
            audioLabel.isUserInteractionEnabled = false
            
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            audioLabel.configuration = configuration
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Artector.shared.delegate = self
    }
    
    private func navigateToScanPage(image: UIImage) {
        let scanVC = ScanViewController()
        scanVC.image = image
        navigationController?.pushViewController(scanVC, animated: true)
    }
    
    @IBAction func didTapGalleryButton(_ sender: Any) {
        Artector.shared.showGalleryPicker(from: self)
    }
    
    @IBAction func didTapCameraButton(_ sender: Any) {
        Artector.shared.showCamera(from: self)
    }
}

extension ViewController: ArtectorDelegate {
    func artector(_: Artector, didReceiveImage: UIImage) {
        DispatchQueue.main.async {
            self.navigateToScanPage(image: didReceiveImage)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
