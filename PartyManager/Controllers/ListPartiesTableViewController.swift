//
//  ListPartyTableViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/08.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class ListPartyTableViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var recaps = [Recap]()
    {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recaps = CoreDataHelper.retrieveRecap()
    }
    
    @IBAction func unwindToDrinkListViewController(_ segue: UIStoryboardSegue) {
        
        self.recaps = CoreDataHelper.retrieveRecap()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showParty" {
                print("Table view cell tapped")
//                // 1
//                let indexPath = tableView.indexPathForSelectedRow!
//                // 2
//                let list = lists[indexPath.row]
//                // 3
//                let displayListViewController = segue.destination as! DisplayListViewController
//                // 4
//                displayListViewController.list = list
            }
        }
    }
    
}

extension ListPartyTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listPartyTableViewCell", for: indexPath) as! ListPartyTableViewCell
        // 1
        let row = indexPath.row
        
        // 2
        let recap = recaps[row]
        
        // 3
        cell.partyNameLabel.text = recap.partyName
        
        cell.feelingLabel.text =  recap.feeling
        
        cell.amountLabel.text = recap.amount
        
        cell.drinksLabel.text = recap.drinks
        // 4
        cell.hoursLabel.text = recap.hours
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            //1
            CoreDataHelper.delete(recap: recaps[indexPath.row])
            //2
            recaps = CoreDataHelper.retrieveRecap()
        }
    }
    
}
