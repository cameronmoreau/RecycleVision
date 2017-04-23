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
    
    var cancelAction: (() -> Void)?
    var MoreInfoAction: (() -> Void)?
    @IBAction func cancel() {
        cancelAction?()
    }
    
    @IBAction func moreInfo() {
        MoreInfoAction?()
    }

}
