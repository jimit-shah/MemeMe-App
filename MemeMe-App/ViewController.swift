//
//  ViewController.swift
//  Image Picker
//
//  Created by Jimit Shah on 5/20/17.
//  Copyright © 2017 Jimit Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // MARK: Text Field Delegate object
    let textFieldDelegate = TextFieldDelegate()
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName:UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]

    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }

    func setDefaultTexts() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    // MARK: Cancel Button to Clear/Reset Image and texts.
    @IBAction func cancelButton(_ sender: Any) {
        imagePickerView.image = nil
        setDefaultTexts()
    }
    
    // MARK: Share the Memed Image
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        // Hint for the 2.0 version
       // UIActivityViewControllerCompletionWithItemsHandler
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success{
                self.save() // call save- which is in progress.
                self.dismiss(animated: true, completion: nil)
            }
        }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultTexts()
        self.topTextField.delegate = textFieldDelegate
        self.bottomTextField.delegate = textFieldDelegate
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        cancelButton.isEnabled = true
        shareButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
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
    
    // MARK: Image Picker Controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
            setDefaultTexts()
        }
        dismiss(animated: true, completion: { () -> Void in
            self.shareButton.isEnabled = true
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Pick an Image from Album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: Pick an Image from Camera (If Hardaware is available)
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        toolbar.isHidden = true
        navigationBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        toolbar.isHidden = false
        navigationBar.isHidden = true
        
        return memedImage
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
}

