//
//  DisplayListViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/06.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class DisplayListViewController: UIViewController {
    
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var strengthSelect: UISegmentedControl!
    @IBOutlet weak var listVolumeTextField: UITextField!
    var list: List?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let list = list {
//             2
            listNameTextField.text = list.name
            listVolumeTextField.text = list.volume
        
        } else {
            // 3
            listNameTextField.text = ""
            listVolumeTextField.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            // if note exists, update title and content
            let list = self.list ?? CoreDataHelper.newList()
            list.name = listNameTextField.text ?? ""
            var strength = ""
            
            switch strengthSelect.selectedSegmentIndex {
            case 0:
                strength = "weak"
            case 1:
                strength = "just right"
            case 2:
                strength = "strong"
            default:
                break
            }
            list.strength = strength
            list.volume = listVolumeTextField.text ?? ""
            list.drinkTime = Date() as NSDate
            CoreDataHelper.saveList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
