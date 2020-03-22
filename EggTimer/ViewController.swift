

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var processView: UIProgressView!
    
    var eggTimes=["Soft":3,"Medium":4,"Hard":7]
    var timer=Timer()
    var totalTime=0
    var secondsPassed=0
    
    var audioPlayer = AVAudioPlayer()
    
//    override func viewDidLayoutSubviews() {
//        processView.progress=0
//    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime=eggTimes[hardness]!
        processView.progress=0
        secondsPassed=0
        label.text=hardness
        
        
    
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        let sound=Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")
                  do{
                  audioPlayer=try AVAudioPlayer(contentsOf:  URL(fileURLWithPath:sound!))
                  }
                  catch{
                      print(error)
                  
              }
        
        
    }
    
    @objc func updateCounter() {
        if secondsPassed<totalTime{
            let percentageProgress=Float(secondsPassed)/Float(totalTime)
            secondsPassed += 1
            print(percentageProgress )
            processView.progress=percentageProgress
            
            
        }
        else {
            timer.invalidate()
            label.text="Done!"
            processView.progress=1
          
        
            audioPlayer.play()
    }
    
}
}
