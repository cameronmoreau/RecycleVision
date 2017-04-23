//
//  CardViewController.swift
//  RecycleVision
//
//  Created by Mary Huerta on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit
import MapKit

class CardViewController: UIViewController {
    
    
    @IBAction func sharePressed(_ sender: UIBarButtonItem) {
        
        
        
    }
    @IBAction func locationsPressed(_ sender: UIButton) {
        
        
        let q = "Recycle%20Dropoff"
        let url = URL(string: "http://maps.apple.com/?q=\(q)")!
        
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

    @IBOutlet var materialIcon: UIImageView!
    @IBOutlet var materialName: UILabel!
    @IBOutlet var Description: UILabel!
    @IBOutlet var location: UILabel!
    
    
    // I'm too lazzzy to make an model
    var material = ("metals", "paper", "cardboard", "glass", "plastics", "bulbs", "batteries",
                    "electronic")
    
    var materialImage = ( #imageLiteral(resourceName: "radio"), #imageLiteral(resourceName: "plasticBottle"), #imageLiteral(resourceName: "cardboard") )
    
    var materialDescription = ("Without scrap recycling, more mining would be required. ",
                               "Each ton of recycled paper can save 17 trees!",
                               "Recycling cardboard only takes 75% of the engery need than making new cardboard",
                               "Glass is fully recyclable. It can be recycled over and over again without losing purity",
                               "Only 23% of plastic bottles are recycled each year.",
                               "Some light bulbs can be hazardous if broken. Be careful!",
                               "Batteries contain toxic heavy metals which are dangerous when thrown into a landfil ")
    
    var materiallocation = ("Recycle Bin",
                            "Recycle Bin",
                            "Recycle Bin or Compost",
                            "Recycle Bin",
                            "Recycle Bin",
                            "Garbage Can",
                            "Dallas County Home Chemical Collection Center")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var name = "metals"
        switch(name){
        case material.0:
            materialIcon.image = materialImage.0
            materialName.text = material.0
           
        case material.1:
            materialIcon.image = materialImage.1
            materialName.text = material.1
        case material.2:
            materialIcon.image = materialImage.0
            materialName.text = material.2
        case material.3:
            materialIcon.image = materialImage.1
            materialName.text = material.3
        case material.4:
            materialIcon.image = materialImage.0
            materialName.text = material.4
        case material.5:
            materialIcon.image = materialImage.1
            materialName.text = material.5
        default:
            materialIcon.image = materialImage.1
            materialName.text = material.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
