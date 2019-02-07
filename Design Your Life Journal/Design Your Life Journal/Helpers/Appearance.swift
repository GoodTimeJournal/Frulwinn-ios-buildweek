//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

enum Appearance {
    
    static func montserratBoldFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Bold", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .callout).scaledFont(for: font)
    }
    
    static func montserratRegularFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Regular", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .callout).scaledFont(for: font)
    }
    
    static func setAppearance() {
        //navigationbar
        
        UINavigationBar.appearance().barTintColor = .skyBlue
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 21)!]
        
        //bar button item
        UIBarButtonItem.appearance().tintColor = .white
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 15)!, NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        //labels
        UILabel.appearance().textColor = .darkBlue
        UILabel.appearance().font = UIFont(name: "Montserrat-Regular", size: 15)
        
    }
    
    static func style(button: UIButton) {
        button.titleLabel?.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitleColor(.skyBlue, for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        button.layer.cornerRadius = 8
    }
}
