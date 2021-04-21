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
        static let grayLight = UIColor(named: "grayLight")!
        
        struct Text {
            static let primary = UIColor(named: "textColor")!
            static let secondary = UIColor(named: "textSecondaryColor")!
            static let onMain = UIColor(named: "textOnMainColor")!
        }
        
        struct Background {
            static let primary = UIColor(named: "backgroundColor")!
            static let secondary = UIColor(named: "secondaryBackgroundColor")!
            static let primaryReverse = UIColor(named: "backgroundReverseColor")!
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
        static let swipeGestureIcon: String = "swipeGestureIcon"
        
        // Images in SF Symbols
        static let magnifyingglass: String = "magnifyingglass"
        static let bookmark: String = "bookmark"
        static let bookmarkFill: String = "bookmark.fill"
        static let bookmarkCircle: String = "bookmark.circle"
        static let personCircleQuestionmark: String = "person.crop.circle.badge.questionmark"
        static let personCircleXmark: String = "person.crop.circle.badge.xmark"
    }
    
    /// UserDefault keys
    struct UserDefaults {
        static let tutoArtistDetailsPaging = "tutoArtistDetailsPaging"
    }
}
