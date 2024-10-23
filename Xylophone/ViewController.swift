import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer : AVAudioPlayer?
    let soundArray = ["A","B","C","D","E","F","G"]
    
    @IBOutlet weak var noteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func press(_ sender: UIButton) {
        var selectedSound = soundArray[(sender.tag) - 1]
        
        playsound(choosedSound: selectedSound)
        
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Изменение прозрачности кнопки при нажатии
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        UIView.animate(withDuration: 0.2,
                               delay: 0,
                               usingSpringWithDamping: 0.3,
                               initialSpringVelocity: 0.5,
                               options: .curveEaseInOut,
                               animations: {
                                   sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                               }, completion: { _ in
                                   sender.transform = .identity
                               })
    }
    
    func playsound(choosedSound : String){
        let soundurl = Bundle.main.url(forResource: choosedSound, withExtension: ".wav")
        do{
            audioPlayer?.stop()
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundurl!)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
        catch{
            print(error)
        }
    }
}

