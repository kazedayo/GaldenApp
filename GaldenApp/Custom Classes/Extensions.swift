//
//  Extensions.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 30/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print(error)
        }
        return nil
    }
}

extension String {
    var data: Data {
        return Data(utf8)
    }
}
