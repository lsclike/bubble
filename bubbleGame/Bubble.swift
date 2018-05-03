//
//  bubble.swift
//  bubbleGame
//
//  Created by Master_Cloud on 30/4/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import Foundation
import UIKit

class Bubble: UIButton {
    var colour:String!
    var score:Int = 0
    var touched:Bool = false
    private var colourValue = ["red":1,"pink":2,"green":5,"blue":8,"black":10]
    

    required init(){
        super.init(frame: .zero)
        self.colour = pickColour()
        self.score = colourValue[self.colour]!
        giveImage(colour: colour)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pickColour() -> String {
        switch drand48(){
        case 0..<0.05:
            return "black"
        case 0.05..<0.15:
            return "blue"
        case 0.15..<0.30:
            return "green"
        case 0.30..<0.60:
            return "pink"
        default:
            return "red"
        }
    }
    
    func giveImage(colour: String){
        switch colour {
        case "red":
            self.setImage(UIImage(named: "red.jpg"), for: UIControlState.normal)
        case "blue":
            self.setImage(UIImage(named: "blue.jpg"), for: UIControlState.normal)
        case "green":
            self.setImage(UIImage(named: "green.jpg"), for: UIControlState.normal)
        case "pink":
            self.setImage(UIImage(named: "pink.jpg"), for: UIControlState.normal)
        default:
            self.setImage(UIImage(named: "black.jpg"), for: UIControlState.normal)
        }
    }
}

