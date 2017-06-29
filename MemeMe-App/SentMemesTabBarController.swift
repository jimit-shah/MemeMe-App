//
//  SentMemesTabBarControllerViewController.swift
//  MemeMe-App
//
//  Created by Jimit Shah on 6/27/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import UIKit

class SentMemesTabBarController: UITabBarController {

  // MARK: Properties
  
  let sentMemeTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName:UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "Impact", size: 15)!,
    NSStrokeWidthAttributeName: -3.0]

  // MARK : Methods
  
  func configureTextFields(textfield: UITextField, withText: String) {
    textfield.defaultTextAttributes = sentMemeTextAttributes
    textfield.text = withText
    textfield.textAlignment = .center
  }

  func getMemeEditor(viewController: UIViewController) {
    let memeEditorViewController = viewController.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
    viewController.present(memeEditorViewController, animated: true, completion: nil)
    
  }
}
