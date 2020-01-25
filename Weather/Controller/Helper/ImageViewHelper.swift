//
//  ImageViewHelper.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 24/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import UIKit
import GLKit

extension UIImageView {
    public func weatherImage(iconName : String){
        var temp = ""
        
        switch iconName {
        case "03d" : temp = "02d"
        case "03n" : temp = "02n"
        case "04d" : temp = "02d"
        case "04n" : temp = "02n"
        case "09n" : temp = "09d"
        case "11n" : temp = "11d"
        case "13n" : temp = "13d"
        case "50d" : temp = "02d"
        case "50n" : temp = "02n"
        default : temp = iconName
        }
        
        self.image = UIImage(named: temp)
        self.contentMode = .scaleAspectFit
    }
    
    func rotate(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations:  {
            self.transform = CGAffineTransform.identity
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations:  {
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            }) { _ in
                self.rotate()
            }
        }
    }
}
