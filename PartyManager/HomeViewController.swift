//
//  HomeViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/04.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var startParty: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func startPartyTapped(_ sender: UIButton) {
//        self.performSegue(withIdentifier: Segue.startingParty, sender: self)
    }
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
//        self.notes = CoreDataHelper.retrieveNotes()
        
    }

}
