//
//  DeleteViewController.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/30/25.
//

import UIKit

class DeleteVC: UIViewController {
    var indexPath: IndexPath?
    var current = ProfileManager.shared.profiles.value


    @IBOutlet weak var deleteView: UIView!
    
    @IBOutlet var superView: UIView!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func yesButton(_ sender: UIButton) {
        deleteProfile()
        
        dismiss(animated: true) {
            self.onDelete?()
        }
    }
    
    var onDelete: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        deleteView.layer.cornerRadius = 20
    }
    
    public func deleteProfile() {
        guard let index = indexPath?.row else { return }
        guard current.indices.contains(index) else { return }
        current.remove(at: index)
        ProfileManager.shared.profiles.send(current)
    }
}
