//
//  TextFieldDelegates.swift
//  MemeMe-App
//
//  Created by Jimit Shah on 5/26/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TextFieldDelegate: NSObject, UITextFieldDelegate

class TextFieldDelegate: NSObject, UITextFieldDelegate {
  
  // Hide keyboard on pressing return
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // Clear default texts from text field
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if (textField.text == "TOP" || textField.text == "BOTTOM") {
      textField.text = ""
    }
  }
  
}

