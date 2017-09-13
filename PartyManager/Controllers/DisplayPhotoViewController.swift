//
//  DisplayPhotoViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/10.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class DisplayPhotoViewController: UIViewController {
    var recap: Recap?
    
    @IBOutlet weak var partyPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recap = recap {
            let image = UIImage(data:recap.partyPhoto! as Data)
            partyPhoto.image = image
        }
    }
    
    
}
