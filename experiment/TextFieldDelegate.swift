//
//  TextFieldDelegate.swift
//  experiment
//
//  Created by Tony Chen on 5/19/17.
//  Copyright © 2017 Tony Chen. All rights reserved.
//

import Foundation
import UIKit


class TextFieldDelegate : NSObject, UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text == "TOP" || textField.text == "BOTTOM"){
            textField.text = ""
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
