//
//  ScanViewController.swift
//  gh5-brainstrom-ios
//
//  Created by danny santoso on 7/12/24.
//

import UIKit

class ScanViewController: UIViewController {

    @IBOutlet weak var frameImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.image = UIImage(named: "placeholder")
        }
    }
    
    @IBOutlet weak var proceedButton: UIButton! {
        didSet {
            proceedButton.backgroundColor = UIColor(rgb: 0x1B75BB)
            proceedButton.setTitle("Scan", for: .normal)
            proceedButton.setTitleColor(.white, for: .normal)
            proceedButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTapProceedButton(_ sender: Any) {
    }
}
