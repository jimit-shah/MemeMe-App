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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
  }
  
  // MARK: Actions
  @IBAction func addMeme(_ sender: Any) {
    let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
    self.present(memeEditorViewController, animated: true, completion: nil)
  }

  // MARK: Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCollectionViewCell", for: indexPath)
    let meme = self.memes[indexPath.row]
    // set the image
    cell.imageView?.image = meme.memedImage
    
    return cell
  }
  
}
