//
//  ViewController.swift
//  testaaaaaaa
//
//  Created by クワシマ・ユウキ on 2022/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    var imageViews: [UIImageView] = []
    var moveX: CGFloat = 0.0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 1...100 {
            let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: self.view.bounds.width - 100, height: self.view.bounds.height - 100))
            imageView.transform3D = CATransform3DTranslate(imageView.transform3D, CGFloat(i * -20), CGFloat(i * 20), CGFloat(i * 20))
            imageView.image = UIImage(named: "disco")
            imageViews.append(imageView)
            self.view.addSubview(imageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: self.view)
        
        let prevLocation = touch.previousLocation(in: self.view)
        
        let xdiff = location.x - prevLocation.x
        moveX = xdiff
        
        for i in 0..<imageViews.count{
            imageViews[i].transform3D = CATransform3DTranslate(imageViews[i].transform3D,  xdiff,-xdiff, 0)
            imageViews[i].alpha = 1 / (imageViews[i].frame.minX * 0.07)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(releaseFunc), userInfo: nil, repeats: true)
    }

    @objc func releaseFunc() {
        if abs(moveX) > 1 {
            moveX *= 0.93
        } else {
            timer?.invalidate()
        }
        for i in 0..<imageViews.count{
            imageViews[i].transform3D = CATransform3DTranslate(imageViews[i].transform3D,  moveX,-moveX, 0)
            imageViews[i].alpha = 1 / (imageViews[i].frame.minX * 0.07)
        }
    }

}

