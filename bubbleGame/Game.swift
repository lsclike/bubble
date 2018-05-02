//
//  Game.swift
//  bubbleGame
//
//  Created by Master_Cloud on 30/4/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import Foundation

class Game{
    var bubbles = [Bubble]()
    var maxOfBubbles = 15
    var time = 60
    var numOfBubbles:Int {
       return  bubbles.count
    }
    init(){
        let firstnumberOfBubbles = arc4random_uniform(UInt32(self.maxOfBubbles+1))
        pickBubbleColour(numberOfBubbles: Int(firstnumberOfBubbles))
    }
    
    func pickBubbleColour(numberOfBubbles:Int){
        for _ in 0...numberOfBubbles{
            switch drand48(){
            case 0..<0.05:
                bubbles.append(Bubble(colour: "black"))
            case 0.05..<0.15:
                bubbles.append(Bubble(colour: "blue"))
            case 0.15..<0.30:
                bubbles.append(Bubble(colour: "green"))
            case 0.30..<0.60:
                bubbles.append(Bubble(colour: "pink"))
            default:
                bubbles.append(Bubble(colour: "red"))
            }
        }
    }
    
    func changeBubbles(){
        var remainBubbles:Int
        let remainPosition:Int
        var finalChange:Int
        bubbles = bubbles.filter{ $0.touched == false}
        remainBubbles = bubbles.count
        remainPosition = maxOfBubbles - remainBubbles
        finalChange = Int(arc4random_uniform(UInt32(remainPosition+1))) - Int(arc4random_uniform(UInt32(remainBubbles+1)))
        if finalChange > 0 {
            pickBubbleColour(numberOfBubbles: finalChange)
            finalChange = 0
        } else {
            while (finalChange < 0) {
                let indexOfBubbles = Int(arc4random_uniform(UInt32(remainBubbles)))
                bubbles.remove(at: indexOfBubbles)
                finalChange += 1
                remainBubbles -= 1
            }
        }
    }
    
    func touchBubbles(at bubble:Int){
        bubbles[bubble].touched = true
    }
}
