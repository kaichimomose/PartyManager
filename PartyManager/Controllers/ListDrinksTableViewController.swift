//
//  ListDrinksTableViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/06.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit
import CoreData

class ListDrinksTableViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var feelingTextField: UITextField!
    @IBOutlet weak var partyNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timerView: UILabel!
    
    var timer = Timer()

    var partyNameAndFeel: PartyNameAndFeel?
    var time: Int?
    
    var lists = [List]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.partyNameTextField.delegate = self;
        self.feelingTextField.delegate = self;

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)

        
    }
    
    func counter() {
        time! += 1
        let seconds = Int(time! % 60)
        let minutes = Int((time! / 60) % 60)
        let hours = Int(time! / 3600)
        
        timerView.text = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let partyNameAndFeel = partyNameAndFeel {
            //             2
            partyNameTextField.text = partyNameAndFeel.nameOfParty
            feelingTextField.text = partyNameAndFeel.feeling
            
        } else {
            // 3
            partyNameTextField.text = ""
            feelingTextField.text = ""
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
        
    @IBAction func unwindToDrinkListViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayList" {
                print("Table view cell tapped")
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let list = lists[indexPath.row]
                // 3
                let displayListViewController = segue.destination as! DisplayListViewController
                // 4
                displayListViewController.list = list
            } else if identifier == "addList" {
                print("+ button tapped")
            } else if identifier == "finish"{
                let finishVC = segue.destination as! DisplayRecapViewController
                finishVC.lists = lists
                finishVC.time = time
                if let partyNameAndFeel = partyNameAndFeel{
                    partyNameAndFeel.nameOfParty = partyNameTextField.text ?? ""
                    partyNameAndFeel.feeling = feelingTextField.text ?? ""
                    finishVC.partyNameAndFeel = partyNameAndFeel
                    
                } else {
                    let newpartyNameAndFeel = PartyNameAndFeel()
                    newpartyNameAndFeel.nameOfParty = partyNameTextField.text ?? ""
                    newpartyNameAndFeel.feeling = feelingTextField.text ?? ""
                    finishVC.partyNameAndFeel = newpartyNameAndFeel
                }
            }
        }
    }
    
}

extension ListDrinksTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDrinksTableViewCell", for: indexPath) as! ListDrinksTableViewCell
        
        let row = indexPath.row
        
        let list = lists[row]
        
        cell.drinkNameLabel.text = list.name
        
        cell.drinkStrengthLabel.text =  list.strength
        
        cell.drinkVolumeLabel.text = list.volume
        
        cell.drinkTimeLabel.text = list.drinkTime.convertToString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            
            lists.remove(at: indexPath.row)
        }
    }

}


