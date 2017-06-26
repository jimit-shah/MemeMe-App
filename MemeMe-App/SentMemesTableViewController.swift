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
  
  let memeTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName:UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "Impact", size: 15)!,
    NSStrokeWidthAttributeName: -3.0]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    if (memes?.count) != nil {
//      let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
//      self.present(memeEditorViewController, animated: true, completion: nil)
//    }
  }
  
  // MARK: Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //print("\nIn SentMemesTableViewController.viewWillAppear..")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
    //print("memes: \(memes)")
    tableView.reloadData()
    
    if memes.count == 0 {
      let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
      self.present(memeEditorViewController, animated: true, completion: nil)
    }
    
  }
  
  // MARK: Actions
  
  @IBAction func addMeme(_ sender: Any) {
    let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
    self.present(memeEditorViewController, animated: true, completion: nil)
  }

  // MARK: Table View Data Source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("self.memes.count \(self.memes.count)")
    return self.memes.count
  }
  
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableViewCell", for: indexPath) as! SentMemeTableViewCell
    
    let meme = self.memes[indexPath.row]
    
    // set the image and texts
    
    cell.sentMemeImageView?.image = meme.originalImage
    configure(textfield: cell.top, withText: meme.topText)
    configure(textfield: cell.bottom, withText: meme.bottomText)
    
    cell.label?.text = "\(meme.topText)...\(meme.bottomText)"
    
    return cell
  }
  
  func configure(textfield: UITextField, withText: String) {
    textfield.text = withText
    textfield.defaultTextAttributes = memeTextAttributes
    textfield.textAlignment = .center
  }

  
}