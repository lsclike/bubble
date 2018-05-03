//
//  Game.swift
//  bubbleGame
//
//  Created by Master_Cloud on 30/4/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import Foundation
import UIKit

class Game{
    var bubbles = [Bubble]()
    var maxOfBubbles = 15
    var time = 60
    init(){
        let firstnumberOfBubbles = arc4random_uniform(UInt32(self.maxOfBubbles+1))+1
        generateUnverifyButtons(numOfBubble: Int(firstnumberOfBubbles))
        finalBubbles(numOfBubble: Int(firstnumberOfBubbles))
    }
    
    
    func generateUnverifyButtons(numOfBubble:Int) {
        for _ in 0..<numOfBubble {
            bubbles.append(Bubble())
        }
    }
    
    func overlapWithOther() -> Bool{
        for index0 in 0..<(bubbles.count-1) {
            for index1 in (index0+1)..<bubbles.count{
                if bubbles[index0].frame.intersects(bubbles[index1].frame){
                    return true
                }
            }
        }
        return false
    }
    
    func finalBubbles(numOfBubble: Int){
        while overlapWithOther(){
            generateUnverifyButtons(numOfBubble: numOfBubble)
        }
    }
    
    func singleOverlap(testBubble:Bubble,remainBubbles:[Bubble]) -> Bool{
        for index in 0..<remainBubbles.count {
            if testBubble.frame.intersects(remainBubbles[index].frame){
                return true
            }
        }
        return false
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
            while finalChange > 0{
                var testBubble = Bubble()
                while singleOverlap(testBubble: testBubble, remainBubbles:bubbles){
                   testBubble = Bubble()
                }
                bubbles.append(testBubble)
                finalChange -= 1
            }
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
