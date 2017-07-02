//
//  ViewController.swift
//  Image Picker
//
//  Created by Jimit Shah on 5/20/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class MemeEditorViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var imagePickerView: UIImageView!
  
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  
  var topText = "TOP"
  var bottomText = "BOTTOM"
  var originalImage: UIImage? = nil
  
  // MARK: Text Field Delegate object
  let textFieldDelegate = TextFieldDelegate()
  
  // MARK: Properties
  let memeTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName:UIColor.black,
    NSForegroundColorAttributeName: UIColor.white,
    NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
    NSStrokeWidthAttributeName: -3.0]
  
  func resetControls() {
    topTextField.text = topText
    bottomTextField.text = bottomText
    enableBarButton(shareButton)
  }
  
  // MARK: Actions
  
  // MARK: Action Cancel to reset image editor.
  @IBAction func cancelButton(_ sender: Any) {
    imagePickerView.image = originalImage
    resetControls()
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: Action Share memed image
  @IBAction func share(_ sender: Any) {
    let memedImage = generateMemedImage()
    let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    self.present(activityViewController, animated: true, completion: nil)
    
    // UIActivityViewControllerCompletionWithItemsHandler
    activityViewController.completionWithItemsHandler = {
      (activity, success, items, error) in
      if success{
        self.save() // call save- which is in progress.
        self.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  // MARK: Action Pick an Image
  @IBAction func pickAnImage(_ sender: AnyObject) {
    if sender.tag == 1 {
      getImagePickerController(.camera)
    } else {
      getImagePickerController(.photoLibrary)
    }
  }
  
  func configure(textfield: UITextField, withText: String) {
    textfield.text = withText
    textfield.delegate = textFieldDelegate
    textfield.defaultTextAttributes = memeTextAttributes
    textfield.textAlignment = .center
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(textfield: self.topTextField, withText: topText)
    configure(textfield: self.bottomTextField, withText: bottomText)
    imagePickerView.image = originalImage
    enableBarButton(cancelButton)
    enableBarButton(shareButton)
  }
  
  func enableBarButton(_ barButton: UIBarButtonItem) {
    if barButton.tag == 2 {
      barButton.isEnabled = (originalImage != nil)
    } else {
      barButton.isEnabled = true
    }
  }
  
  // Hide Status Bar
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let memes = appDelegate.memes
    if memes.count == 0 {
      cancelButton.isEnabled = false
    }
    
    // Enable Camera Button if hardware is available
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  func keyboardWillShow(_ notification:Notification) {
    if bottomTextField.isFirstResponder {
      view.frame.origin.y = -getKeyboardHeight(notification)
    }
  }
  
  func keyboardWillHide(_ notification:Notification) {
    view.frame.origin.y = 0
  }
  
  // MARK: Get Keyboard Height
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.cgRectValue.height
  }
  
  // MARK: Subscribe to Keyboard Notifications
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  // MARK: Unsubscribe to Keyboard Notifications
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  func generateMemedImage() -> UIImage {
    
    hideNavbarAndToolbar(true)
    
    // Render View to an Image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    imagePickerView.backgroundColor = .white
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    hideNavbarAndToolbar(false)
    
    return memedImage
  }
  
  // MARK: Hide/Show Toolbar and Navbar
  func hideNavbarAndToolbar(_ hide: Bool) {
    toolbar.isHidden = hide
    navigationBar.isHidden = hide
  }
  
  // MARK: Method Save
  func save() {
    // Create the meme
    let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    
    // Add it to the memes array on the Application Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.memes.append(meme)
    
  }
  
}


// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: Image Picker Controller
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      imagePickerView.image = image
      resetControls()
    }
    dismiss(animated: true, completion: { () -> Void in
      self.shareButton.isEnabled = true
    })
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func getImagePickerController(_ sourceType: UIImagePickerControllerSourceType) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = sourceType
    self.present(imagePickerController, animated: true, completion: nil)
  }
  

  
}



