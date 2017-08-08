//
//  DisplayRecapViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/07.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit


class DisplayRecapViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameOfPartyLabel: UILabel!
    @IBOutlet weak var drinkNumberLabel: UILabel!
    @IBOutlet weak var drinkHourLabel: UILabel!
    @IBOutlet weak var drinkAmountLabel: UILabel!
    @IBOutlet weak var yourFeelingLabel: UILabel!
    var recap: Recap?
    
    var displayedList = CoreDataHelper.retrieveList()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        var drinkAmount = 0
        for i in 0..<displayedList.count{
            if let amount = displayedList[i].volume {
            drinkAmount += Int(amount)!
            }
        }
        // 4
//        cell.drinkTimeLabel.text = list.drinkTime?.convertToString()
        
//        nameOfPartyLabel.text = recaps.partyName
        drinkNumberLabel.text = "\(displayedList.count)"
        drinkHourLabel.text = "3"
        drinkAmountLabel.text = "\(drinkAmount)"
        yourFeelingLabel.text = "😆"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "notYet" {
                print("Table view cell tapped")
        } else if identifier == "gotIt" {
                print("+ button tapped")
                let recap = self.recap ?? CoreDataHelper.newRecap()
//                recap.partyname = listNameTextField.text ?? ""
                recap.feeling = yourFeelingLabel.text ?? ""
                recap.drinks = drinkNumberLabel.text ?? ""
                recap.hours = drinkHourLabel.text ?? ""
                recap.amount = drinkAmountLabel.text ?? ""
                CoreDataHelper.saveList()

            }
        }
    }

}
