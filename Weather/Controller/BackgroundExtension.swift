//
//  BackgroundExtension.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 24/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    func setupBackground(){
        let backgroundView = UIView()
        backgroundView.frame = view.bounds
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
        backgroundView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = backgroundView.bounds
    }
    
    func setupBackgroundColor(time : String){
        _ = time.last == "d" ? setupDayBackground() : setupNightBackground()
    }
    
    func setupDayBackground(){
        let topColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        let bottomColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setupNightBackground(){
        let topColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        let bottomColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradientLayer.colors = [topColor, bottomColor]
    }
}
