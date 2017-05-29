//
//  MemeEditorViewController.swift
//  Meme Generator
//
//  Created by Tony Chen on 5/18/17.
//  Copyright © 2017 Tony Chen. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    
    let textDelegate = TextFieldDelegate()
    
    
    
    
    
    let memeTextAttributes: [String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSStrokeWidthAttributeName: -2.0
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config(topTextField, defaultText: "TOP")
        config(bottomTextField, defaultText: "BOTTOM")
    
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }
    
    func config(_ textField: UITextField, defaultText: String){
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
        textField.delegate = textDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(ImagePickerView.image == nil){
            shareButton.isEnabled = false
        }else{
            shareButton.isEnabled = true
        }
        
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ImagePickerView.contentMode = .scaleAspectFit
            ImagePickerView.image = image
        }else {
            print("Error")
        }
        self.dismiss(animated: true, completion: nil)
    
    }

    @IBAction func pickAnImage(_ sender: Any) {
        image(.photoLibrary)

    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        image(.camera)
    }
    
    func image(_ source: UIImagePickerControllerSourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification:Notification){
        if(bottomTextField.isFirstResponder){
            view.frame.origin.y = 0 - getKeyboardHeight(notification)

        }
    }
    
    func keyboardWillHide(_ notification: Notification){
        if(bottomTextField.isFirstResponder){
            view.frame.origin.y = 0
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    

    
    func save(){
        let meme = Memes(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: ImagePickerView.image!, memedImage: generateMemeImage())
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        print(appDelegate.memes.count)
    }
    
    
    func generateMemeImage() -> UIImage {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        toolBar.isHidden = true
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        toolBar.isHidden = false
        
        return memedImage
    }

    @IBAction func shareAction(_ sender: Any) {
        
        let meme = generateMemeImage()
        
        let activityController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            activity, success, items, error in
            if success{
                self.save()
                self.dismiss(animated: true, completion: nil)
                self.backToSent()
            } else {
                print("Error saving")
            }
        }
        
        self.present(activityController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        ImagePickerView.image = nil
        shareButton.isEnabled = false
        
        self.backToSent()
        
    }
    
    func backToSent(){
    
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}

