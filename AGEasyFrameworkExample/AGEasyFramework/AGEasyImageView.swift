//
//  EasyImageView.swift
//  Easy
//
//  Created by Alex Gibson on 1/1/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

@IBDesignable class AGEasyImageView: UIImageView {

    // track API Key
    @IBInspectable var parsingKey: String = String()
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

}
