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
  
  let inset: CGFloat = 8.0
  let spacing: CGFloat = 8.0
  let lineSpacing: CGFloat = 8.0
  
  // MARK: Outlets
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  // MARK: Actions
  
  @IBAction func addMeme(_ sender: Any) {
    if let tbc = self.tabBarController as? SentMemesTabBarController {
      tbc.getMemeEditor(viewController: self)
    }
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //adjustFlowLayout(size: view.frame.size)
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    self.collectionView?.collectionViewLayout.invalidateLayout()
  }
  
  func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
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
  
  // MARK: Collection View Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
    let meme = self.memes[(indexPath as NSIndexPath).row]
    
    // set the image and texts
    
    cell.sentMemeImageView?.image = meme.originalImage
    
    if let tbc = self.tabBarController as? SentMemesTabBarController {
      tbc.configureTextFields(textfield: cell.topTextField, withText: meme.topText)
      tbc.configureTextFields(textfield: cell.bottomTextField, withText: meme.bottomText)
    }
    
    return cell
  }
  
  // MARK: Detail View Controller
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController
    detailViewController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(detailViewController, animated: true)
  }
  
}


// MARK: UICollectionViewDelegateFlowLayout

extension SentMemesCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let columns: CGFloat = collectionView.frame.width > collectionView.frame.height ? 5.0 : 3.0
    
    let dimension = Int((collectionView.frame.width / columns) - (inset + spacing))
    
    return CGSize(width: dimension, height: dimension)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
}
