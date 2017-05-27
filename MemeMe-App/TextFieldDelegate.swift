//
//  TextFieldDelegates.swift
//  MemeMe-App
//
//  Created by Jimit Shah on 5/26/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import Foundation
import UIKit


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}

