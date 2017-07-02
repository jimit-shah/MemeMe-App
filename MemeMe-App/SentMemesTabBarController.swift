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
  
  var memes: [Meme]!
  
  let sentMemeTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName:UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "Impact", size: 15)!,
    NSStrokeWidthAttributeName: -3.0]
  
  // MARK: Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
  }
  
  
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
  
  func getDetailView(_ sender: UIViewController, indexPath: IndexPath) {
    
    let detailController = sender.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
    
    detailController.meme = self.memes[(indexPath as NSIndexPath).row]
    sender.navigationController!.pushViewController(detailController, animated: true)
  }
  
}
