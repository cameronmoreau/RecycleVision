//
//  RecyclableDialogView.swift
//  RecycleVision
//
//  Created by Mary Huerta on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import Foundation
import SwiftMessages

class RecyclableDialogView: MessageView {
    

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var cancelAction: (() -> Void)?
    var moreInfoAction: (() -> Void)?
    
    @IBAction func cancel() {
        cancelAction?()
    }
    
    @IBAction func moreInfo() {
        moreInfoAction?()
    }

}
