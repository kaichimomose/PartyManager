//
//  ListDrinksTableViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/06.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit
import CoreData

class ListDrinksTableViewController: UIViewController{
    
    @IBOutlet weak var partyNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var recap: Recap?
    var party: Party?
    
    var lists = [List]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let recap = recap {
            //             2
            partyNameTextField.text = recap.partyName
            
        } else {
            // 3
            partyNameTextField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lists = CoreDataHelper.retrieveList()
    }
    
    @IBAction func unwindToDrinkListViewController(_ segue: UIStoryboardSegue) {
        
        self.lists = CoreDataHelper.retrieveList()
        
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
//                let party = self.party ?? CoreDataHelper.newParty()
//                party.list = tableView ?? ""
                CoreDataHelper.saveRecap()
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
        
        cell.drinkTimeLabel.text = list.drinkTime?.convertToString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            //1
            CoreDataHelper.delete(list: lists[indexPath.row])
            //2
            lists = CoreDataHelper.retrieveList()
        }
    }

}

extension ListDrinksTableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let party = self.party ?? CoreDataHelper.newParty()
//
//        party.list = lists[indexPath.row]
//        
//        
//        
//        
//        CoreDataHelper.saveParty()
    }
    
}



