//
//  ViewController.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/24/25.
//

import UIKit
import Combine


class ViewController: UIViewController {
    private let manager = ProfileManager.shared
    private var cancel = Set<AnyCancellable>()
    var indexPath: IndexPath?
    
    var profile: Profile?
    var tableView: ListVC?
    var index: Int?
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
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

//    var onDeleteProfile: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteProfile))
        
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

    
    @objc func deleteProfile() {
        guard let index = indexPath?.row else { return }

        var currentProfiles = manager.profiles.value
        guard currentProfiles.indices.contains(index) else { return }

        currentProfiles.remove(at: index)
        manager.profiles.send(currentProfiles)

        navigationController?.popViewController(animated: true)
    }
   }



//extension InformationVC: ResultDelegate {
   // func update(result: String) {
      
  //  }
//}

