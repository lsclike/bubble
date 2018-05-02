//
//  bubble.swift
//  bubbleGame
//
//  Created by Master_Cloud on 30/4/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import Foundation


struct Bubble {
    var colour:String
    var score:Int
    var touched:Bool
    private var colourValue = ["red":1,"pink":2,"green":5,"blue":8,"black":10]
    

    init(colour:String){
        self.colour = colour
        self.score = colourValue["\(colour)"]!
        self.touched = false
    }
}

