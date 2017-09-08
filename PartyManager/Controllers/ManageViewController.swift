//
//  ManageViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/10.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController{

    @IBOutlet weak var unitSelector: UISegmentedControl!
    
    var unit = UnitofDrink()
    
    func unitSelect()-> String{
    switch unitSelector.selectedSegmentIndex {
    case 0:
    unit.unit = "ml"
    case 1:
    unit.unit = "fl oz"
    default:
    break
    }
        return unit.unit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

