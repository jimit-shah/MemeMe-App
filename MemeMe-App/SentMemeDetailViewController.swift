//
//  SentMemeDetailViewController.swift
//  MemeMe-App
//
//  Created by Jimit Shah on 6/29/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController {
  
  
  // MARK: Properties
  
  var meme: Meme!
  
  // MARK: Outlets
  @IBOutlet weak var imageView: UIImageView!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tabBarController?.tabBar.isHidden = true
    self.imageView!.image = meme.memedImage
    self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }
  
  // Get MemeEditorViewController with saved properties
  override func setEditing(_ editing: Bool, animated: Bool) {
    if editing {
      let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
      memeEditorViewController.topText = self.meme.topText
      memeEditorViewController.bottomText = self.meme.bottomText
      memeEditorViewController.originalImage = self.meme.originalImage
      self.present(memeEditorViewController, animated: true, completion: startOver)
    }
  }
  
  // PopToRootViewController
  func startOver() {
    if let navigationController = self.navigationController {
      navigationController.popToRootViewController(animated: true)
    }
  }
  
}
