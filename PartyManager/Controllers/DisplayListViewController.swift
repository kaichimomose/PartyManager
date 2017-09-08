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
    @IBOutlet weak var unitLabel: UILabel!
    
    var unit: ManageViewController?
    var list: List?
    var partyNameAndFeel: PartyNameAndFeel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unit = unit{
        unitLabel.text = unit.unitSelect()
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let list = list {
        // 2
            listNameTextField.text = list.name
            listVolumeTextField.text = list.volume
        
        } else {
            // 3
            listNameTextField.text = ""
            listVolumeTextField.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listDrinksTableViewController = segue.destination as! ListDrinksTableViewController
        if segue.identifier == "save" {
            if let list = list {
                // 1
                list.name = listNameTextField.text ?? ""
                list.volume = listVolumeTextField.text ?? ""
                
                listDrinksTableViewController.tableView.reloadData()
            } else {
                // 3
                let newList = List()
                newList.name = listNameTextField.text ?? ""
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
                newList.strength = strength
                newList.volume = listVolumeTextField.text ?? ""
                newList.drinkTime = Date()
                listDrinksTableViewController.lists.append(newList)
            }
        }
    }
    
}
