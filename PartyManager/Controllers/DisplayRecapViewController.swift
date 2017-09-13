//
//  DisplayRecapViewController.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/07.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit


class DisplayRecapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var nameOfPartyLabel: UILabel!
    @IBOutlet weak var drinkNumberLabel: UILabel!
    @IBOutlet weak var drinkHourLabel: UILabel!
    @IBOutlet weak var drinkAmountLabel: UILabel!
    @IBOutlet weak var yourFeelingLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var time: Int?
//    var unit: ManageViewController?

    let photoHelper = MGPhotoHelper()
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
        present(alertController, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { [unowned self] action in
                self.presentImagePickerController(with: .camera, from: self)
            })
            
            alertController.addAction(capturePhotoAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { [unowned self] action in
                self.presentImagePickerController(with: .photoLibrary, from: self)
            })
            
            alertController.addAction(uploadAction)
        }

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

//        photoHelper.presentActionSheet(from: self)
//        
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//
//        imagePickerController.delegate = self
        
//        present(imagePickerController, animated: true, completion: nil)
       
    }
    
    func presentImagePickerController(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        
        viewController.present(imagePickerController, animated: true)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected an Image, but was provided \(info)")
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }
    
    var recap: Recap?
    var lists: [List]?
    
    var partyNameAndFeel = PartyNameAndFeel(){
        didSet {
           view.reloadInputViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var drinkAmount = 0
        if let lists = lists {
        for i in 0..<lists.count{
            drinkAmount += Int(lists[i].volume)!
        }
        drinkNumberLabel.text = "\(lists.count)"
        }
        nameOfPartyLabel.text = partyNameAndFeel.nameOfParty
        
        if let time = time{
            let seconds = Int(time % 60)
            let minutes = Int((time / 60) % 60)
            let hours = Int(time / 3600)
            
            drinkHourLabel.text = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        }
        
        drinkAmountLabel.text = "\(drinkAmount)"
        yourFeelingLabel.text = partyNameAndFeel.feeling
        
        
        
//        if let unit = unit{
//            switch unit.unitSelector.selectedSegmentIndex{
//            case 0:
//                unit.unit = "ml"
//            case 1:
//                unit.unit = "fl oz"
//            default:
//                break
//            }
//            unitLabel.text = unit.unit
//        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "notYet" {
                print("Table view cell tapped")
                let partyNameAndFeeling = segue.destination as! ListDrinksTableViewController
                // 4
                partyNameAndFeeling.partyNameAndFeel = partyNameAndFeel
        } else if identifier == "gotIt" {
                print("+ button tapped")
                
                let recap = self.recap ?? CoreDataHelper.newRecap()
                recap.partyName = nameOfPartyLabel.text ?? ""
                recap.feeling = yourFeelingLabel.text ?? ""
                recap.drinks = drinkNumberLabel.text ?? ""
                recap.hours = drinkHourLabel.text ?? ""
                recap.amount = drinkAmountLabel.text ?? ""
                let imageData = UIImagePNGRepresentation(photoImageView.image!) as NSData?
                recap.partyPhoto = imageData
                let setZero = segue.destination as! HomeViewController
                // 4
                
                CoreDataHelper.saveRecap()
                setZero.timer.invalidate()
                setZero.time = 0
                

            }
        }
    }
    
}
