//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Seyit Behrullah ATEŞ on 3.12.2024.
//

import UIKit

class ViewController: UIViewController {
    // Değişkenler
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //views
    @IBOutlet weak var timeLabal: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        
        
        //Scored
        
        let storedHighScore=UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        // images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increageScore))
        
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        //Sayac
        
        counter = 10
        
        timeLabal.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        //Hide Timer
        
        hideKenny()
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
    }
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increageScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabal.text = "\(counter)"
        if(counter==1){
            timer.invalidate() // Sayacı durdur.
            hideTimer.invalidate()
            
            //High Score
            if self.score>self.highScore{
                self.highScore=self.score
                highScoreLabel.text = "High Score : \(self.highScore)"
                UserDefaults.standard.set(self.highScore,forKey: "highscore")
            }
            
            // Alert
            let alert = UIAlertController(title: "Times Up", message: "Do You want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButon = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                // Replay Funciton
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabal.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButon)
            alert.addAction(replayButton)
            self.present(alert,animated: true,completion: nil)
            for kenny in kennyArray{
                kenny.isHidden = true
            }
        }
        
    }

}

