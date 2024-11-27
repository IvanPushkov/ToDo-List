

import UIKit

final class MicroPhoneButton: UIButton {
    var isRecording = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageViewToButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setImageViewToButton(){
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22)
        let image = UIImage(systemName: "mic.fill", withConfiguration: imageConfig)
        self.setImage(image, for: .normal)
        self.imageView?.tintColor = .searchTextColor
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func microphoneSwitch(){
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22)
        var image = UIImage()
        isRecording.toggle()
        if isRecording{
            image = UIImage(systemName: "record.circle", withConfiguration: imageConfig)!
        }  else{
             image = UIImage(systemName: "mic.fill", withConfiguration: imageConfig)!
        }
        self.setImage(image, for: .normal)
    }
    
}
