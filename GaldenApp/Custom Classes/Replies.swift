//
//  Replies.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 5/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

class Replies {
    var name: String
    var level: String
    var content: String
    var contentAttr: NSAttributedString
    var avatar: String
    var date: String
    var gender: String
    var quoteID: String
    
    init(n: String,l: String,c: String,cA: NSAttributedString,a: String,d: String,g: String,qid: String) {
        name = n
        level = l
        content = c
        contentAttr = cA
        avatar = a
        date = d
        gender = g
        quoteID = qid
    }
}
