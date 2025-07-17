//
//  DeleteViewController.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/30/25.
//

import UIKit

class DeleteVC: UIViewController {
    
    var yesAction: (() -> Void)?

    @IBOutlet weak var deleteView: UIView!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
//    @IBAction func yesButton(_ sender: UIButton) {
//       
//    }
    
    var onDeleteProfile: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        deleteView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

}
