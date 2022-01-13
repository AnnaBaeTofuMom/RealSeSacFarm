//
//  Extension.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation
import UIKit
import SnapKit


extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
    func textFieldDesign(text: String) {
      self.backgroundColor = .white
      self.layer.borderColor = UIColor(hue: 0.0528, saturation: 0.07, brightness: 0.87, alpha: 1.0).cgColor
      self.layer.borderWidth = 1
      self.placeholder = text
      self.layer.cornerRadius = 10
      self.addLeftPadding()
  }
}

extension UIButton: ObservableObject {
    func buttonDesign(text: String, unabledText: String) {
        self.backgroundColor = UIColor(hue: 0.7, saturation: 0.61, brightness: 0.91, alpha: 1.0)
        self.layer.cornerRadius = 10
        if self.isEnabled == true {
            self.setTitle(text, for: .normal)
        } else {
            self.setTitle(unabledText, for: .disabled)
           
        }
        
    }
}
