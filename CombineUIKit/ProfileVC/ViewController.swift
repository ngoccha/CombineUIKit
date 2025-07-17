//
//  ViewController.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/24/25.
//

import UIKit
import Combine


class ViewController: UIViewController, UIGestureRecognizerDelegate {
    let manager = ProfileManager.shared
    var cancel = Set<AnyCancellable>()
    var indexPath: IndexPath?
    
    var profile: Profile?
    var tableView: ListVC?
    var index: Int?
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var editOutletButton: UIButton!
    @IBOutlet weak var BoundView: UIView!
    
    @IBAction func toCalc(_ sender: UIButton) {
        let calcStoryboard = UIStoryboard(name: "InformationVC", bundle: nil)
        
        guard let infoVC = calcStoryboard.instantiateViewController(withIdentifier: "InformationVC") as? InformationVC else { return }
        
        let fullName = fullName.text ?? "----"
        let bmi = bmiLabel.text ?? "---"
        let weight = weightLabel.text ?? "-- kg"
        let height = heightLabel.text ?? "-- cm"
        let gender = genderLabel.text ?? "--"
        
        infoVC.fullNameResult = fullName
        infoVC.bmiResult = bmi
        infoVC.weightResult = weight
        infoVC.heightResult = height
        infoVC.genderResult = gender
        
        //        infoVC.onChangeResult = { [weak self] newProfile in
        //            self?.fullName.text = newProfile.fullName
        //            self?.bmiLabel.text = newProfile.bmi
        //            self?.heightLabel.text = "\(newProfile.height) cm"
        //            self?.weightLabel.text = "\(newProfile.weight) kg"
        //            self?.genderLabel.text = newProfile.gender
        //            self?.profile = newProfile
        //            self?.updateUI()
        //        }
        
        infoVC.indexPath = self.indexPath
        infoVC.profile = self.profile

        self.navigationController?.pushViewController(infoVC, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "Left"), style: .plain, target: self, action: #selector(back))
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.leftBarButtonItem?.tintColor = .neutral2
        navigationItem.rightBarButtonItem = .init(image: UIImage(named: "Delete"), style: .plain, target: self, action: #selector(deleteProfile))
        navigationItem.rightBarButtonItem?.tintColor = .delete
        
        BoundView.layer.cornerRadius = 16
        
        editOutletButton.layer.cornerRadius = 16
        editOutletButton.backgroundColor = .primary1
        
        ProfileManager.shared.profiles
            .sink { [weak self] profiles in
                guard let self = self,
                      let index = self.indexPath?.row,
                      profiles.indices.contains(index) else { return }

                self.profile = profiles[index]
                self.updateUI()
            }
            .store(in: &cancel)

    }
    
    func updateUI() {
        guard let profile = profile else { return }
        fullName.text = profile.fullName
        bmiLabel.text = String(format: "%.2f", profile.bmi)
        weightLabel.text = "\(profile.weight) kg"
        heightLabel.text = "\(profile.height) cm"
        genderLabel.text = profile.gender
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteProfile() {
        let deleteVC = DeleteVC()
        deleteVC.indexPath = self.indexPath
        
//        let deleteNaviVC = UINavigationController(rootViewController: deleteVC)
//        deleteNaviVC.modalPresentationStyle = .fullScreen
            
        deleteVC.onDelete = { [weak self] in
            guard let self = self else { return }
                
            if !ProfileManager.shared.profiles.value.contains(self.profile!) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.present(deleteVC, animated: true)

//        guard let index = indexPath?.row else { return }
//        var current = manager.profiles.value
//        guard current.indices.contains(index) else { return }
//        current.remove(at: index)
//        manager.profiles.send(current)
        
//        navigationController?.popViewController(animated: true)
    }
}

