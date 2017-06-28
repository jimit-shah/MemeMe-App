//
//  MemeCollectionViewController.swift
//  MemeMe-App
//
//  Created by Jimit Shah on 6/21/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
  
  // MARK: Properties
  
  var memes: [Meme]!
  
  // MARK: Outlets
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  // MARK: Actions
  
  @IBAction func addMeme(_ sender: Any) {
    let memeEditorViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
    self.present(memeEditorViewController, animated: true, completion: nil)
  }

  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    adjustFlowLayout(size: view.frame.size)
  }
  
  // MARK: Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Fetch data from App Deligate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
    
    // Reload data in collection view
    collectionView?.reloadData()
  }
  
  
  func adjustFlowLayout(size: CGSize) {
    let space: CGFloat = 3.0
    let dimension:CGFloat = size.width > size.height ? (size.width - (4 * space)) / 5.0 : (size.width - (2 * space)) / 3.0
    flowLayout.minimumLineSpacing = space
    flowLayout.minimumInteritemSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }
  
  // MARK: Collection View Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
    let meme = self.memes[(indexPath as NSIndexPath).row]
    
    cell.sentMemeImageView.image = meme.memedImage
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // add code for detailViewcontroller
  }
  
  
}
