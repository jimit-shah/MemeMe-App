//
//  SentMemesTableViewController.swift
//  MemeMe-App
//
//  Created by Jimit Shah on 6/21/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
  
  // MARK: Properties
  
  var memes: [Meme]!
  
  // MARK: Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //print("\nIn SentMemesTableViewController.viewWillAppear..")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
    
    // Reload data
    tableView.reloadData()
    
    // If no Meme saved then launch Meme Editor
    if memes.count == 0 {
      let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
      self.present(memeEditorViewController, animated: true, completion: nil)
    }
    
  }
  
  // MARK: Actions
  
  @IBAction func addMeme(_ sender: Any) {
    if let tbc = self.tabBarController as? SentMemesTabBarController {
      tbc.getMemeEditor(viewController: self)
    }
  }
  
  
  // MARK: Table View Data Source
  
  // numberOfRowsInSection
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //print("self.memes.count \(self.memes.count)")
    return self.memes.count
  }
  
  // heightForRowAt
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  // cellForRowAt
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableViewCell", for: indexPath) as! SentMemeTableViewCell
    
    let meme = self.memes[indexPath.row]
    
    // set the image and texts
    
    cell.sentMemeImageView?.image = meme.originalImage
    
    if let tbc = self.tabBarController as? SentMemesTabBarController {
      tbc.configureTextFields(textfield: cell.topTextField, withText: meme.topText)
      tbc.configureTextFields(textfield: cell.bottomTextField, withText: meme.bottomText)
    }
    
    cell.label?.text = "\(meme.topText)...\(meme.bottomText)"
    
    return cell
  }
  
  // MARK: Instantiate Detail View Controller
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let tbc = self.tabBarController as? SentMemesTabBarController {
      tbc.getDetailView(self, indexPath: indexPath)
    }
  }
  
}
