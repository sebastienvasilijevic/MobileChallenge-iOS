//
//  Constants.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import UIKit

struct kMC {
    /// Differents URL available in the app
    struct URL {
        static let main = "https://graphbrainz.herokuapp.com"
    }
    
    /// Differents UI constants
    struct UI {
        static let margins: CGFloat = 15
    }
    
    /// Colots available in Assets
    struct Colors {
        static let main = UIColor(named: "mainColor")!
        static let highlight = UIColor(named: "highlightColor")!
        static let orange = UIColor(named: "orangeColor")!
        
        struct Text {
            static let primary = UIColor(named: "textColor")!
            static let secondary = UIColor(named: "textSecondaryColor")!
            static let onMain = UIColor(named: "textOnMainColor")!
        }
        
        struct Background {
            static let primary = UIColor(named: "backgroundColor")!
            static let secondary = UIColor(named: "secondaryBackgroundColor")!
        }
    }
    
    /// Different fonts
    struct Font {
        static let regular: UIFont = .systemFont(ofSize: defaultSize)
        static let italic: UIFont = .italicSystemFont(ofSize: defaultSize)
        static let bold: UIFont = .boldSystemFont(ofSize: defaultSize)
        static let defaultSize: CGFloat = UIFont.systemFontSize
    }
    
    /// Images names
    struct Images {
        // Images in Assets
        static let arrowDown: String = "arrowDown"
        static let noPictureImage: String = "noPictureImage"
        
        // Images in SF Symbols
        static let magnifyingglass: String = "magnifyingglass"
        static let bookmark: String = "bookmark"
        static let bookmarkFill: String = "bookmark.fill"
    }
    
    /// Differents date formats
    struct DateFormat {
        static let api: String = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let readable: String = "dd MMM yyyy à HH:mm"
    }
}
