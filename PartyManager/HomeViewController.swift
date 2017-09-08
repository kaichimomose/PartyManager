//
//  HomeViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/04.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    var time = 0
    var timer = Timer()
    
    @IBOutlet weak var startParty: UIButton!
    @IBOutlet weak var timerViewer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerViewer.isHidden = true
        
    }
    @IBAction func startPartyTapped(_ sender: UIButton) {

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
    
    }
    
    
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
//        self.notes = CoreDataHelper.retrieveNotes()
        
    }

    func counter(){
        time += 1
        UserDefaults.standard.set(time, forKey: "time")  //Integer
        let seconds = Int(time % 60)
        let minutes = Int((time / 60) % 60)
        let hours = Int(time / 3600)
        
        timerViewer.text = "\(hours):\(minutes):\(seconds)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "startingParty" {
                UserDefaults.standard.set(time, forKey: "time")  //Integer
                print("\(time)")
                let timer = segue.destination as! ListDrinksTableViewController
                // 4
                timer.time = UserDefaults.standard.integer(forKey: "time")
//                
//                UserDefaults.standard.set(time, forKey: "time")  //Integer
//                var time = UserDefaults.standard.integer(forKey: "time")
                
                
                
            }
        }
    }

}
