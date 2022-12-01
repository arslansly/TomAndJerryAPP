//
//  ViewController.swift
//  TomAndJerryApp
//
//  Created by Süleyman Arslan on 1.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var jerryArray = [UIImageView]()
    //views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!

    @IBOutlet weak var jerry1: UIImageView!
    @IBOutlet weak var jerry2: UIImageView!
    @IBOutlet weak var jerry3: UIImageView!
    @IBOutlet weak var jerry4: UIImageView!
    @IBOutlet weak var jerry5: UIImageView!
    @IBOutlet weak var jerry6: UIImageView!
    @IBOutlet weak var jerry7: UIImageView!
    @IBOutlet weak var jerry8: UIImageView!
    @IBOutlet weak var jerry9: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        counter = 20
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideJerry), userInfo: nil, repeats: true)

        
        //resimler
        jerry1.isUserInteractionEnabled = true
        jerry2.isUserInteractionEnabled = true
        jerry3.isUserInteractionEnabled = true
        jerry4.isUserInteractionEnabled = true
        jerry5.isUserInteractionEnabled = true
        jerry6.isUserInteractionEnabled = true
        jerry7.isUserInteractionEnabled = true
        jerry8.isUserInteractionEnabled = true
        jerry9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        jerry1.addGestureRecognizer(recognizer1)
        jerry2.addGestureRecognizer(recognizer2)
        jerry3.addGestureRecognizer(recognizer3)
        jerry4.addGestureRecognizer(recognizer4)
        jerry5.addGestureRecognizer(recognizer5)
        jerry6.addGestureRecognizer(recognizer6)
        jerry7.addGestureRecognizer(recognizer7)
        jerry8.addGestureRecognizer(recognizer8)
        jerry9.addGestureRecognizer(recognizer9)
        
        jerryArray = [jerry1,jerry2,jerry3,jerry4,jerry5,jerry6,jerry7,jerry8,jerry9]
        
        hideJerry()

    }
    @objc func hideJerry(){
        
        for jerry in jerryArray{
            jerry.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(jerryArray.count - 1)))
        jerryArray[random].isHidden = false
        
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        print("Yakaladın.")
    }
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            print("Zaman Doldu.")
            timer.invalidate() // zamanlayıcı duracak.
            hideTimer.invalidate()
            
            for jerry in jerryArray{
                jerry.isHidden = true
            }
            
            if self .score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore,forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Zaman Bitti !", message: "Tekrar Oynamak İstermisin?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            let playButton = UIAlertAction(title: "Tekrar Oyna", style: .default){ (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideJerry), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(playButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        print("timer")
    }

}

