//
//  keyRandom.swift
//  demoEncrypt
//
//  Created by MacPro on 2018/5/13.
//  Copyright © 2018年 JoeMac01. All rights reserved.
//

import Foundation
class keyRandom {
    var key: String
    
    init() {
        let keyAll = ["TestTestTestTest","AbcdAbcdAbcdAbcd","WhatWhatWhatWhat","GoesGoesGoesGoes","ComeComeComeCome"]
        let keyProduct = shuffleArray(arrayToBeShuffled: keyAll)
        key = keyProduct
        
    }
}

func shuffleArray(arrayToBeShuffled array1:[String]) -> String{
    var oldArray = array1
    var newArray = [String]()
    var randomNum:Int
    for _ in array1 {
        randomNum = Int(arc4random_uniform(UInt32(oldArray.count)))
        newArray.append(oldArray[randomNum])
        oldArray.remove(at: randomNum)
    }
    return newArray[0]
}
